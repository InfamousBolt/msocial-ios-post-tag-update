import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../imports.dart';
import '../models/notification.dart';
import '../provider.dart';
import 'widget/item.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ListTile(
          title: Text(
            t.Notifications,
            style: GoogleFonts.basic(textStyle: theme.textTheme.headline5),
          ),
          trailing: Icon(Icons.notifications),
        ),
        Expanded(
          child: Obx(
            () => StreamBuilder<List<NotificationModel>>(
              stream: notificationProvider.notsStream,
              builder: (_, snapshot) {
                final nots = snapshot.data ?? [];
                return SmartRefresher(
                  controller: notificationProvider.refreshController,
                  enablePullDown: false,
                  enablePullUp: notificationProvider.limit() <= nots.length,
                  onLoading: notificationProvider.onLoadMore,
                  child: ListView.builder(
                    itemCount: nots.length,
                    itemBuilder: (_, i) => NotificationItem(nots[i]),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
