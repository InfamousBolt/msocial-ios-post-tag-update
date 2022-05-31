// @dart=2.9

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'components/connectivity.dart';
import 'firebase_options.dart';
import 'imports.dart';
import 'modules/auth/pages/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocaleSettings.useDeviceLocale();
  // Initalize Fierbase Core for app, necessary for firebase to work
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  //Load App Configs
  await AppConfigs.init();
  // Initialize app preferences and settings
  await AppPreferences.init();
  // Initialize Authentication, check if user logged In
  await AuthProvider.init();
  // Report uncaught errors to Firebase
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final ads = Get.put(AdsHelper());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: t.AppName,
        builder: (_, w) => ConnectivityWidget(
          builder: (_, __) => BotToastInit()(_, w),
        ),
        navigatorObservers: [
          BotToastNavigatorObserver(),
          appPrefs.routeObserver,
        ],
        themeMode: ThemeMode.light,
        theme: AppStyles.lightTheme,
        darkTheme: AppStyles.darkTheme,
        home: HomePage(),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: LocaleSettings.supportedLocales,
    );
  }

  @override
  void dispose() {
    ads.dispose();
    super.dispose();
  }
}
