import 'package:flutter/material.dart';

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../imports.dart';
import '../../data/groups.dart';
import '../../models/group.dart';

class GroupMembersPage extends StatefulWidget {
  final Group group;
  const GroupMembersPage(
    this.group, {
    Key? key,
  }) : super(key: key);
  @override
  _GroupMembersPageState createState() => _GroupMembersPageState();
}

class _GroupMembersPageState extends State<GroupMembersPage> {
  Group get group => widget.group;
  String get uid => authProvider.user!.id;

  final pagingController = PagingController<int, User>(firstPageKey: 0);
  @override
  void initState() {
    pagingController.addPageRequestListener((p) async {
      try {
        final res = await GroupsRepository.fetchMembers(group.id, p);
        if (res.length < 20) {
          pagingController.appendLastPage(res);
        } else {
          pagingController.appendPage(res, p + 1);
        }
      } catch (e) {
        logError(e);
        pagingController.error = e;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(
        title: ListTile(
          contentPadding: EdgeInsets.all(0),
          leading: AvatarWidget(
            group.photoURL,
            radius: 40,
          ),
          title: Text(group.name),
          subtitle: Text(
            '${group.members.length} ${t.Members}',
            style: TextStyle(fontSize: 11),
          ),
        ),
      ),
      body: PagedListView<int, User>(
        pagingController: pagingController,
        builderDelegate: PagedChildBuilderDelegate(
          itemBuilder: (_, user, __) => _MemberItem(
            user,
            group,
            onRemoveMember: onRemoveMember,
            onToggleBlock: onToggleBlock,
          ),
        ),
      ),
    );
  }

  Future<void> onRemoveMember(String userId) async {
    pagingController.value = pagingController.value.copyWith(
      itemList: [
        for (final it in pagingController.value.itemList ?? <User>[])
          if (it.id != userId) it
      ],
    );
    setState(() => group.toggleJoin());
    await GroupsRepository.joinOrLeaveGroup(group, userId);
  }

  Future<void> onToggleBlock(String userId) async {
    pagingController.value = pagingController.value;
    setState(() => group.toggleBlock());
    await GroupsRepository.blocUnblocUser(group);
  }
}

class _MemberItem extends StatelessWidget {
  final User user;
  final Group group;
  final ValueChanged<String>? onRemoveMember;
  final ValueChanged<String>? onToggleBlock;
  const _MemberItem(
    this.user,
    this.group, {
    Key? key,
    this.onRemoveMember,
    this.onToggleBlock,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      leading: AvatarWidget(
        user.photoURL,
        radius: 50,
      ),
      title: Row(
        children: <Widget>[
          Text(user.isMe ? 'Me' : user.fullName),
          Spacer(),
          if (group.isAdmin(user.id))
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.yellow),
              ),
              child: Text(t.Admin),
            )
        ],
      ),
      subtitle: Text(user.username),
      trailing: group.isAdmin() && !group.isAdmin(user.id) && !user.isMe
          ? PopupMenuButton<int>(
              itemBuilder: (_) => [
                PopupMenuItem(
                  value: 0,
                  child: Text(
                    group.isBlocked(user.id) ? t.Unblock : t.Block,
                  ),
                ),
                PopupMenuItem(
                  value: 1,
                  child: Text(t.RemoveMember),
                ),
              ],
              onSelected: (v) async {
                if (v == 0) {
                  onToggleBlock?.call(user.id);
                } else if (v == 1) {
                  onRemoveMember?.call(user.id);
                }
              },
            )
          : null,
      onTap: user.isMe ? null : () => AuthRoutes.toProfile(user.id),
    );
  }
}
