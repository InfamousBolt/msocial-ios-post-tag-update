import 'dart:async';

import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../imports.dart';
import 'data/notifications.dart';
import 'models/notification.dart';

NotificationProvider get notificationProvider =>
    Get.find<NotificationProvider>();

class NotificationProvider {
  RefreshController refreshController = RefreshController();

  StreamSubscription<List<NotificationModel>>? notListener;
  void init() {
    refreshController = RefreshController();
    notListener = NotificationRepo.notsStream(2)
        .listen(NotificationRepo.checkIfToShowNotification);
  }

  final limit = 20.obs;
  Stream<List<NotificationModel>> get notsStream =>
      NotificationRepo.notsStream(limit());

  void onLoadMore() {
    limit.value += 20;
    refreshController.loadComplete();
  }

  Future<void> dispose() async {
    refreshController.dispose();
    await notListener?.cancel();
    notListener = null;
  }
}
