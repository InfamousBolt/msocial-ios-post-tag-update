/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

import 'package:flutter/widgets.dart';

class $AssetsFlareGen {
  const $AssetsFlareGen();

  String get otp => 'assets/flare/otp.flr';
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  AssetGenImage get avatar => const AssetGenImage('assets/images/avatar.jpg');
  AssetGenImage get blurred => const AssetGenImage('assets/images/blurred.jpg');
  AssetGenImage get cover => const AssetGenImage('assets/images/cover.jpg');
  AssetGenImage get loading => const AssetGenImage('assets/images/loading.gif');
  AssetGenImage get loading2 =>
      const AssetGenImage('assets/images/loading2.gif');
  AssetGenImage get logo => const AssetGenImage('assets/images/logo.png');
}

class Assets {
  Assets._();

  static const AssetGenImage appIcon = AssetGenImage('assets/app_icon.png');
  static const $AssetsFlareGen flare = $AssetsFlareGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage extends AssetImage {
  const AssetGenImage(String assetName)
      : _assetName = assetName,
        super(assetName);
  final String _assetName;

  Image image({
    Key? key,
    ImageFrameBuilder? frameBuilder,
    ImageLoadingBuilder? loadingBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? width,
    double? height,
    Color? color,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    FilterQuality filterQuality = FilterQuality.low,
  }) {
    return Image(
      key: key,
      image: this,
      frameBuilder: frameBuilder,
      loadingBuilder: loadingBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      width: width,
      height: height,
      color: color,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      filterQuality: filterQuality,
    );
  }

  String get path => _assetName;
}
