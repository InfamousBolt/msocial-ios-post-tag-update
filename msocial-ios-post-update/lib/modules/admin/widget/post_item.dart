import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_linkify/flutter_linkify.dart';

import '../../../../../imports.dart';
import '../../auth/data/user.dart';
import '../../feeds/data/posts.dart';
import '../../feeds/models/post.dart';
import '../../feeds/pages/posts/widgets/post_image.dart';
import 'user_tile.dart';

class AdminPostWidget extends StatefulWidget {
  final Post post;
  final bool showMore;

  const AdminPostWidget(
    this.post, {
    Key? key,
    this.showMore = true,
  }) : super(key: key);
  @override
  _AdminPostWidgetState createState() => _AdminPostWidgetState();
}

class _AdminPostWidgetState extends State<AdminPostWidget> {
  String get uid => authProvider.user!.id;
  Post get post => widget.post;
  @override
  Widget build(BuildContext context) {
    final postSentences = post.content.split('\n');
    final theme = Theme.of(context);

    final showMore = widget.showMore && postSentences.length > 5;
    return StreamBuilder<User>(
      stream: UserRepository.userStream(post.authorID),
      builder: (_, snap) {
        final user = snap.data ?? post.getUser;
        return Container(
          margin: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: user.isAdmin ? theme.primaryColor.withAlpha(100) : null,
            border: Border.all(color: theme.iconTheme.color!, width: 0.5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              UserTile(user, post),
              if (post.content.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Linkify(
                    text: showMore
                        ? postSentences.take(5).join('\n')
                        : post.content,
                    onOpen: (l) => launchURL(l.url),
                  ),
                ),
                if (showMore)
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '\n${t.ReadMore}\n',
                            style: theme.textTheme.subtitle2!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.secondary,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => FeedRoutes.toSinglePost(post.id),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
              if (post.hasImage) PostImageWidget(post),
              Row(
                children: <Widget>[
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: toggleReaction,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 6, right: 12),
                      child: Icon(
                        post.liked ? Icons.favorite : Icons.favorite_border,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  Container(
                    width: 0.5,
                    height: 20,
                    color: theme.iconTheme.color,
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () => FeedRoutes.toReactions(post.usersLikes),
                    child: Text(
                      '${post.usersLikes.length} Likes',
                      style: theme.textTheme.subtitle1,
                    ),
                  ),
                  Spacer(),
                  TextButton.icon(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(),
                    ),
                    icon: Icon(Icons.mode_comment),
                    label: Text(
                      '${post.commentsIDs.length} Comments',
                      style: theme.textTheme.subtitle1,
                    ),
                    onPressed: () async {
                      await FeedRoutes.toComments(post);
                      setState(() {});
                    },
                  ),
                  SizedBox(width: 10),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> toggleReaction() async {
    setState(() => post.toggleLike());
    await PostsRepository.togglePostReaction(post);
  }
}
