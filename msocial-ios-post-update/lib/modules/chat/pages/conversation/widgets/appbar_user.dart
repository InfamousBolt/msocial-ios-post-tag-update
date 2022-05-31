import 'package:flutter/material.dart';

import 'package:timeago/timeago.dart';

import '../../../../../components/confirm_dialog.dart';
import '../../../../../imports.dart';
import '../../../../auth/data/user.dart';
import '../../../data/chats.dart';
import 'typing.dart';

class UserAppBarTile extends StatelessWidget implements PreferredSizeWidget {
  final User user;
  final bool isTyping;

  const UserAppBarTile(
    this.user, {
    Key? key,
    this.isTyping = false,
  }) : super(key: key);

  User? get currentUser => authProvider.user;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      backgroundColor: theme.primaryColor,
      leading: BackButton(
        color: theme.iconTheme.color,
      ),
      title: ListTile(
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
        subtitle: isTyping
            ? TypingWidget()
            : Text(
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
      ),
      actions: <Widget>[
        PopupMenuButton<int>(
          itemBuilder: (_) => [
            PopupMenuItem(
              value: 0,
              child: Text(
                user.isBlocked() ? t.Unblock : t.Block,
              ),
            ),
            PopupMenuItem(
              value: 1,
              child: Text(t.RemoveConversation),
            ),
          ],
          onSelected: (v) {
            if (v == 0) {
              showConfirmDialog(
                context,
                title:
                    '${t.AreYouSure} ${user.isBlocked() ? 'Unblock' : 'Block'} ${user.username}',
                onConfirm: () {
                  UserRepository.toggleBlock(user);
                  Navigator.pop(context);
                },
              );
            } else {
              showConfirmDialog(
                context,
                title: t.ConfirmChatDeletion,
                onConfirm: () {
                  ChatsRepository.removeChat(user.id);
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              );
            }
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
