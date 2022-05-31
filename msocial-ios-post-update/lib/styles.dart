import 'package:flutter/material.dart';

//import 'core/preferences.dart';

mixin AppStyles {
  static const lightPrimaryColor = Colors.white;

  static final lightAccentColor = Color(0xff00ebff);
  static const darkPrimaryColor = Color(0xff013245);
  static final darkAccentColor = Color(0xff00ebff);

  static ThemeData get darkTheme => ThemeData.dark().copyWith(
        primaryColor: darkPrimaryColor,
        primaryColorDark: darkPrimaryColor,
        primaryColorLight: lightPrimaryColor,
        appBarTheme: ThemeData.dark().appBarTheme.copyWith(
              backgroundColor: darkPrimaryColor,
            ),
      );
  static ThemeData get lightTheme => ThemeData.light().copyWith(
        primaryColor: lightPrimaryColor,
        primaryColorLight: lightPrimaryColor,
        primaryColorDark: darkPrimaryColor,
        appBarTheme: ThemeData().appBarTheme.copyWith(
              backgroundColor: lightPrimaryColor,
            ),
      );
  static LinearGradient get primaryGradient => LinearGradient(
        colors: [lightPrimaryColor, theme.colorScheme.secondary],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

  static ThemeData get theme => lightTheme;
}

extension ThemeDataEx on ThemeData {
  Color get inversePrimaryColor =>
      brightness == Brightness.dark ? primaryColorLight : primaryColorDark;
}
