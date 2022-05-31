import '../../imports.dart';
import 'models/comment.dart';
import 'models/post.dart';
import 'pages/comments/index.dart';
import 'pages/comments/reply/index.dart';
import 'pages/posts/editor.dart';
import 'pages/posts/reactions.dart';
import 'pages/posts/report.dart';
import 'pages/posts/signle_post.dart';

mixin FeedRoutes {
  static Future<void> toSinglePost(String id) async =>
      Get.to(() => SinglePostPage(id));
  static Future<void> toComments(Post post) async {
    appPrefs.page = AppPage.commenting(post.id);
    await Get.to(() => CommentsPage(post));
    appPrefs.page = AppPage.others();
  }

  static Future<void>? toPostEditor([Post? toEdit]) =>
      Get.to(() => PostEditorPage(toEditPost: toEdit));

  static Future<void>? toReplies(Comment comment) =>
      Get.to(() => ReplyPage(comment));
  static Future<void>? toReactions(List<String> likeIDs) =>
      Get.to(() => ReactionsPage(likeIDs));
  static void toReport(Post? post) => Get.to(() => ReportPage(post));
}
