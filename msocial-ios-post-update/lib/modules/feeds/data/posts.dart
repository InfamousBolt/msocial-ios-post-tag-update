import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../imports.dart';
import '../../notifications/data/notifications.dart';
import '../../notifications/models/notification.dart';
import '../models/post.dart';
import '../models/post_query.dart';
import 'comments.dart';

mixin PostsRepository {
  static final _firestore = FirebaseFirestore.instance;
  static final postsCol = _firestore.collection('posts').withConverter<Post>(
        fromFirestore: (m, _) => Post.fromMap(m.data()!),
        toFirestore: (m, _) => m.toMap(),
      );

  static final reportedPostsCol =
      _firestore.collection('reported_posts').withConverter<Post>(
            fromFirestore: (m, _) => Post.fromMap(m.data()!),
            toFirestore: (m, _) => m.toMap(),
          );
  //SECTION ------------------------------Posts
  static DocumentSnapshot? lastPostDoc;

  static String get _uid => authProvider.uid;
  static Future<void> addPost(Post post) async {
    await postDoc(post.id).set(post);
    await _firestore.doc('users/${post.authorID}').update(
      {
        'posts': FieldValue.arrayUnion([post.id])
      },
    );
  }

  static Future<Post> fetchPost(String? id) =>
      postDoc(id).get().then((v) => v.data()!);
  static Future<List<Post>> fetchPosts(
    PostQuery postQuery,
    String userId,
    int page,
  ) async {
    var col = postsCol.limit(20);

    postQuery.when(
      newest: () {
        col = col.orderBy('createdAt', descending: true);
      },
      top: () {
        col = col.orderBy('likesCount', descending: true);
      },
      hot: () {
        col = col.orderBy('commentsCount', descending: true);
      },
      myPosts: () {
        col = col
            .orderBy('createdAt', descending: true)
            .where('authorID', isEqualTo: userId);
      },
      myFavorites: () {
        col = col
            .orderBy('createdAt', descending: true)
            .where('usersLikes', arrayContains: userId);
      },
    );
    if (page != 0 && lastPostDoc != null) {
      col = col.startAfterDocument(lastPostDoc!);
    }
    final docs = (await col.get()).docs;
    if (docs.isNotEmpty) lastPostDoc = docs.last;
    return docs.map((s) => s.data()).toList();
  }

  static Stream<List<Post>> getUserPostsStream(String userId, int offset) {
    return postsCol
        .where('authorID', isEqualTo: userId)
        .limit(offset)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((s) => [for (final d in s.docs) d.data()])
        .handleError((e) => logError(e));
  }

  static DocumentReference<Post> postDoc(String? postID) =>
      postsCol.doc(postID);

  static Future<void> removePost(String postID, List<String> comments) async {
    await postDoc(postID).delete();
    for (final id in comments) {
      await CommentsRepository.commentDoc(id).delete();
    }
    await _firestore.doc('users/$_uid').update(
      {
        'posts': FieldValue.arrayRemove([postID])
      },
    );
  }

  static DocumentReference<Post> reportedDoc(String id) =>
      reportedPostsCol.doc(id);

  //SECTION ------------------------------Post Report

  static Stream<List<Post>> reportedPostsStream() =>
      reportedPostsCol.orderBy('id', descending: true).snapshots().map(
            (s) => [for (final d in s.docs) d.data()],
          );

  static Future<void> reportPost(Post post) async {
    post.reportedBy.add(_uid);
    await reportedDoc(post.id).set(post, SetOptions(merge: true));
    await postDoc(post.id).update({
      'reportedBy': FieldValue.arrayUnion([_uid])
    });
  }

  static Stream<Post> singlePostStream(String? postID) {
    return postDoc(postID).snapshots().map(
          (s) => s.data()!,
        );
  }

//SECTION ------------------------------Post Ractions

  static Future<void> togglePostReaction(Post post) async {
    await postDoc(post.id).update({
      'usersLikes': post.liked
          ? FieldValue.arrayUnion([_uid])
          : FieldValue.arrayRemove([_uid]),
      'likesCount':
          post.liked ? FieldValue.increment(1) : FieldValue.increment(-1),
    });
    if (post.liked && !post.isMine) {
      NotificationRepo.sendNotificaion(
        NotificationModel.create(
          toId: post.authorID,
          postID: post.id,
          type: NotificationType.PostReaction,
        ),
      );
    }
  }

  static Future<void> unReportPost(String id) async {
    _firestore.runTransaction(
      (tr) async => tr
        ..update(postDoc(id), {
          'reportedBy': FieldValue.arrayRemove([_uid])
        })
        ..delete(reportedDoc(id)),
    );
  }

  static Future<void> updatePost(Post post) async {
    await postDoc(post.id).update({
      'content': post.content,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  static Query<Post> userPostsQuery(String userId, int offset) {
    return postsCol
        .where('authorID', isEqualTo: userId)
        .limit(offset)
        .orderBy('createdAt', descending: true);
  }
}
