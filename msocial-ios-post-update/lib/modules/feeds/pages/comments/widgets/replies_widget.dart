import 'package:flutter/material.dart';

import '../../../../../imports.dart';
import '../../../models/comment.dart';

class RepliesWidget extends StatelessWidget {
  final List<Comment> replies;

  const RepliesWidget({
    Key? key,
    required this.replies,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: <Widget>[
        for (final reply in replies.take(4).toList())
          Padding(
            padding: const EdgeInsets.all(4),
            child: Row(
              children: <Widget>[
                SizedBox(width: 30),
                AvatarWidget(
                  reply.authorPhotoURL,
                  radius: 30,
                ),
                SizedBox(width: 10),
                Flexible(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text:
                              reply.isMine ? 'Me:  ' : '${reply.authorName}:  ',
                          style: theme.textTheme.subtitle1!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: reply.content),
                      ],
                    ),
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          )
      ],
    );
  }
}
