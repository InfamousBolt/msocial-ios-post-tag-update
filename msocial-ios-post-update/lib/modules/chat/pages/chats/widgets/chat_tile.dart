import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart';

import '../../../../../imports.dart';
import '../../../../auth/data/user.dart';
import '../../../data/chat_msgs.dart';
import '../../../models/chat.dart';
import '../../conversation/widgets/typing.dart';

class ChatTile extends StatefulWidget {
  final Chat chat;
  const ChatTile(
    this.chat, {
    Key? key,
  }) : super(key: key);

  @override
  _ChatTileState createState() => _ChatTileState();
}

class _ChatTileState extends State<ChatTile> {
  String get currentUserId => authProvider.user!.id;
  User? user;
  List<Message> msgs = [];
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: UserRepository.userStream(widget.chat.getSenderId),
      builder: (_, snap) {
        user = snap.data ?? user;
        if (user == null) return SizedBox();
        return StreamBuilder<List<Message>>(
          stream: MessagesRepository.msgsStream(widget.chat.id, 10),
          builder: (_, msgsSnap) {
            msgs = msgsSnap.data ?? msgs;
            if (msgs.isEmpty) return SizedBox();
            final unreadMsgs = [
              for (final m in msgs)
                if (!m.isSeenByMe) m.id
            ];
            final msg = msgs.first;
            return ListTile(
              leading: Hero(
                tag: 'chat-${widget.chat.id}',
                child: AvatarWidget(
                  user!.photoURL,
                  radius: 50,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 4),
              title: Text(
                user!.username,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              subtitle: widget.chat.isTyping
                  ? TypingWidget()
                  : Text(
                      msg.isSending ? 'Sending... ' : msg.desc,
                      style: TextStyle(
                        fontSize: 18,
                        color: msg.isSending
                            ? context.theme.inversePrimaryColor
                            : Colors.grey,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
              trailing: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: <Widget>[
                    Badge(
                      showBadge: unreadMsgs.isNotEmpty,
                      badgeContent: Text(
                        '${unreadMsgs.length}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Text(
                      format(msg.createdAt, locale: 'en_short'),
                    ),
                  ],
                ),
              ),
              onTap: () => ChatRoutes.toPrivateChat(user!.id),
            );
          },
        );
      },
    );
  }
}
