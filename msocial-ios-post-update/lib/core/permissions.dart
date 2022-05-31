import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:permission_handler/permission_handler.dart';

mixin AppPermissions {
  //----- Storage Permission
  static var _isStorageGaranted = false;
  static Future<bool> checkStoragePermission() async {
    if (_isStorageGaranted) return true;
    if (kIsWeb || !Platform.isAndroid) {
      _isStorageGaranted = true;
    }
    _isStorageGaranted = await Permission.storage.isGranted;

    if (_isStorageGaranted != true) {
      _isStorageGaranted = (await Permission.storage.request()).isGranted;
    }
    return _isStorageGaranted;
  }

  static var _isMicroGaranted = false;
  static Future<bool> isMicroGaranted() async {
    if (_isMicroGaranted) return true;
    return _isMicroGaranted = await Permission.microphone.isGranted;
  }

  static Future<bool> requestMicroPermission() async {
    if (await isMicroGaranted()) return true;
    _isMicroGaranted = (await Permission.microphone.request()).isGranted;
    return _isMicroGaranted && await checkStoragePermission();
  }
}
