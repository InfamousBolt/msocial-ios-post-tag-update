import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../imports.dart';
import 'crop.dart';

Future<FileModel?> pickFile(
  BuildContext context, {
  bool? enableVideo,
  bool? enableCrop,
}) =>
    showMaterialModalBottomSheet(
      context: context,
      builder: (_) => MediaPickerWidget(
        enableVideo: enableVideo ?? false,
        enableCrop: enableCrop ?? false,
      ),
    );

class MediaPickerWidget extends StatelessWidget {
  final bool enableVideo;
  final bool enableCrop;

  const MediaPickerWidget({
    this.enableVideo = false,
    this.enableCrop = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 24, 16, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _AttachmentBtn(
            text: t.PhotosLibrary.toUpperCase(),
            icon: Icons.image,
            onPressed: () => _onPickImage(context, ImageSource.gallery),
          ),
          _AttachmentBtn(
            icon: Icons.camera_alt,
            text: t.TakePicture.toUpperCase(),
            onPressed: () => _onPickImage(context, ImageSource.camera),
          ),
          if (enableVideo)
            _AttachmentBtn(
              text: t.VideosLibrary.toUpperCase(),
              icon: Icons.video_library,
              onPressed: () => _onPickVideo(context, ImageSource.gallery),
            ),
          if (enableVideo)
            _AttachmentBtn(
              text: t.RecordVideo.toUpperCase(),
              icon: Icons.videocam,
              onPressed: () => _onPickVideo(context, ImageSource.camera),
            ),
        ],
      ),
    );
  }

  Future<void> _onPickImage(BuildContext context, ImageSource source) async {
    final picked = await ImagePicker().pickImage(
      source: source,
      imageQuality: appConfigs.imageCompressQuality,
    );
    String path = picked?.path ?? '';
    if (path.isEmpty) {
      Get.back();
      return;
    }
    if (enableCrop) {
      path = await Get.to(() => CropImgWidget(path)) ?? '';
    }
    final img = await ImageModel.create(path);
    Get.back(result: img);
  }

  Future<void> _onPickVideo(BuildContext context, ImageSource source) async {
    // final picked = await ImagePicker().getVideo(
    //   source: source,
    //   maxDuration: Duration(minutes: appConfigs.maxVideoDuration),
    // );
    // BotToast.showLoading();
    // final vid = await asyncGuard(() => VideoModel.create(picked?.path ?? ''));
    // BotToast.closeAllLoading();
    Get.back();
  }
}

class _AttachmentBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final String text;
  const _AttachmentBtn({
    Key? key,
    required this.icon,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.fromLTRB(0, 8, 8, 0),
      onPressed: onPressed,
      child: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 32),
            child: Text(
              text,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
