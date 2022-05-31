import 'package:flutter/material.dart';

import '../../../../../imports.dart';

class GenderWidget extends StatefulWidget {
  final ValueChanged<String?>? onSelect;

  const GenderWidget({
    Key? key,
    this.onSelect,
  }) : super(key: key);

  @override
  _GenderWidgetState createState() => _GenderWidgetState();
}

class _GenderWidgetState extends State<GenderWidget> {
  String? gender = t.Male;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (final g in [t.Male, t.Female])
          Flexible(
            child: RadioListTile<String>(
              title: AppText(g),
              value: g,
              groupValue: gender,
              onChanged: onSelect,
            ),
          ),
      ],
    );
  }

  void onSelect(String? v) {
    gender = v;
    widget.onSelect!(v);
    setState(() {});
  }
}
