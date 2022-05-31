import 'package:flutter/material.dart';

import '../../imports.dart';
import '../feeds/data/posts.dart';
import '../feeds/models/post.dart';
import 'widget/post_item.dart';

class ReportedPostsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(t.ReportedPosts),
        centerTitle: true,
      ),
      body: StreamBuilder<List<Post>>(
        stream: PostsRepository.reportedPostsStream(),
        builder: (_, snap) {
          final posts = snap.data ?? <Post>[];
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (_, i) => AdminPostWidget(posts[i]),
          );
        },
      ),
    );
  }
}
