import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

import '../core/models/image.dart';
import '../gen/assets.gen.dart';
import 'image_io.dart';

class AppImage extends StatelessWidget {
  final ImageModel img;
  final BoxFit fit;
  final Widget? placeholder;
  final String? placeholderAsset;
  final Widget? errorWidget;
  final String? errorAsset;

  const AppImage(
    this.img, {
    Key? key,
    this.fit = BoxFit.contain,
    this.placeholder,
    this.errorWidget,
    this.placeholderAsset,
    this.errorAsset,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _errorWidget = errorWidget ??
        (img.hasBlurHash
            ? BlurHash(hash: img.blurhash!)
            : Image.asset(
                errorAsset ?? Assets.images.blurred.path,
                fit: fit,
                width: img.width,
                height: img.height,
              ));
    if (img.path.isEmpty) return _errorWidget;
    if (!img.isLocal) {
      return CachedNetworkImage(
        imageUrl: img.path,
        fit: fit,
        width: img.width,
        height: img.height,
        placeholder: (context, _) {
          if (placeholder != null) return placeholder!;
          return img.hasBlurHash
              ? BlurHash(hash: img.blurhash!)
              : Image.asset(
                  placeholderAsset ?? Assets.images.loading.path,
                  fit: fit,
                  width: img.width,
                  height: img.height,
                );
        },
        errorWidget: (_, __, ___) => _errorWidget,
      );
    }
    return kIsWeb
        ? _errorWidget
        : AppImageIO(img, errorWidget: _errorWidget, fit: fit);
  }
}
