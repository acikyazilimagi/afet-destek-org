// ignore_for_file: lines_longer_than_80_chars

import 'package:deprem_destek/pages/shared/theme/yardim_agi_theme.dart';
import 'package:flutter/material.dart';

class TextThemeDark {
  TextThemeDark._init();
  static TextThemeDark? _instance;
  static TextThemeDark get instance {
    _instance ??= TextThemeDark._init();
    return _instance!;
  }

  final TextStyle headline1 = const TextStyle(
    fontFamily: ApplicationConstants.FONT_FAMILY,
    fontWeight: FontWeight.w600,
    fontSize: 96,
    letterSpacing: -1.5,
  );
  final TextStyle headline2 = const TextStyle(
    fontFamily: ApplicationConstants.FONT_FAMILY,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.5,
    fontSize: 60,
  );
  final TextStyle headline3 = const TextStyle(
    fontFamily: ApplicationConstants.FONT_FAMILY,
    fontWeight: FontWeight.w600,
    fontSize: 48,
  );
  final TextStyle headline4 = const TextStyle(
    fontFamily: ApplicationConstants.FONT_FAMILY,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.25,
    fontSize: 34,
  );
  final TextStyle headline5 = const TextStyle(
    fontFamily: ApplicationConstants.FONT_FAMILY,
    fontWeight: FontWeight.w600,
    fontSize: 24,
  );
  final TextStyle headline6 = const TextStyle(
    fontFamily: ApplicationConstants.FONT_FAMILY,
    fontWeight: FontWeight.w600,
    fontSize: 16,
  );
  final TextStyle subtitle2 = const TextStyle(
    fontFamily: ApplicationConstants.FONT_FAMILY,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
  );
  final TextStyle subtitle1 = const TextStyle(
    fontFamily: ApplicationConstants.FONT_FAMILY,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
  );
  final TextStyle button = const TextStyle(
    fontFamily: ApplicationConstants.FONT_FAMILY,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

/*   
  final subtitle1 = GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15);
  final subtitle2 = GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1);
  final bodyText1 = GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5);
  final bodyText2 = GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25);
  final button = GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25);
  final caption = GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4);
  final overline = GoogleFonts.roboto(fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5); */
}
