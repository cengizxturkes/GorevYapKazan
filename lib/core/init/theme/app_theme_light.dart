import 'package:flutter/material.dart';

import 'app_theme.dart';
import 'color_manager.dart';

class AppThemeLight extends AppTheme {
  static AppThemeLight? _instance;
  static AppThemeLight get instance {
    _instance ??= AppThemeLight._init();
    return _instance!;
  }

  AppThemeLight._init();
  @override
  ThemeData get theme => ThemeData(
        splashFactory: NoSplash.splashFactory,
        scaffoldBackgroundColor: ColorManager.instance.white,
        highlightColor: ColorManager.instance.transparent,
        focusColor: ColorManager.instance.transparent,
        hoverColor: ColorManager.instance.transparent,
        splashColor: ColorManager.instance.transparent,
        shadowColor: ColorManager.instance.transparent,
        fontFamily: "Roboto",
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: ColorManager.instance.darkGray,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: ColorManager.instance.white,
          centerTitle: true,
          iconTheme: IconThemeData(color: ColorManager.instance.black),
        ),
        primarySwatch: ColorManager.instance.materialBlack,
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      );
}
