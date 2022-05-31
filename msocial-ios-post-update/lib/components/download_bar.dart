import 'dart:async';

import 'package:flutter/material.dart';

import 'package:image_downloader/image_downloader.dart';

import '../core/permissions.dart';
import '../imports.dart';

Future<void> showDownloadProgressBar(String imgURL) async {
  await AppPermissions.checkStoragePermission();
  final progressStream = StreamController<double>();
  BotToast.showCustomLoading(
    toastBuilder: (_) => StreamBuilder<double>(
      stream: progressStream.stream,
      initialData: 0,
      builder: (ctx, snap) => Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        color: ctx.theme.primaryColor,
        width: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              '${t.Downloading} ${(snap.data! * 100).toInt()}%',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 10),
            LinearProgressIndicator(value: snap.data),
          ],
        ),
      ),
    ),
  );
  try {
    // download image and save it
    await ImageDownloader.downloadImage(
      imgURL,
      destination: AndroidDestinationType.directoryPictures,
    );
    ImageDownloader.callback(
      onProgressUpdate: (_, progress) {
        progressStream.add(progress.toDouble());
      },
    );
    BotToast.showText(
      text: 'Download Finished',
      duration: Duration(seconds: 4),
    );
  } catch (e) {
    logError(e);
    BotToast.showText(text: 'Oops! Failed To Download');
  }
  BotToast.closeAllLoading();
  await progressStream.close();
}
