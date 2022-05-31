import 'package:flutter/material.dart';

import '../../../models/post_query.dart';

class PostsSortingWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final PostQuery postQuery;
  final void Function(PostQuery value)? onChange;

  const PostsSortingWidget(
    this.postQuery, {
    Key? key,
    this.onChange,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,

      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          for (final s in PostQuery.values)
            GestureDetector(
              onTap: () => onChange?.call(s),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Chip(
                  backgroundColor: s == postQuery ? Color(0xff4ce9f6) : Color.fromRGBO(245, 199, 192, 1.0),
                  label: Text(s.text),
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, 40);
}
