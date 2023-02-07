// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';

import 'package:deprem_destek/pages/shared/theme/yardim_agi_theme.dart';
import 'package:deprem_destek/pages/shared/theme/theme/app_theme.dart';
import 'package:deprem_destek/pages/shared/theme/theme/dark/dark_theme_interface.dart';

class AppThemeDark extends AppTheme with IDarkTheme {
  AppThemeDark._init();
  static AppThemeDark? _instance;
  static AppThemeDark get instance {
    _instance ??= AppThemeDark._init();
    return _instance!;
  }

  ThemeData get darkTheme => ThemeData.dark(useMaterial3: true).copyWith(
        textTheme: textTheme(),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: colorSchemeDark.baseBlack,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        radioTheme: RadioThemeData(
          fillColor: MaterialStatePropertyAll(
            colorSchemeDark.baseWhite,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.black,
          hintStyle: textThemeDark.headline6.copyWith(color: colorSchemeDark.baseWhite),
          labelStyle: textThemeDark.headline6.copyWith(color: colorSchemeDark.baseWhite, fontWeight: FontWeight.w400),
          helperStyle: textThemeDark.subtitle2.copyWith(
            color: colorSchemeDark.baseDarkGrey,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        elevatedButtonTheme: elevatedButtonTheme(),
        iconTheme: _iconThemeData(),
        checkboxTheme: CheckboxThemeData(
          checkColor: MaterialStatePropertyAll(colorSchemeDark.baseWhite),
          fillColor: MaterialStatePropertyAll(colorSchemeDark.baseBlack),
        ),
        colorScheme: _appColorScheme(),
      );

  IconThemeData _iconThemeData() => IconThemeData(color: colorSchemeDark.baseWhite);

  ElevatedButtonThemeData elevatedButtonTheme() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        splashFactory: InkRipple.splashFactory,
        backgroundColor: colorSchemeDark.baseBlack,
        foregroundColor: colorSchemeDark.baseTransparentColor,
        textStyle: textThemeDark.headline6,
        padding: const EdgeInsets.only(bottom: 20, left: 25, right: 20, top: 25),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        minimumSize: const Size(144, 56),
      ),
    );
  }

  ColorScheme _appColorScheme() => const ColorScheme.dark().copyWith(
        brightness: Brightness.dark,
        primary: const Color(0xFFFFB4AB),
        onPrimary: const Color(0xFF690005),
        primaryContainer: const Color(0xFF93000B),
        onPrimaryContainer: const Color(0xFFFFDAD6),
        secondary: const Color(0xFFD8B9FF),
        onSecondary: const Color(0xFF401B6E),
        secondaryContainer: const Color(0xFF573486),
        onSecondaryContainer: const Color(0xFFEDDCFF),
        tertiary: const Color(0xFFD7BAFF),
        onTertiary: const Color(0xFF3F1C6E),
        tertiaryContainer: const Color(0xFF563587),
        onTertiaryContainer: const Color(0xFFEDDCFF),
        error: const Color(0xFFFFB4AB),
        errorContainer: const Color(0xFF93000A),
        onError: const Color(0xFF690005),
        onErrorContainer: const Color(0xFFFFDAD6),
        background: const Color(0xFF201A19),
        onBackground: const Color(0xFFEDE0DE),
        surface: const Color(0xFF201A19),
        onSurface: const Color(0xFFEDE0DE),
        surfaceVariant: const Color(0xFF534341),
        onSurfaceVariant: const Color(0xFFD8C2BF),
        outline: const Color(0xFFA08C8A),
        onInverseSurface: const Color(0xFF201A19),
        inverseSurface: const Color(0xFFEDE0DE),
        inversePrimary: const Color(0xFFBF0715),
        shadow: const Color(0xFF000000),
        surfaceTint: const Color(0xFFFFB4AB),
        outlineVariant: const Color(0xFF534341),
        scrim: const Color(0xFF000000),
      );

  TextTheme textTheme() {
    return ThemeData.light().textTheme.apply(fontFamily: ApplicationConstants.FONT_FAMILY).copyWith(
          labelLarge: textThemeDark.button,
          displayLarge: textThemeDark.headline1,
          displayMedium: textThemeDark.headline2,
          displaySmall: textThemeDark.headline3,
          headlineMedium: textThemeDark.headline4,
          headlineSmall: textThemeDark.headline5,
          titleLarge: textThemeDark.headline6.copyWith(color: Colors.black),
          titleSmall: textThemeDark.subtitle2.copyWith(color: Colors.white),
          titleMedium: textThemeDark.subtitle1.copyWith(color: Colors.white),
        );
  }
}
