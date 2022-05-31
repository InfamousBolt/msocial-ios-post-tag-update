import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String data;
  final double? size;
  final Color? color;
  final int? maxLines;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;
  const AppText(
    this.data, {
    Key? key,
    this.size,
    this.color,
    this.maxLines,
    this.textAlign,
    this.fontWeight,
    this.overflow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: fontWeight,
      ),
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: overflow,
    );
  }
}
