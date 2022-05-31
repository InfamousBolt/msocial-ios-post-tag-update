import 'package:flutter/material.dart';

import '../../../../../imports.dart';
import '../../../data/users.dart';

class OnlineUsersWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            t.OnlineUsers,
            style: theme.textTheme.headline6!.copyWith(
              color: Colors.grey,
            ),
          ),
        ),
        SizedBox(
          height: 100.0,
          child: StreamBuilder<List<User>>(
            stream: ChatUsersRepository.onlineUsers(),
            builder: (_, snap) {
              final users = snap.data ?? [];
              return ListView.builder(
                itemCount: users.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, i) => _OnlineUserItem(users[i]),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _OnlineUserItem extends StatelessWidget {
  final User user;

  const _OnlineUserItem(
    this.user, {
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => ChatRoutes.toPrivateChat(user.id),
      child: Padding(
        padding: const EdgeInsets.only(right: 16),
        child: Column(
          children: <Widget>[
            AvatarWidget(
              user.photoURL,
              showBadge: true,
            ),
            SizedBox(height: 4),
            Text(
              user.username,
              style: TextStyle(fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}
