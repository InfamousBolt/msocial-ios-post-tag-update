import 'package:flutter/material.dart';

import '../../../../components/user_list.dart';
import '../../../../imports.dart';
import '../../../feeds/pages/posts/widgets/user_posts.dart';
import '../../data/user.dart';
import 'widgets/header.dart';
import 'widgets/tab_item.dart';

class ProfilePage extends StatefulWidget {
  final String? userID;

  const ProfilePage({
    Key? key,
    this.userID,
  }) : super(key: key);
  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<ProfilePage> {
  Rxn<User> rxUser = Rxn<User>();
  @override
  Widget build(BuildContext context) => Obx(() {
        if (rxUser() == null) return Scaffold();
        if (rxUser()!.isMe) {
          rxUser = authProvider.rxUser;
        }
        final user = rxUser()!;
        return DefaultTabController(
          length: 3,
          child: Scaffold(
            body: NestedScrollView(
              headerSliverBuilder: (_, v) => [
                SliverAppBar(
                  expandedHeight: user.isMe ? 400 : 450,
                  pinned: true,
                  floating: true,
                  flexibleSpace: ProfileHeader(rxUser),
                  leading: SizedBox(),
                  bottom: TabBar(
                    tabs: [
                      ProfileTabItem(
                        title: t.POSTS,
                        info: '${user.posts.length}',
                      ),
                      ProfileTabItem(
                        title: t.FOLLOWERS,
                        info: '${user.followers.length}',
                      ),
                      ProfileTabItem(
                        title: t.FOLLOWINGS,
                        info: '${user.following.length}',
                      ),
                    ],
                  ),
                ),
              ],
              body: SizedBox(
                height: 50,
                child: TabBarView(
                  children: [
                    UserPosts(user.id),
                    UsersList(
                      usersId: user.followers,
                    ),
                    UsersList(
                      usersId: user.following,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      });

  @override
  void initState() {
    if (widget.userID?.isNotEmpty == true) {
      UserRepository.fetchUser(widget.userID).then(rxUser);
    } else {
      rxUser = authProvider.rxUser;
    }
    super.initState();
  }
}
