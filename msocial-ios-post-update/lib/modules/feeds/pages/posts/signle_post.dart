import 'package:flutter/material.dart';

import '../../../../imports.dart';
import '../../data/posts.dart';
import '../../models/post.dart';
import 'widgets/post_item.dart';
import 'widgets/shimmer.dart';

class SinglePostPage extends StatelessWidget {
  final String postID;
  const SinglePostPage(
    this.postID, {
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(
        titleStr: t.Post,
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<Post>(
          stream: PostsRepository.singlePostStream(postID),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return ShimmerPost();
            } else if (!snapshot.hasData) {
              return SizedBox();
            }
            return PostWidget(snapshot.data!, showMore: false);
          },
        ),
      ),
    );
  }
}
