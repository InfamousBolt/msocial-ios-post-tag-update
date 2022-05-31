import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../imports.dart';
import '../modules/auth/data/user.dart';

class UserItemWidget extends StatelessWidget {
  final String? userId;
  final String? subtitle;
  final Widget? trailing;

  const UserItemWidget(
    this.userId, {
    Key? key,
    this.subtitle,
    this.trailing,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future: UserRepository.fetchUser(userId),
      builder: (_, snapshot) {
        final user = snapshot.data;
        if (user == null) return SizedBox();
        return SizedBox(
          width: 300,
          child: ListTile(
            leading: AvatarWidget(
              user.photoURL,
              showBadge: user.isOnline,
              radius: 50,
            ),
            title: Text(
              user.isMe ? 'Me ' : user.username,
            ),
            subtitle: Text(subtitle ?? user.status),
            onTap: user.isMe ? null : () => AuthRoutes.toProfile(user.id),
          ),
        );
      },
    );
  }
}

class UsersList extends StatefulWidget {
  final List<String?> usersId;
  final String? title;

  const UsersList({Key? key, required this.usersId, this.title})
      : super(key: key);

  @override
  _UsersListState createState() => _UsersListState();
}

class _UsersListState extends State<UsersList>
    with AutomaticKeepAliveClientMixin {
  final _refreshController = RefreshController();

  int offset = 10;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ids = widget.usersId.take(offset).toList();
    return SmartRefresher(
      controller: _refreshController,
      enablePullUp: offset <= ids.length,
      enablePullDown: false,
      onLoading: () async {
        setState(() => offset += 10);
        _refreshController.loadComplete();
      },
      child: ListView.builder(
        itemCount: ids.length,
        itemBuilder: (_, i) => UserItemWidget(ids[i]),
      ),
    );
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }
}
