import '../utils.dart';
import 'image.dart';

class FileModel {
  final String path;
  final int size; //KB

  const FileModel({
    required this.path,
    required this.size,
  });

  bool get isLocal => !isURL(path);

  bool get isImage => false;
  bool get isVideo => false;
  bool get isSound => false;
  bool get isMedia => isImage || isVideo;

  T? when<T>({
    T Function(ImageModel)? image,
    T Function(FileModel)? orElse,
  }) {
    if (this is ImageModel) {
      return image?.call(this as ImageModel);
    }
    return orElse?.call(this);
  }

  ImageModel? get img => when(
        image: (v) => v,
      );
}
