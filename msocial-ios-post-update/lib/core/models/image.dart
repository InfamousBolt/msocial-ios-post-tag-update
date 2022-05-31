import 'package:equatable/equatable.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

import '../../imports.dart';

class ImageModel extends FileModel with EquatableMixin {
  final String? blurhash;
  final double height;
  final double width;
  const ImageModel(
    String path, {
    this.blurhash,
    this.height = 300,
    this.width = 300,
    int size = 0,
  }) : super(
          path: path,
          size: size,
        );

  factory ImageModel.fromMap(Map<String, dynamic> map) {
    return ImageModel(
      map['path'] as String? ?? '',
      blurhash: parseString(map['blurhash']),
      height: parseDouble(map['height']),
      width: parseDouble(map['width']),
      size: parseInt(map['size']),
    );
  }

  bool get hasBlurHash => blurhash?.isNotEmpty == true;

  @override
  bool get isImage => true;

  @override
  List<Object?> get props {
    return [
      path,
      blurhash,
      height,
      width,
      size,
    ];
  }

  double get ratio => width / height;

  @override
  bool get stringify => true;

  ImageModel copyWith({
    String? path,
    String? blurhash,
    double? height,
    double? width,
    int? size,
  }) {
    return ImageModel(
      path ?? this.path,
      blurhash: blurhash ?? this.blurhash,
      height: height ?? this.height,
      width: width ?? this.width,
      size: size ?? this.size,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'path': path,
      'blurhash': blurhash,
      'height': height,
      'width': width,
      'size': size,
    };
  }

  static Future<ImageModel?> create(String path) async {
    if (path.isEmpty) return null;
    final comp = await FlutterImageCompress.compressWithFile(path);
    if (comp == null) return null;
    final img = await decodeImageFromList(comp);
    return ImageModel(
      path,
      blurhash: '',
      height: img.height.toDouble(),
      width: img.width.toDouble(),
      size: (comp.length / 1024 / 1024).floor(),
    );
  }
}
