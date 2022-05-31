import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/notifications.dart';
import '../../models/notification.dart';

class NotificationItem extends StatelessWidget {
  final NotificationModel not;

  const NotificationItem(
    this.not, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 6, right: 8, left: 8),
      child: Material(
        color: theme.brightness == Brightness.dark
            ? theme.primaryColorDark.withAlpha(80)
            : theme.primaryColorLight.withAlpha(100),
        borderRadius: BorderRadius.circular(8),
        child: GestureDetector(
          onTap: () => NotificationRepo.onNotificationTap(not),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Row(
              children: <Widget>[
                Icon(icon),
                SizedBox(width: 12),
                Flexible(
                  child: Text(
                    not.text,
                    style:
                        GoogleFonts.basic(textStyle: theme.textTheme.subtitle1),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData get icon {
    if (not.isFollow) {
      return FontAwesomeIcons.userPlus;
    } else if (not.isPostReaction) {
      return Icons.favorite;
    } else if (not.isComment) {
      return FontAwesomeIcons.comment;
    } else {
      return FontAwesomeIcons.heart;
    }
  }
}
