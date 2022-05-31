import 'package:flutter/material.dart';

import '../../../../../../imports.dart';

class ImageMsgItem extends StatelessWidget {
  final Message msg;

  const ImageMsgItem(
    this.msg, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uploader = AppUploader.find(msg.image!.path);
    return Hero(
      tag: msg.id,
      child: GestureDetector(
        onTap: () => pushImagesPage(msg.image!),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: 400,
            maxWidth: 300,
            minHeight: 100,
            minWidth: 100,
          ),
          child: AspectRatio(
            aspectRatio: msg.image!.ratio,
            child: Stack(
              children: [
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: AppImage(
                      msg.image!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                if (msg.image!.isLocal && uploader?.state != null)
                  Obx(
                    () => uploader!.state.maybeWhen(
                      orElse: () => AppLoadingIndicator(),
                      uploading: (p) => AppLoadingIndicator(value: p),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
