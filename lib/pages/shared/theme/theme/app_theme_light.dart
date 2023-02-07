// ignore_for_file: lines_longer_than_80_chars

import 'package:deprem_destek/pages/shared/theme/theme/app_theme.dart';
import 'package:deprem_destek/pages/shared/theme/theme/light/light_theme_interface.dart';
import 'package:deprem_destek/pages/shared/theme/yardim_agi_theme.dart';
import 'package:flutter/material.dart';

class AppThemeLight extends AppTheme with ILightTheme {
  AppThemeLight._init();
  static AppThemeLight? _instance;
  static AppThemeLight get instance {
    _instance ??= AppThemeLight._init();
    return _instance!;
  }

  @override
  ThemeData get theme => ThemeData(
        scaffoldBackgroundColor: colorSchemeLight.baseWhite,
        fontFamily: ApplicationConstants.FONT_FAMILY,
        textTheme: textTheme(),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: colorSchemeLight.baseFormFillColor,
          hintStyle: textThemeLight.headline6.copyWith(color: colorSchemeLight.baseBlack),
          labelStyle: textThemeLight.headline6.copyWith(color: colorSchemeLight.baseBlack, fontWeight: FontWeight.w400),
          helperStyle: textThemeLight.subtitle2.copyWith(color: colorSchemeLight.baseDarkGrey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        chipTheme: chipThemeData(),
        iconTheme: _iconThemeData(),
        radioTheme: RadioThemeData(
          fillColor: MaterialStatePropertyAll(
            colorSchemeLight.baseBlack,
          ),
        ),
        checkboxTheme: CheckboxThemeData(
          side: BorderSide(color: colorSchemeLight.baseDarkGrey, width: 2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
          fillColor: MaterialStatePropertyAll(
            colorSchemeLight.baseBlack,
          ),
          checkColor: MaterialStatePropertyAll(colorSchemeLight.baseGrey),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: colorSchemeLight.baseBlack,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        colorScheme: _appColorScheme().copyWith(),
        elevatedButtonTheme: elevatedButton(),
      );

  ChipThemeData chipThemeData() {
    return ChipThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      //8px, 15px, 8px, 15px

      backgroundColor: colorSchemeLight.baseBlack,
    );
  }

  IconThemeData _iconThemeData() {
    return IconThemeData(color: colorSchemeLight.baseWhite);
  }

  ElevatedButtonThemeData elevatedButton() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        animationDuration: const Duration(milliseconds: 1000),
        splashFactory: InkRipple.splashFactory,
        backgroundColor: colorSchemeLight.baseBlack,
        foregroundColor: colorSchemeLight.baseWhite,
        padding: const EdgeInsets.only(bottom: 20, left: 25, right: 20, top: 25),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        minimumSize: const Size(144, 56),
      ),
    );
  }

  ColorScheme _appColorScheme() => const ColorScheme.dark().copyWith(
        brightness: Brightness.light,
        primary: const Color(0xFFBF0715),
        onPrimary: const Color(0xFFFFFFFF),
        primaryContainer: const Color(0xFFFFDAD6),
        onPrimaryContainer: const Color(0xFF410002),
        secondary: const Color(0xFF704D9F),
        onSecondary: const Color(0xFFFFFFFF),
        secondaryContainer: const Color(0xFFEDDCFF),
        onSecondaryContainer: const Color(0xFF290055),
        tertiary: const Color(0xFF6F4DA0),
        onTertiary: const Color(0xFFFFFFFF),
        tertiaryContainer: const Color(0xFFEDDCFF),
        onTertiaryContainer: const Color(0xFF280056),
        error: const Color(0xFFBA1A1A),
        errorContainer: const Color(0xFFFFDAD6),
        onError: const Color(0xFFFFFFFF),
        onErrorContainer: const Color(0xFF410002),
        background: const Color(0xFFFFFBFF),
        onBackground: const Color(0xFF201A19),
        surface: const Color(0xFFFFFBFF),
        onSurface: const Color(0xFF201A19),
        surfaceVariant: const Color(0xFFF5DDDA),
        onSurfaceVariant: const Color(0xFF534341),
        outline: const Color(0xFF857371),
        onInverseSurface: const Color(0xFFFBEEEC),
        inverseSurface: const Color(0xFF362F2E),
        inversePrimary: const Color(0xFFFFB4AB),
        shadow: const Color(0xFF000000),
        surfaceTint: const Color(0xFFBF0715),
        outlineVariant: const Color(0xFFD8C2BF),
        scrim: const Color(0xFF000000),
      );

  TextTheme textTheme() {
    return ThemeData.light().textTheme.apply(fontFamily: ApplicationConstants.FONT_FAMILY).copyWith(
          labelLarge: textThemeLight.button.copyWith(color: colorSchemeLight.baseBlack),
          displayLarge: textThemeLight.headline1.copyWith(color: colorSchemeLight.baseBlack),
          displayMedium: textThemeLight.headline2.copyWith(color: colorSchemeLight.baseBlack),
          displaySmall: textThemeLight.headline3.copyWith(color: colorSchemeLight.baseBlack),
          headlineMedium: textThemeLight.headline4.copyWith(color: colorSchemeLight.baseBlack),
          headlineSmall: textThemeLight.headline5.copyWith(color: colorSchemeLight.baseBlack),
          titleLarge: textThemeLight.headline6.copyWith(color: colorSchemeLight.baseBlack),
          titleMedium: textThemeLight.subtitle1.copyWith(color: colorSchemeLight.baseBlack),
          titleSmall: textThemeLight.subtitle2.copyWith(color: colorSchemeLight.baseDarkGrey),
        );
  }
}
