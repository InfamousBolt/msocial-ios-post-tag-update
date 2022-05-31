import 'package:flutter/material.dart';

import '../../../../imports.dart';

class AuthTopHeader extends StatelessWidget {
  final double? height;
  const AuthTopHeader({
    Key? key,
    this.height,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      height: height ?? context.height / 3,
      decoration: BoxDecoration(gradient: AppStyles.primaryGradient),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 100, bottom: 20),
            child: Image.asset(Assets.images.logo.path),
          ),
          Positioned.fill(
            child: Appbar(
              backgroundColor: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}
