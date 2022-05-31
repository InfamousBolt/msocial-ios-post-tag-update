import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';

import '../../../data/posts.dart';
import '../../../models/post.dart';
import 'post_item.dart';

class UserPosts extends StatelessWidget {
  final String userId;

  const UserPosts(
    this.userId, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FirestoreListView<Post>(
      query: PostsRepository.userPostsQuery(userId, 10),
      itemBuilder: (_, s) => PostWidget(s.data()),
    );
  }
}
