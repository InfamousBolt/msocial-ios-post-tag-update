import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../imports.dart';

class TextMsgItem extends StatelessWidget {
  final Message msg;

  const TextMsgItem(
    this.msg, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.only(top: 2),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      constraints: BoxConstraints(maxWidth: context.width - 100),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: theme.backgroundColor,
      ),
      child: Linkify(
        onOpen: (l) => launchURL(l.url),
        text: msg.content,
        style: GoogleFonts.basic(
          textStyle: theme.textTheme.subtitle1,
        ),
      ),
    );
  }
}
