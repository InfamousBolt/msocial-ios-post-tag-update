import 'package:flutter/material.dart';

import '../styles.dart';
import 'text.dart';

class AppButton extends StatelessWidget {
  final String text;
  final Color? color;
  final Color? backgroundColor;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? isLoading;
  final VoidCallback? onTap;
  final EdgeInsets contentPadding;
  final double width;
  final double textSize;
  final double borderRadius;
  const AppButton(
    this.text, {
    Key? key,
    this.color,
    this.backgroundColor,
    this.onTap,
    this.isLoading = false,
    this.prefixIcon,
    this.suffixIcon,
    this.contentPadding =
        const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
    this.width = 300,
    this.textSize = 18,
    this.borderRadius = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      padding: contentPadding,
      height: 60,
      width: isLoading! ? 150 : width,
      child: ElevatedButton(
        onPressed:
            onTap == null ? null : () => isLoading! ? null : onTap?.call(),
        style: ElevatedButton.styleFrom(
          elevation: 5,
          primary: backgroundColor ?? theme.inversePrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading!)
              SizedBox.fromSize(
                size: Size.fromRadius(12),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(
                    color ?? theme.scaffoldBackgroundColor,
                  ),
                ),
              )
            else ...[
              if (prefixIcon != null) ...[prefixIcon!, SizedBox(width: 10)],
              Flexible(
                child: AppText(
                  text,
                  size: textSize,
                  color: color ?? theme.scaffoldBackgroundColor,
                  maxLines: 1,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (suffixIcon != null) suffixIcon!,
            ],
          ],
        ),
      ),
    );
  }
}
