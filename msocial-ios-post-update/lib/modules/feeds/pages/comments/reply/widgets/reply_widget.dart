import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:timeago/timeago.dart';

import '../../../../../../imports.dart';
import '../../../../data/comments.dart';
import '../../../../models/comment.dart';

class ReplyWidget extends StatelessWidget {
  final Comment comment;
  final String commentParentId;
  const ReplyWidget({
    Key? key,
    required this.comment,
    required this.commentParentId,
  }) : super(key: key);

  bool get isAdmin => authProvider.user!.isAdmin;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FocusedMenuHolder(
      menuItems: _menuItems(context),
      onPressed: () {},
      child: ListTile(
        leading: AvatarWidget(
          comment.authorPhotoURL,
          radius: 40,
        ),
        title: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '${comment.isMine ? 'Me' : comment.authorName}: ',
                style: theme.textTheme.subtitle1!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: comment.content, style: theme.textTheme.subtitle1),
            ],
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Row(
            children: <Widget>[
              Text(format(comment.createdAt!, locale: 'en_short')),
              SizedBox(width: 20),
              Text(
                comment.usersLikeIds.isEmpty
                    ? ''
                    : '${comment.usersLikeIds.length} ${t.Likes}',
              ),
            ],
          ),
        ),
        onTap: comment.isMine
            ? null
            : () => AuthRoutes.toProfile(comment.authorID),
      ),
    );
  }

  List<FocusedMenuItem> _menuItems(BuildContext context) => [
        FocusedMenuItem(
          backgroundColor: context.theme.scaffoldBackgroundColor,
          title: Text(t.Copy),
          trailingIcon: Icon(Icons.copy),
          onPressed: () {
            Clipboard.setData(ClipboardData(text: comment.content));
            BotToast.showText(text: t.Copied);
          },
        ),
        if (comment.isMine || isAdmin)
          FocusedMenuItem(
            backgroundColor: context.theme.scaffoldBackgroundColor,
            title: Text(
              t.Delete,
              style: TextStyle(color: Colors.redAccent),
            ),
            trailingIcon: Icon(
              Icons.delete,
              color: Colors.redAccent,
            ),
            onPressed: () {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.WARNING,
                body: Text(t.NotAllowedToComment),
                btnCancelOnPress: () => null,
                btnOkOnPress: () {
                  CommentsRepository.removeCommentReply(
                    comment.parentID,
                    comment,
                  );
                },
              ).show();
            },
          ),
      ];
}
