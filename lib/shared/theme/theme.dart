import 'package:afet_destek/shared/theme/color_extensions.dart';
import 'package:afet_destek/shared/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData light(BuildContext context) {
    const colorExtensions = AppColorsExtension();
    return buildThemeData(ThemeData.light(), colorExtensions);
  }

  static ThemeData dark(BuildContext context) {
    final colorExtensions = AppColorsExtension.dark();
    return buildThemeData(ThemeData.dark(), colorExtensions);
  }

  static ThemeData buildThemeData(
    ThemeData base,
    AppColorsExtension colorExtensions,
  ) {
    return base.copyWith(
      primaryColor: colorExtensions.mainRed,
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: colorExtensions.mainRed.toMaterial(),
      ),
      scaffoldBackgroundColor: colorExtensions.secondaryBackground,
      sliderTheme: const SliderThemeData(
        showValueIndicator: ShowValueIndicator.always,
        valueIndicatorTextStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      indicatorColor: colorExtensions.mainRed,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: colorExtensions.white,
        foregroundColor: colorExtensions.black,
        elevation: 0,
      ),
      buttonTheme: buttonTheme,
      cardTheme: CardTheme(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      elevatedButtonTheme: elevatedButtonTheme,
      chipTheme: chipThemeData(colorExtensions),
      textTheme: GoogleFonts.interTextTheme().copyWith(
        headlineSmall: TextStyle(
          color: colorExtensions.titles,
          fontWeight: FontWeight.w600,
        ),
        titleSmall: TextStyle(
          color: colorExtensions.tags,
          fontWeight: FontWeight.w400,
        ),
      ),
      textButtonTheme: textButtonTheme,
      outlinedButtonTheme: outlinedButtonThemeData(colorExtensions),
      inputDecorationTheme: InputDecorationTheme(
        errorMaxLines: 2,
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      bottomNavigationBarTheme: bottomNavigationBarTheme(colorExtensions),
      extensions: [
        colorExtensions,
      ],
    );
  }

  static BottomNavigationBarThemeData bottomNavigationBarTheme(
    AppColorsExtension colorsExtension,
  ) =>
      BottomNavigationBarThemeData(
        elevation: 4,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: colorsExtension.mainRed,
        unselectedItemColor: colorsExtension.disabledButton,
        showSelectedLabels: true,
        showUnselectedLabels: true,
      );

  static ButtonThemeData buttonTheme = const ButtonThemeData(
    padding: EdgeInsets.all(16),
  );

  static TextButtonThemeData textButtonTheme = TextButtonThemeData(
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.all(16),
    ),
  );
  static ElevatedButtonThemeData elevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      padding: const EdgeInsets.all(16),
    ),
  );

  static OutlinedButtonThemeData outlinedButtonThemeData(
    AppColorsExtension colorsExtension,
  ) =>
      OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: colorsExtension.mainRed),
          padding: const EdgeInsets.all(16),
        ),
      );

  static ChipThemeData chipThemeData(
    AppColorsExtension colorsExtension,
  ) =>
      ChipThemeData(
        selectedColor: const Color(0xff1F2937),
        backgroundColor: colorsExtension.white,
        secondaryLabelStyle: TextStyle(color: colorsExtension.white),
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(9),
          side: BorderSide(color: colorsExtension.stroke),
        ),
      );
}
