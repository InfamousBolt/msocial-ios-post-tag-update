import 'package:flutter/material.dart';

import '../../../../imports.dart';
import '../../data/groups.dart';
import '../../models/group.dart';

class GroupInfoPage extends StatefulWidget {
  final Group group;
  const GroupInfoPage(
    this.group, {
    Key? key,
  }) : super(key: key);

  @override
  _GroupInfoPageState createState() => _GroupInfoPageState();
}

class _GroupInfoPageState extends State<GroupInfoPage> {
  Group get group => widget.group;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: Appbar(
        titleStr: group.name,
        actions: [
          if (group.isAdmin() || authProvider.user!.isAdmin)
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () async {
                await ChatRoutes.toGroupEditor(group);
                setState(() {});
              },
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: context.height - 80,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              AvatarWidget(
                group.photoURL,
                radius: 120,
              ),
              SizedBox(height: 20),
              Text(
                group.name,
                style: theme.textTheme.headline6,
              ),
              SizedBox(height: 20),
              //Members
              ListTile(
                title: Text(t.Members),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('${group.members.length}'),
                    SizedBox(width: 12),
                    Icon(Icons.keyboard_arrow_right)
                  ],
                ),
                onTap: () => ChatRoutes.toGroupMembers(widget.group),
              ),

              //Notifications
              if (group.isMember())
                SwitchListTile.adaptive(
                  value: !group.isMuted(),
                  title: Text(t.Notifications),
                  subtitle: Text(group.isMuted() ? t.Off : t.On),
                  onChanged: (_) {
                    setState(() => group.toggleMute());
                    GroupsRepository.muteOrUnmuteGroup(group);
                  },
                ),

              Spacer(flex: 4),
              if (!group.isAdmin())
                AppButton(
                  group.isMember() ? t.LeaveGroup : t.Join,
                  onTap: () {
                    group.toggleJoin();
                    GroupsRepository.joinOrLeaveGroup(group);
                    Navigator.of(context).popUntil((r) => r.isFirst);
                    if (group.isMember()) {
                      ChatRoutes.toGroupChat(group.id);
                    }
                  },
                ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
