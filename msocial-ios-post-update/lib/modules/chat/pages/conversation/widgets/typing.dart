import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

class TypingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        width: 40,
        child: SpinKitThreeBounce(
          color: theme.iconTheme.color,
          size: 25,
        ),
      ),
    );
  }
}
