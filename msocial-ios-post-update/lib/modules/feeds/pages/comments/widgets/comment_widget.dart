import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:timeago/timeago.dart';

import '../../../../../imports.dart';
import '../../../data/comments.dart';
import '../../../models/comment.dart';
import 'input.dart';
import 'replies_widget.dart';

class CommentWidget extends StatefulWidget {
  final Comment comment;
  final ValueChanged<String>? onEdit;
  const CommentWidget(
    this.comment, {
    Key? key,
    this.onEdit,
  }) : super(key: key);

  @override
  _CommentWidgetState createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  Comment get comment => widget.comment;
  bool get isAdmin => authProvider.user!.isAdmin;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FocusedMenuHolder(
      menuItems: _menuItems(),
      onPressed: () {},
      child: Column(
        children: <Widget>[
          ListTile(
            leading: AvatarWidget(
              widget.comment.authorPhotoURL,
              radius: 40,
            ),
            title: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text:
                        '${comment.isMine ? 'Me' : widget.comment.authorName}: ',
                    style: theme.textTheme.subtitle1!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: widget.comment.content,
                    style: theme.textTheme.subtitle1,
                  ),
                ],
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Row(
                children: <Widget>[
                  Text(format(widget.comment.createdAt!, locale: 'en_short')),
                  SizedBox(width: 20),
                  Text(
                    widget.comment.usersLikeIds.isEmpty
                        ? ''
                        : '${widget.comment.usersLikeIds.length} ${t.Likes}',
                  ),
                  Container(
                    width: 1,
                    height: 10,
                    color: Colors.grey,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                  ),
                  GestureDetector(
                    onTap: () => CommentsRepository.toggleLike(comment),
                    child: Icon(
                      comment.isLiked ? Icons.favorite : Icons.favorite_border,
                    ),
                  ),
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: () => FeedRoutes.toReplies(widget.comment),
                    child: Text(
                      t.Reply,
                      style: theme.textTheme.button,
                    ),
                  ),
                ],
              ),
            ),
            onTap: comment.isMine
                ? null
                : () => AuthRoutes.toProfile(widget.comment.authorID),
          ),
          GestureDetector(
            onTap: () => FeedRoutes.toReplies(widget.comment),
            child: RepliesWidget(
              replies: widget.comment.replyComments,
            ),
          )
        ],
      ),
    );
  }

  List<FocusedMenuItem> _menuItems() => [
        if (comment.isMine || isAdmin)
          FocusedMenuItem(
            backgroundColor: context.theme.scaffoldBackgroundColor,
            title: Text(t.Edit),
            trailingIcon: Icon(Icons.edit),
            onPressed: () {
              AwesomeDialog(
                context: context,
                body: CommentInput(
                  showAvatar: false,
                  initContent: widget.comment.content,
                  onSubmit: (c) {
                    widget.onEdit?.call(c);
                    Navigator.pop(context);
                  },
                ),
              ).show();
            },
          ),
        FocusedMenuItem(
          backgroundColor: context.theme.scaffoldBackgroundColor,
          title: Text(t.Copy),
          trailingIcon: Icon(Icons.copy),
          onPressed: () {
            Clipboard.setData(ClipboardData(text: comment.content));
            BotToast.showText(text: t.Copied);
          },
        ),
        FocusedMenuItem(
          backgroundColor: context.theme.scaffoldBackgroundColor,
          title: Text(t.Reply),
          trailingIcon: Icon(Icons.reply),
          onPressed: () => FeedRoutes.toReplies(widget.comment),
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
                btnOkOnPress: () => CommentsRepository.removeComment(comment),
              ).show();
            },
          ),
      ];
}
