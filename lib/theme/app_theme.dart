import 'package:deprem_destek/theme/utils/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

class AppTheme {
  AppTheme._();
  static ThemeData ThemeLight(BuildContext context) {
    return ThemeData(
        brightness: Brightness.light,
        // theme_color classimizin kullanimi
        // primaryColor: LightThemeColor.white
    );
  }

  static ThemeData ThemeDark(BuildContext context) {
    return ThemeData(
        brightness: Brightness.dark,
        // theme_color classimizin kullanimi
        // primaryColor: DarkThemeColor.black
    );
  }

  static Brightness get currentSystemBrightness =>
      SchedulerBinding.instance.window.platformBrightness;

  static void setStatusBarAndNavigationBarColors(ThemeMode themeMode) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness:
      themeMode == ThemeMode.light ? Brightness.dark : Brightness.light,
    ),);
  }
}