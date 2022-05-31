import 'package:flutter/material.dart';

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../../imports.dart';
import '../../../data/posts.dart';
import '../../../models/post.dart';

class PostImageWidget extends StatefulWidget {
  final Post post;
  final VoidCallback? onTap;

  const PostImageWidget(
    this.post, {
    Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  _PostImageWidgetState createState() => _PostImageWidgetState();
}

class _PostImageWidgetState extends State<PostImageWidget> {
  ImageModel get img => widget.post.image!;

  @override
  Widget build(BuildContext context) {
    final uploader = AppUploader.find(img.path);
    return GestureDetector(
      onTap: () => pushImagesPage(img),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: 500,
          minWidth: context.width,
        ),
        child: AspectRatio(
          aspectRatio: img.ratio,
          child: Stack(
            children: [
              Positioned.fill(
                child: AppImage(
                  img,
                  fit: BoxFit.fitWidth,
                ),
              ),
              if (img.isLocal)
                uploader != null
                    ? Obx(
                        () => uploader.state.maybeWhen(
                          orElse: () => AppLoadingIndicator(),
                          uploading: (p) => AppLoadingIndicator(value: p),
                        ),
                      )
                    : Center(
                        child: IconButton(
                          icon: Icon(Icons.replay_outlined, size: 40),
                          onPressed: resend,
                        ),
                      ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> resend() async {
    AppUploader()
      ..setAsPicked(widget.post.image)
      ..upload(
        StorageHelper.postsImageRef,
        onSuccess: (f) => f.when(
          image: (img) async {
            await PostsRepository.addPost(widget.post.copyWith(image: img));
            Get.find<PagingController>().refresh();
          },
        ),
      );
    setState(() {});
  }
}
