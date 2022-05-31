import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../../../imports.dart';

class ProfileTabItem extends StatelessWidget {
  final String title;
  final String info;
  final VoidCallback? onTap;

  const ProfileTabItem({
    Key? key,
    required this.title,
    required this.info,
    this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: <Widget>[
          AutoSizeText(
            title,
            maxLines: 1,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 2),
          AppText(
            info,
            fontWeight: FontWeight.w900,
            size: 20.0,
            color: context.theme.iconTheme.color,
          ),
        ],
      ),
    );
  }
}
