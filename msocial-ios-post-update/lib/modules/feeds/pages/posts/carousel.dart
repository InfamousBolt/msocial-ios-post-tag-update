import 'package:flutter/material.dart';

import 'package:flutter_linkify/flutter_linkify.dart';

import '../../../../imports.dart';
import '../../models/post.dart';

Future<void>? pushMediasPage(List<Post> posts, int index) =>
    Get.to(() => PostsCarouselPage(posts, index));

class PostsCarouselPage extends StatefulWidget {
  final List<Post> posts;
  final int index;

  const PostsCarouselPage(
    this.posts,
    this.index, {
    Key? key,
  }) : super(key: key);

  @override
  _PostsCarouselPageState createState() => _PostsCarouselPageState();
}

class _PostsCarouselPageState extends State<PostsCarouselPage> {
  late PageController pageController;
  @override
  void initState() {
    pageController = PageController(initialPage: widget.index);
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            scrollDirection: Axis.vertical,
            itemCount: widget.posts.length,
            controller: pageController,
            itemBuilder: (_, i) {
              final post = widget.posts[i];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (post.hasImage)
                    Expanded(
                      child: AppImage(
                        post.image!.copyWith(width: double.maxFinite),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  if (post.content.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      constraints: BoxConstraints(maxHeight: Get.height / 3),
                      child: SingleChildScrollView(
                        child: Linkify(
                          text: post.content,
                          onOpen: (l) => launchURL(l.url),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          Positioned.fill(
            bottom: null,
            child: Appbar(
              backgroundColor: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}
