import 'dart:io';

import 'package:flutter/material.dart';

import '../core/guard.dart';
import '../core/models/image.dart';

class AppImageIO extends StatelessWidget {
  final ImageModel? img;
  final BoxFit? fit;
  final Widget? errorWidget;

  const AppImageIO(
    this.img, {
    Key? key,
    this.fit,
    this.errorWidget,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return guard(
      () => Image.file(
        File(img!.path),
        fit: fit,
        width: img!.width,
        height: img!.height,
        errorBuilder: (_, __, ___) => errorWidget ?? SizedBox(),
      ),
      errorWidget,
    )!;
  }
}
