import 'package:flutter/material.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../imports.dart';
import '../../../data/comments.dart';
import '../../../models/comment.dart';
import '../widgets/input.dart';
import 'widgets/reply_widget.dart';

class ReplyPage extends StatefulWidget {
  final Comment comment;

  const ReplyPage(
    this.comment, {
    Key? key,
  }) : super(key: key);

  @override
  _CommentReplyPageState createState() => _CommentReplyPageState();
}

class _CommentReplyPageState extends State<ReplyPage> {
  final scrollController = ScrollController();
  final refreshController = RefreshController();

  Comment get comment => widget.comment;

  int offset = 10;
  @override
  void dispose() {
    scrollController.dispose();
    refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          t.Replies,
          style: theme.textTheme.headline6,
        ),
      ),
      body: StreamBuilder<Comment>(
        stream: CommentsRepository.singleCommentStream(comment.id),
        builder: (context, snapshot) {
          final comment = snapshot.data;
          if (comment == null) return Container();
          return Column(
            children: <Widget>[
              AbsorbPointer(
                child: ReplyWidget(
                  comment: comment,
                  commentParentId: comment.id,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 10),
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: comment.replyComments.length,
                    itemBuilder: (_, i) => ReplyWidget(
                      comment: comment.replyComments[i],
                      commentParentId: comment.id,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              CommentInput(
                onSubmit: addReplyComment,
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> addReplyComment(String content) async {
    try {
      if (content.isEmpty) return;
      final reply = Comment.create(
        content: content,
        postID: comment.postID,
        postAuthorID: comment.postAuthorID,
        parentID: comment.id,
      );
      await CommentsRepository.addCommentReply(comment.id, reply);
      comment.replyComments.add(reply);
    } catch (e) {
      logError(e);
    }
  }
}
