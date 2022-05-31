import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../../imports.dart';
import '../../auth/data/user.dart';
import '../../feeds/data/comments.dart';
import '../../feeds/data/posts.dart';
import '../../notifications/models/notification.dart';
import '../models/message.dart';
import '../models/notification.dart';
import '../pages/widget/custom_notification.dart';
import '../provider.dart';

mixin NotificationRepo {
  static String? get _uid => authProvider.uid;
  static final _messaging = FirebaseMessaging.instance;

  static final _firestore = FirebaseFirestore.instance;

  static CollectionReference<NotificationModel> notCol([String? id]) =>
      _firestore
          .collection('users/${id ?? _uid}/notifications')
          .withConverter<NotificationModel>(
            fromFirestore: (m, _) => NotificationModel.fromMap(m.data()!),
            toFirestore: (m, _) => m.toMap(),
          );

  static Future<void> registerNotification() async {
    Get.put(NotificationProvider());
    await UserRepository.userDoc().update(
      {'pushToken': await _messaging.getToken()},
    ).catchError((e) => logError(e));
    final settings = await _messaging.requestPermission();
    if (settings.authorizationStatus != AuthorizationStatus.authorized) {
      BotToast.showText(text: 'Oops Notificatio permission in garanted');
      return;
    }

    FirebaseMessaging.onMessage.listen((message) async {
      final msg = MessageNotification.fromMap({
        ...message.data,
        'title': message.notification?.title ?? '',
        'body': message.notification?.body ?? '',
      });
      final show = appPrefs.page.maybeWhen(
        chatting: (id) => !msg.isGroup && id != msg.fromID,
        groupChatting: (id) => id != msg.groupID,
        orElse: () => true,
      );
      if (show) {
        BotToast.showCustomNotification(
          duration: Duration(seconds: 4),
          toastBuilder: (_) => CustomNotificationWidget(
            title: msg.title,
            body: msg.body,
            onTap: (_) {
              if (msg.isGroup) {
                ChatRoutes.toGroupChat(msg.groupID);
              } else if (msg.fromID.isNotEmpty) {
                ChatRoutes.toPrivateChat(msg.fromID);
              }
              BotToast.cleanAll();
            },
          ),
        );
      }
    });

    FirebaseMessaging.onBackgroundMessage(_onBackgroundMsg);
    FirebaseMessaging.onMessageOpenedApp.listen((message) async {
      final msg = MessageNotification.fromMap({...message.data});
      if (msg.fromID.isNotEmpty) {
        await ChatRoutes.toPrivateChat(msg.fromID);
      } else if (msg.isGroup) {
        await ChatRoutes.toGroupChat(msg.groupID);
      }
    });

    notificationProvider.init();
  }

  static Future<void> _onBackgroundMsg(RemoteMessage message) async {}

  static Future<void> clearToken() async {
    await UserRepository.userDoc().update(
      {'pushToken': ''},
    ).catchError((e) => logError(e));
  }

  static Stream<List<NotificationModel>> notsStream(int limit) {
    return notCol()
        .orderBy('createdAt', descending: true)
        .limit(limit)
        .snapshots()
        .map((s) => [for (final doc in s.docs) doc.data()]);
  }

  static Stream<List<NotificationModel>> unreadNotificationsStream() {
    return notCol().where('read', isEqualTo: false).snapshots().map(
          (s) => [
            for (final doc in s.docs) doc.data(),
          ],
        );
  }

  static Future<void> sendNotificaion(NotificationModel not) async {
    if (not.toId == _uid) return;
    await notCol(not.toId).doc(not.id).set(not).catchError((e) => logError(e));
  }

  static Future<void> markReadNotificaion(NotificationModel not) {
    return notCol(not.toId).doc(not.id).update({'read': true});
  }

  static const LAST_NOT_ID = 'LAST_NOT_ID';
  static String get lastNotID => appPrefs.prefs.getString(LAST_NOT_ID) ?? '';
  static void checkIfToShowNotification(List<NotificationModel> nots) {
    if (nots.isEmpty) return;
    final n = nots.first;
    if (lastNotID == n.id) return;
    appPrefs.prefs.setString(LAST_NOT_ID, n.id);
    BotToast.showCustomNotification(
      duration: Duration(seconds: 4),
      toastBuilder: (_) => CustomNotificationWidget(
        title: n.fromName,
        body: n.text,
        onTap: (_) => onNotificationTap(n),
      ),
    );
  }

  static Future<void> onNotificationTap(NotificationModel not) async {
    if (not.isFollow) {
      AuthRoutes.toProfile(not.fromId);
    } else if (not.isPostReaction) {
      FeedRoutes.toSinglePost(not.postID ?? '');
    } else if (not.isComment) {
      if (not.postID!.isEmpty) return;
      final post = await PostsRepository.fetchPost(not.postID);
      FeedRoutes.toComments(post);
    } else if (not.isReply) {
      if (not.commentID!.isEmpty) return;
      final comment = await CommentsRepository.fetchComment(not.commentID);
      FeedRoutes.toReplies(comment);
    }
  }
}
