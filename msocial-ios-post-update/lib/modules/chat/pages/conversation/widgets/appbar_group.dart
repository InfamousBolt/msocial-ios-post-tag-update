import 'package:flutter/material.dart';

import '../../../../../imports.dart';
import '../../../models/group.dart';
import 'typing.dart';

class GroupAppBar extends StatelessWidget with PreferredSizeWidget {
  final Group group;

  const GroupAppBar(
    this.group, {
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      title: ListTile(
        contentPadding: EdgeInsets.all(0),
        leading: AvatarWidget(
          group.photoURL,
          radius: 40,
        ),
        title: Text(
          group.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        subtitle: group.isTyping
            ? TypingWidget()
            : Text(
                '${group.members.length} ${t.Members}',
                style: theme.textTheme.headline6!.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 11,
                ),
              ),
        trailing: !group.isMember() ? null : Icon(Icons.info),
        onTap: !group.isMember() ? null : () => ChatRoutes.toGroupInfo(group),
      ),
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, 50);
}
