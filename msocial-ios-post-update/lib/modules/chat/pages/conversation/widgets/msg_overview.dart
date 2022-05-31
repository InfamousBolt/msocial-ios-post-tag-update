import 'package:flutter/material.dart';

import '../../../../../imports.dart';

class MsgOverview extends StatelessWidget {
  final Message? msg;
  final VoidCallback? onCancel;
  const MsgOverview(
    this.msg, {
    Key? key,
    this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(color: theme.inversePrimaryColor, width: 5),
          ),
          color: theme.primaryColor,
        ),
        child: ListTile(
          dense: true,
          contentPadding: EdgeInsets.all(0),
          title: Text(
            t.Edit,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: theme.inversePrimaryColor,
            ),
          ),
          subtitle: Text(msg!.content),
          trailing: IconButton(
            icon: Icon(
              Icons.cancel,
            ),
            onPressed: onCancel,
          ),
        ),
      ),
    );
  }
}
