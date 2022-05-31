import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import '../imports.dart';
import 'download_bar.dart';

Future<void> pushImagesPage(
  ImageModel img, {
  List<ImageModel> urls = const [],
}) async =>
    Get.to(() => ImagesPage(img, urls: urls));

class ImagesPage extends StatefulWidget {
  final ImageModel img;
  final bool isLocal;
  final List<ImageModel> urls;

  const ImagesPage(
    this.img, {
    Key? key,
    this.urls = const [],
    this.isLocal = false,
  }) : super(key: key);

  @override
  _ImagesPageState createState() => _ImagesPageState();
}

class _ImagesPageState extends State<ImagesPage> {
  late List<ImageModel> urls;
  int index = 0;

  @override
  void initState() {
    urls = {widget.img, ...widget.urls}.toList();
    index = urls.indexOf(widget.img);
    super.initState();
  }

  ImageModel get img => urls[index];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Hero(
            tag: widget.img,
            child: PageView.builder(
              itemCount: urls.length,
              controller: PageController(initialPage: index),
              onPageChanged: (i) async {
                index = i;
                setState(() {});
              },
              itemBuilder: (_, i) => PhotoView(
                imageProvider: (img.isLocal
                    ? FileImage(File(img.path))
                    : CachedNetworkImageProvider(img.path)) as ImageProvider,
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered,
                errorBuilder: (_, __, ___) => Image.asset(
                  Assets.images.blurred.path,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          ),
          Positioned(
            top: 28,
            left: 8,
            child: FloatingActionButton(
              heroTag: 'close',
              onPressed: Navigator.of(context).pop,
              mini: true,
              backgroundColor: theme.primaryColor.withOpacity(0.5),
              child: Icon(
                Icons.clear,
                color: theme.colorScheme.secondary,
              ),
            ),
          ),
          if (img.isLocal)
            Positioned(
              top: 28,
              right: 8,
              child: FloatingActionButton(
                heroTag: 'download',
                onPressed: () {
                  showDownloadProgressBar(widget.img.path);
                },
                mini: true,
                backgroundColor: theme.primaryColor.withOpacity(0.5),
                child: Icon(
                  Icons.file_download,
                  color: theme.colorScheme.secondary,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
