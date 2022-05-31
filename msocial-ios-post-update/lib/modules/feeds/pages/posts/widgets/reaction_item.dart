import 'package:flutter/material.dart';

import 'package:timeago/timeago.dart';

import '../../../../../imports.dart';
import '../../../models/post_reaction.dart';

class ReactionItem extends StatelessWidget {
  final PostReaction reaction;
  const ReactionItem({
    Key? key,
    required this.reaction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      leading: AvatarWidget(
        reaction.reactionOwnerPhotoURL,
        radius: 40,
      ),
      title: Text(
        reaction.isMine ? 'Me: ' : '${reaction.reactionOwnerName}: ',
        style: theme.textTheme.subtitle1!.copyWith(fontWeight: FontWeight.bold),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Text(
          format(reaction.createdAt!, locale: 'en_short'),
          style: theme.textTheme.subtitle2,
        ),
      ),
      onTap: reaction.isMine
          ? null
          : () => AuthRoutes.toProfile(reaction.reactionOwnerID),
    );
  }
}
