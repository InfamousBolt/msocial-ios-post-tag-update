import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;

import '../components/picker.dart';
import '../imports.dart';

class AppUploader with EquatableMixin {
  static final uploaders = <AppUploader>[];
  FileModel? picked;

  FileModel? uploaded;
  final _state = UploadState.initial().obs;
  bool get isPicked =>
      state.maybeMap(orElse: () => picked?.path.isNotEmpty == true);

  bool get isUploading =>
      state.maybeMap(uploading: (_) => true, orElse: () => false);
  @override
  List<Object> get props => [path];

  UploadState get state => _state();
  @override
  bool get stringify => true;

  void clear() {
    AppUploader.uploaders.remove(this);
    picked = null;
  }

  String path([String? or]) => state.maybeWhen(
        orElse: () => picked?.path ?? or ?? '',
      );

  Future<void> pick(
    BuildContext context, {
    bool? enableVideo,
    bool? enableCrop,
  }) async {
    final res = await pickFile(
      context,
      enableVideo: enableVideo,
      enableCrop: enableCrop,
    );
    if (res == null) return;
    picked = res;
    _state(UploadState.picked(res));
    if (find(res.path) != null) return;
    uploaders.add(this);
  }

  void reset() {
    _state(UploadState.initial());
    uploaded = null;
    clear();
  }

  void setAsPicked(FileModel? file) {
    if (file == null) return;
    picked = file;
    _state(UploadState.picked(file));
    if (find(picked!.path) != null) return;
    uploaders.add(this);
  }

  void setAsUploaded(FileModel? file) {
    if (file == null) return;
    uploaded = file;
    _state(UploadState.success(file));
  }

  Future<void> upload(
    Reference ref, {
    String filename = '',
    ValueChanged<FileModel>? onSuccess,
    ValueChanged<String>? onFailed,
  }) async {
    try {
      if (!isPicked) throw Exception('No File Picked');
      final url = await uploadFile(
        path(),
        ref,
        (v) => _state(UploadState.uploading(v)),
        filename,
      );

      uploaded = await picked!.when<Future<FileModel?>>(
        image: (v) async {
          final img = await ImageModel.create(v.path);
          return img?.copyWith(path: url);
        },
      );
      if (uploaded != null) {
        _state(UploadState.success(uploaded!));
        onSuccess?.call(uploaded!);
        clear();
      }
    } catch (e, s) {
      logError(e, '', s);
      _state(UploadState.failed('$e'));
      onFailed?.call('$e');
    }
  }

  static AppUploader? find(String path) => uploaders.firstWhereOrNull(
        (e) => e.picked?.path == path,
      );
  static Future<String> uploadFile(
    String path,
    Reference ref,
    ValueChanged<double> onProgress, [
    String? filename,
  ]) async {
    final file = File(path);
    if (!file.existsSync()) {
      throw Exception(t.CannotFindFile);
    }

    final basename =
        '${authProvider.user?.username ?? ''}-${filename ?? ''}-${DateTime.now().millisecondsSinceEpoch}${p.extension(path)}';
    final snap = ref.child(basename).putFile(file).snapshotEvents;
    await for (final e in snap) {
      onProgress((e.bytesTransferred / e.totalBytes).toPrecision(2));
      if (e.state == TaskState.success) {
        return e.ref.getDownloadURL();
      }
    }

    throw Exception('Oops, something went wrong');
  }
}
