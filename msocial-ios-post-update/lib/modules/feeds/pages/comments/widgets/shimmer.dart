import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';

class CommentShimmer extends StatelessWidget {
  final loadingAnimationBackground = Colors.black12;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.white,
      child: ListTile(
        leading: CircleAvatar(),
        title: Container(
          color: Colors.black12,
          height: 20,
        ),
        subtitle: Container(
          color: loadingAnimationBackground,
          height: 10,
        ),
      ),
    );
  }
}
