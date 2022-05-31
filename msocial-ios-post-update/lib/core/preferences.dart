import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/app_page.dart';

AppPreferences get appPrefs => Get.find();

class AppPreferences {
  final routeObserver = RouteObserver<PageRoute>();
  AppPage page = AppPage.others();

  final SharedPreferences prefs;
  AppPreferences._(this.prefs);
  static Future<void> init() async {
    final p = AppPreferences._(await SharedPreferences.getInstance());
    p.isDarkMode(p.prefs.getBool(DARK_MODE_KEY) ?? false);
    Get.put(p);
  }

  static const DARK_MODE_KEY = 'DARK_MODE_KEY';
  final isDarkMode = false.obs;
  void changeThemeMode() {
    isDarkMode.toggle();
    prefs.setBool(DARK_MODE_KEY, isDarkMode());
  }

  final drawerState = DrawerState.GROUPS.obs;
}

enum DrawerState {
  GROUPS,
  Notifications,
}
