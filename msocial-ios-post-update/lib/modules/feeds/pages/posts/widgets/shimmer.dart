import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';

class ShimmerPost extends StatelessWidget {
  final loadingAnimationBackground = Colors.black12;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.white,
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        constraints: BoxConstraints(maxHeight: 300),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(),
              title: Container(
                height: 20,
                color: loadingAnimationBackground,
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Container(
                  width: double.infinity,
                  height: 80,
                  color: loadingAnimationBackground,
                ),
              ),
            ),
            Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.favorite_border),
                  onPressed: () {},
                ),
                Spacer(),
                IconButton(icon: Icon(Icons.mode_comment), onPressed: () {}),
              ],
            )
          ],
        ),
      ),
    );
  }
}
