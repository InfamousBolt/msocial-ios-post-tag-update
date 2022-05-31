import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:intl/intl.dart';

import '../../../../../../imports.dart';
import 'image.dart';
import 'text.dart';

class MessageItem extends StatefulWidget {
  final int index;
  final List<Message> msgs;
  final ValueChanged<Message> onEdit;
  final ValueChanged<Message> onDelete;
  final bool isGroupAdmin;

  const MessageItem({
    Key? key,
    required this.index,
    required this.msgs,
    required this.onEdit,
    required this.onDelete,
    this.isGroupAdmin = false,
  }) : super(key: key);

  @override
  _MessageItemState createState() => _MessageItemState();
}

class _MessageItemState extends State<MessageItem> {
  bool get isAdmin => authProvider.user!.isAdmin;

  int get maxIndex => widget.msgs.length - 1;

  Message get msg => widget.msgs[widget.index];

  Message get msgAfter =>
      widget.msgs[widget.index == maxIndex ? widget.index : widget.index + 1];

  @override
  Widget build(BuildContext context) {
    return FocusedMenuHolder(
      menuItems: _menuItems(),
      onPressed: () {},
      child: Column(
        children: [
          // Time Separator
          if (widget.index == maxIndex ||
              msg.createdAt.day != msgAfter.createdAt.day)
            Align(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  DateFormat.MMMMd().format(msg.createdAt),
                ),
              ),
            ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment:
                msg.isFromMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!msg.isFromMe && msg.isGroup)
                GestureDetector(
                  onTap: () => AuthRoutes.toProfile(msg.fromID),
                  child: AvatarWidget(msg.fromPhotoURL, radius: 30),
                ),
              SizedBox(width: 8),
              Flexible(
                child: Column(
                  crossAxisAlignment: msg.isFromMe
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    // User Avatar only for group
                    if (!msg.isFromMe && msg.isGroup)
                      AppText(msg.fromName, size: 12),
                    SizedBox(height: 4),
                    if (msg.isImage) ImageMsgItem(msg) else TextMsgItem(msg),
                    _TimeWidget(msg),
                  ],
                ),
              ),
              SizedBox(width: 8),
            ],
          ),
        ],
      ),
    );
  }

  List<FocusedMenuItem> _menuItems() => [
        if (msg.isFromMe && msg.isText)
          FocusedMenuItem(
            backgroundColor: context.theme.scaffoldBackgroundColor,
            title: Text(t.Edit),
            trailingIcon: Icon(Icons.edit),
            onPressed: () => widget.onEdit(msg),
          ),
        if (msg.isText)
          FocusedMenuItem(
            backgroundColor: context.theme.scaffoldBackgroundColor,
            title: Text(t.Copy),
            trailingIcon: Icon(Icons.copy),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: msg.content));
              BotToast.showText(text: t.Copied);
            },
          ),
        if (msg.isFromMe || isAdmin || widget.isGroupAdmin)
          FocusedMenuItem(
            backgroundColor: context.theme.scaffoldBackgroundColor,
            title: Text(
              t.Delete,
              style: TextStyle(color: Colors.redAccent),
            ),
            trailingIcon: Icon(
              Icons.delete,
              color: Colors.redAccent,
            ),
            onPressed: () => widget.onDelete(msg),
          ),
      ];
}

class _TimeWidget extends StatelessWidget {
  final Message msg;

  const _TimeWidget(
    this.msg, {
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Row(
        mainAxisAlignment:
            msg.isFromMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Text(
            DateFormat.Hm().format(msg.createdAt),
            style: TextStyle(fontSize: 10),
            textAlign: TextAlign.end,
          ),
          SizedBox(width: 8),
          if (msg.isFromMe && !msg.isGroup)
            Icon(
              msg.isRead
                  ? Icons.done_all
                  : msg.isSent
                      ? Icons.check_rounded
                      : Icons.watch_later_outlined,
              size: 15,
            ),
        ],
      ),
    );
  }
}
