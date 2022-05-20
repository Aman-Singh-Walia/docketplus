import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DocketThemes {
  static final dark = ThemeData(
    colorScheme: const ColorScheme.dark(primary: Colors.blue),
    appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light),
        elevation: 0.0,
        titleTextStyle: TextStyle(
            fontFamily: 'SF', fontWeight: FontWeight.bold, fontSize: 25.0)),
    primaryColor: CupertinoColors.activeBlue,
  );

  static final light = ThemeData(
    appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
        backgroundColor: CupertinoColors.systemBlue,
        elevation: 0.0,
        titleTextStyle: TextStyle(
            fontFamily: 'SF', fontWeight: FontWeight.bold, fontSize: 25.0)),
  );
}
