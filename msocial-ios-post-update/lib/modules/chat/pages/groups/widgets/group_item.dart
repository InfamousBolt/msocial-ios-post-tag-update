import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../imports.dart';
import '../../../data/group_msgs.dart';
import '../../../models/group.dart';

class GroupItem extends StatelessWidget {
  final Group group;
  const GroupItem(
    this.group, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 4),
      leading: AvatarWidget(
        group.photoURL,
        radius: 40,
      ),
      title: Text(
        group.name,
        style:
            GoogleFonts.basic(textStyle: Theme.of(context).textTheme.subtitle1),
      ),
      trailing: StreamBuilder<List<Message>>(
        stream: GroupMessagesRepository.msgsStream(group.id, 10),
        builder: (_, snapshot) {
          final msgs = [
            for (final m in snapshot.data ?? <Message>[])
              if (!m.isSeenByMe) m
          ];
          return Badge(
            showBadge: msgs.isNotEmpty,
            badgeContent: Text(
              msgs.length > 9 ? '9+' : ' ${msgs.length} ',
              style: TextStyle(color: Colors.white),
            ),
          );
        },
      ),
      onTap: () => ChatRoutes.toGroupChat(group.id),
    );
  }
}
