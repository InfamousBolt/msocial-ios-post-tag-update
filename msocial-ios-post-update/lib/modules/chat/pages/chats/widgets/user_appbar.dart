import 'package:flutter/material.dart';

import 'package:timeago/timeago.dart';

import '../../../../../imports.dart';

class UserAppBarTile extends StatelessWidget {
  final User user;

  const UserAppBarTile(
    this.user, {
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      contentPadding: EdgeInsets.all(0),
      leading: Hero(
        tag: user.id,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Theme(
            data: ThemeData.dark(),
            child: AvatarWidget(
              user.photoURL,
              radius: 45,
            ),
          ),
        ),
      ),
      title: Text(
        user.username,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
      subtitle: Text(
        user.isOnline
            ? t.Online
            : user.onlineStatus
                ? format(user.activeAt, locale: 'en_short')
                : '',
        style: theme.textTheme.headline6!.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 11,
        ),
      ),
      onTap: () => AuthRoutes.toProfile(user.id),
    );
  }
}
