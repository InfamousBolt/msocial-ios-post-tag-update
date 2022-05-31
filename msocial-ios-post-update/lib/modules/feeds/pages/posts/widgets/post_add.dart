import 'package:flutter/material.dart';

import '../../../../../imports.dart';

class AddPostWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: GestureDetector(
        onTap: FeedRoutes.toPostEditor,
        child: Row(
          children: <Widget>[
            AvatarWidget(
              authProvider.user!.photoURL,
              radius: 40,
            ),
            SizedBox(width: 12),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    children: [
                      Text(t.WhatOnMind),
                      Spacer(),
                      Icon(Icons.send),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
