import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../imports.dart';
import '../../data/chats.dart';
import '../../models/chat.dart';
import 'widgets/chat_tile.dart';
import 'widgets/online_users.dart';

class ChatsPage extends StatefulWidget {
  @override
  _ChatsPageState createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> with RouteAware {
  final scrollController = ScrollController();
  final refreshController = RefreshController();

  List<Chat> chats = [];
  int limit = 20;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: Appbar(
        title: Image.asset('assets/images/m_chat.png'),
        actions: const [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: ChatRoutes.toUsersSearchPage,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OnlineUsersWidget(),
            //Chats
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                t.RecentChats,
                style: theme.textTheme.headline6!.copyWith(color: Colors.grey),
              ),
            ),
            Center(child: Get.find<AdsHelper>().banner()),
            Expanded(
              child: StreamBuilder<List<Chat>>(
                stream: ChatsRepository.chatsStream(limit),
                builder: (_, snap) {
                  chats = snap.data ?? chats;
                  return SmartRefresher(
                    controller: refreshController,
                    enablePullDown: chats.length >= limit,
                    onLoading: () {
                      refreshController.loadComplete();
                      setState(() => limit += 20);
                    },
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: chats.length,
                      itemBuilder: (_, i) => ChatTile(chats[i]),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    refreshController.dispose();
    super.dispose();
  }
}
