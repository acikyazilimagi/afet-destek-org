// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';

class TextThemeLight {
  TextThemeLight._init();
  static TextThemeLight? _instance;
  static TextThemeLight get instance {
    _instance ??= TextThemeLight._init();
    return _instance!;
  }

  final TextStyle headline1 = const TextStyle(fontWeight: FontWeight.w600, fontSize: 96, letterSpacing: -1.5);
  final TextStyle headline2 = const TextStyle(fontWeight: FontWeight.w600, letterSpacing: -0.5, fontSize: 60);
  final TextStyle headline3 = const TextStyle(fontWeight: FontWeight.w600, fontSize: 48);
  final TextStyle headline4 = const TextStyle(fontWeight: FontWeight.w600, letterSpacing: 0.25, fontSize: 34);
  final TextStyle headline5 = const TextStyle(fontWeight: FontWeight.w600, fontSize: 24);
  final TextStyle headline6 = const TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16,
  );
  final TextStyle subtitle1 = const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15);
  final TextStyle subtitle2 = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );
  final TextStyle button = const TextStyle(fontSize: 16, fontWeight: FontWeight.w600);

/*   
  final subtitle1 = GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15);
 
  final bodyText1 = GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5);
  final bodyText2 = GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25);
  final button = GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25);
  final caption = GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4);
  final overline = GoogleFonts.roboto(fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5); */
}
