import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../imports.dart';
import '../../notifications/data/notifications.dart';
import '../../notifications/models/notification.dart';
import '../models/comment.dart';
import 'posts.dart';

mixin CommentsRepository {
  static String? get _uid => authProvider.uid;

  static final _firestore = FirebaseFirestore.instance;
  static final commentsCol =
      _firestore.collection('comments').withConverter<Comment>(
            fromFirestore: (m, _) => Comment.fromMap(m.data()!),
            toFirestore: (m, _) => m.toMap(),
          );
  static DocumentReference<Comment> commentDoc(String? commentID) =>
      commentsCol.doc(commentID);

  static Stream<List<Comment>> commentsStream(String postID, int offset) {
    return commentsCol
        .where('postID', isEqualTo: postID)
        .orderBy('createdAt', descending: true)
        .limit(offset)
        .snapshots()
        .map(
          (s) => [for (final d in s.docs) d.data()],
        )
        .handleError((e) => logError(e));
  }

  static Stream<Comment> singleCommentStream(String id) {
    return commentDoc(id).snapshots().map(
          (s) => s.data()!,
        );
  }

  static Future<Comment> fetchComment(String? id) =>
      commentDoc(id).get().then((v) => v.data()!);

  static Future<void> addComment(Comment comment) async {
    await commentsCol
        .doc(comment.id)
        .withConverter<Comment>(
          fromFirestore: (m, _) => Comment.fromMap(m.data()!),
          toFirestore: (m, _) =>
              m.toMap()..['createdAt'] = FieldValue.serverTimestamp(),
        )
        .set(comment);
    await PostsRepository.postDoc(comment.postID).update(
      {
        'commentsIDs': FieldValue.arrayUnion([comment.id]),
        'commentsCount': FieldValue.increment(1)
      },
    );
    if (!comment.isMine) {
      NotificationRepo.sendNotificaion(
        NotificationModel.create(
          toId: comment.postAuthorID,
          commentID: comment.id,
          postID: comment.postID,
          type: NotificationType.Comment,
        ),
      );
    }
  }

  static Future<void> updateComment(Comment comment) =>
      commentDoc(comment.id).update(
        {'content': comment.content},
      );

  static Future<void> removeComment(Comment comment) async {
    _firestore.runTransaction((tr) async {
      tr.delete(commentDoc(comment.id));
      tr.update(PostsRepository.postDoc(comment.postID), {
        'commentsIDs': FieldValue.arrayRemove([comment.id]),
        'commentsCount': FieldValue.increment(-1),
      });
    });
  }

  static Future<void> addCommentReply(String commentID, Comment reply) async {
    await commentDoc(commentID).update(
      {
        'replyComments': FieldValue.arrayUnion([reply.toMap()]),
        'replyCount': FieldValue.increment(1),
      },
    );
    NotificationRepo.sendNotificaion(
      NotificationModel.create(
        toId: reply.postAuthorID,
        commentID: commentID,
        postID: reply.postID,
        type: NotificationType.Reply,
      ),
    );
  }

  static Future<void> removeCommentReply(String? commentID, Comment reply) =>
      commentDoc(commentID).update({
        'replyComments': FieldValue.arrayRemove([reply.toMap()]),
        'replyCount': FieldValue.increment(-1),
      });

  static Future<void> toggleLike(Comment comment) async {
    comment.toggleLike();
    commentDoc(comment.id).update({
      'usersLikeIds': comment.isLiked
          ? FieldValue.arrayUnion([_uid])
          : FieldValue.arrayRemove([_uid])
    });
    if (comment.isLiked && !comment.isMine) {
      NotificationRepo.sendNotificaion(
        NotificationModel.create(
          toId: comment.postAuthorID,
          commentID: comment.id,
          type: NotificationType.CommentReaction,
        ),
      );
    }
  }
}
