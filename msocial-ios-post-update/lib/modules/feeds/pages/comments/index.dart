import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:profanity_filter/profanity_filter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../imports.dart';
import '../../data/comments.dart';
import '../../models/comment.dart';
import '../../models/post.dart';
import '../comments/widgets/shimmer.dart';
import 'widgets/comment_widget.dart';
import 'widgets/input.dart';

class CommentsPage extends StatefulWidget {
  final Post post;
  const CommentsPage(
    this.post, {
    Key? key,
  }) : super(key: key);

  @override
  _CommentsPageState createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  final scrollController = ScrollController();
  final refreshController = RefreshController();
  final textController = TextEditingController();

  Post get post => widget.post;
  List<Comment> comments = <Comment>[];

  int limit = 20;

  @override
  void dispose() {
    textController.dispose();
    scrollController.dispose();
    refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(130,212,246, 1),
        centerTitle: true,
        title: Text(
          t.Comments,
          style: theme.textTheme.headline6,
        ),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 10),
          Expanded(
            child: StreamBuilder<List<Comment>>(
              stream: CommentsRepository.commentsStream(post.id, limit),
              builder: (_, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return CommentShimmer();
                }
                comments = snap.data ?? comments;
                return SmartRefresher(
                  controller: refreshController,
                  enablePullDown: limit <= comments.length,
                  dragStartBehavior: DragStartBehavior.down,
                  onRefresh: () async {
                    limit = comments.length + 10;
                    refreshController.loadComplete();
                  },
                  child: ListView.builder(
                    controller: scrollController,
                    reverse: true,
                    itemCount: comments.length,
                    itemBuilder: (_, index) => CommentWidget(
                      comments[index],
                      onEdit: (v) => onEditComment(comments[index], v),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 10),
          CommentInput(
            onSubmit: (content) async {
              if (content.isEmpty) return;
              await Future.delayed(Duration(milliseconds: 50))
                  .then((_) => textController.clear());
              await addComment(content);
            },
          ),
        ],
      ),
    );
  }

  Future<void> addComment(String content) async {
    if (ProfanityFilter().hasProfanity(content)) {
      BotToast.showText(
        text: 'Bad words detected, your account may get suspended!',
        duration: Duration(seconds: 5),
      );
      return;
    }
    try {
      final comment = Comment.create(
        content: content,
        postID: post.id,
        postAuthorID: post.authorID,
      );
      post.commentsIDs.add(comment.id);
      comments.insert(0, comment);
      await CommentsRepository.addComment(comment);
    } catch (e) {
      logError(e);
    }
  }

  Future<void> onEditComment(Comment comment, String content) async {
    if (ProfanityFilter().hasProfanity(content)) {
      BotToast.showText(
        text: 'Bad words detected, your account may get suspended!',
        duration: Duration(seconds: 5),
      );
      return;
    }
    await CommentsRepository.updateComment(comment.copyWith(content: content));
  }

  Future<void> addOrRemoveReaction(Comment comment) async {
    await CommentsRepository.toggleLike(comment);
  }
}
