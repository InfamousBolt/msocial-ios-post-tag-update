import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_crop/image_crop.dart';

import '../imports.dart';

class CropImgWidget extends StatefulWidget {
  final String imgPath;
  const CropImgWidget(
    this.imgPath, {
    Key? key,
  }) : super(key: key);

  @override
  _CropImgWidgetState createState() => _CropImgWidgetState();
}

class _CropImgWidgetState extends State<CropImgWidget> {
  final cropKey = GlobalKey<CropState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Crop.file(
            File(widget.imgPath),
            key: cropKey,
            aspectRatio: 1,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 20.0),
          alignment: AlignmentDirectional.center,
          child: TextButton(
            onPressed: () => _cropImage(),
            child: Text(
              t.Save,
            ),
          ),
        )
      ],
    );
  }

  Future<void> _cropImage() async {
    final scale = cropKey.currentState?.scale;
    final area = cropKey.currentState?.area;
    if (area == null || scale == null) {
      BotToast.showText(text: 'Oops, Something went wrong, Cannot crop!');
      return;
    }

    // scale up to use maximum possible number of pixels
    // this will sample image in higher resolution to make cropped image larger
    final sample = await ImageCrop.sampleImage(
      file: File(widget.imgPath),
      preferredSize: (2000 / scale).round(),
    );

    final file = await ImageCrop.cropImage(
      file: sample,
      area: area,
    );
    sample.delete();

    Get.back(result: file.path);
  }
}
