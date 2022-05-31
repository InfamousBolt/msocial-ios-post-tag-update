import 'package:freezed_annotation/freezed_annotation.dart';

import 'file.dart';

part 'upload.freezed.dart';

@freezed
class UploadState with _$UploadState {
  const factory UploadState.initial() = _UploadInitial;
  const factory UploadState.picked(FileModel file) = _UploadPicked;
  const factory UploadState.uploading(double progress) = _Uploading;
  const factory UploadState.success(FileModel file) = _UploadSuccess;
  const factory UploadState.failed(String msg) = _UploadFailed;
}
