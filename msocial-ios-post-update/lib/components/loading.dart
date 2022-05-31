import 'package:flutter/material.dart';

class AppLoadingIndicator extends StatelessWidget {
  final double? value;
  const AppLoadingIndicator({
    Key? key,
    this.value,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 40,
          height: 40,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white.withAlpha(60),
          ),
          child: CircularProgressIndicator(
            value: value,
            semanticsLabel: value == null ? '' : '${value!.toInt()}%',
          ),
        ),
        if (value != null)
          Text(
            '${(value! * 100).toInt()}%',
            style: TextStyle(color: Colors.white),
          )
      ],
    );
  }
}
