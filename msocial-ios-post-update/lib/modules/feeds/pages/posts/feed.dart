import 'dart:async';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../components/drawer.dart';
import '../../../../core/models/userPostBusiness.dart';
import '../../../../imports.dart';
import '../../../auth/data/user.dart';
import '../../../chat/pages/chats/widgets/chat_icon.dart';
import '../../../notifications/provider.dart';
import '../../data/posts.dart';
import '../../models/post.dart';
import '../../models/post_query.dart';
import 'widgets/post_add.dart';
import 'widgets/post_item.dart';
import 'widgets/shimmer.dart';
import 'widgets/sorting_widget.dart';

class FeedPage extends StatefulWidget {
  @override
  _PostsScreenState createState() => _PostsScreenState();
}

class _PostsScreenState extends State<FeedPage> with WidgetsBindingObserver {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final scrolleController = ScrollController();
  String get uid => authProvider.user!.id;

  final paging = PagingController<int, Post>(firstPageKey: 0);
  StreamSubscription<User>? userSub;

  PostQuery postSorter = PostQuery.newest();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    paging.addPageRequestListener((page) async {
      try {
        final res = await PostsRepository.fetchPosts(postSorter, uid, page);
        if (res.length < 20) {
          paging.appendLastPage(res);
        } else {
          paging.appendPage(res, page + 1);
        }
      } catch (e, s) {
        logError("", e, s);
        paging.error = e;
      }
    });
    userSub =
        UserRepository.userStream()?.listen((e) => authProvider.rxUser(e));
    Get.put<PagingController>(paging);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    scrolleController.dispose();
    notificationProvider.dispose();
    userSub?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      UserRepository.updateActiveAt(false);
    } else if (state == AppLifecycleState.resumed) {
      UserRepository.updateActiveAt(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: HomeDrawer(),
      appBar: AppBar(
        elevation: 0,
        title: Image.asset('assets/images/mfeed.png', fit: BoxFit.cover),
        titleSpacing: 0,
        backgroundColor: Colors.white,
        leading: context.isTablet
            ? SizedBox()
            : IconButton(
                icon: Icon(Icons.menu, color: Colors.black),
                onPressed: () => scaffoldKey.currentState!.openDrawer(),
              ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black,),
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserPostBusiness()),
              );
            },
          ),
          ChatIcon(),
        ],
        bottom: PostsSortingWidget(
          postSorter,
          onChange: (v) {
            setState(() => postSorter = v);
            paging.refresh();
          },
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          paging.refresh();
          await 1.delay();
        },
        child: Row(
          children: [
            if (context.isTablet) HomeDrawer(),
            Flexible(
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 500,
                  ),
                  child: PagedListView<int, Post>(
                    pagingController: paging,
                    builderDelegate: PagedChildBuilderDelegate(
                      itemBuilder: (_, p, i) => Column(
                        children: <Widget>[
                          if (i == 0) AddPostWidget(),
                          if (i % 5 == 0) Get.find<AdsHelper>().banner(),
                          if (p.show) PostWidget(p),
                        ],
                      ),
                      newPageProgressIndicatorBuilder: (_) => ShimmerPost(),
                      firstPageProgressIndicatorBuilder: (_) => ShimmerPost(),
                      noItemsFoundIndicatorBuilder: (_) => Align(
                        alignment: Alignment.topCenter,
                        child: AddPostWidget(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
