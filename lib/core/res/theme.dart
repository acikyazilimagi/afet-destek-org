import 'package:deprem_destek/core/res/colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData theme({bool isDark = false}) => ThemeData(
        primaryColor: AppColors.primarySwatch,
        colorScheme: ColorScheme.fromSwatch(
          brightness: isDark ? Brightness.dark : Brightness.light,
          primarySwatch: AppColors.primarySwatch,
        ),
        sliderTheme: const SliderThemeData(
            showValueIndicator: ShowValueIndicator.always,
            valueIndicatorTextStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            )),
        toggleableActiveColor: AppColors.primarySwatch,
        indicatorColor: AppColors.primarySwatch,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: AppColors.white,
          foregroundColor: AppColors.black,
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
        textTheme: const TextTheme(
          headlineSmall: TextStyle(
            color: AppColors.textColor,
            fontWeight: FontWeight.w600,
          ),
          titleSmall: TextStyle(
            color: AppColors.descriptionColor,
            fontWeight: FontWeight.w400,
          ),
        ),
        textButtonTheme: textButtonTheme,
        outlinedButtonTheme: outlinedButtonThemeData,
        inputDecorationTheme: InputDecorationTheme(
          errorMaxLines: 2,
          isDense: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        bottomNavigationBarTheme: bottomNavigationBarTheme,
      );

  static BottomNavigationBarThemeData bottomNavigationBarTheme =
      BottomNavigationBarThemeData(
    elevation: 4,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: AppColors.primarySwatch,
    unselectedItemColor: AppColors.darkGrey,
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

  static OutlinedButtonThemeData outlinedButtonThemeData =
      OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      side: BorderSide(color: AppColors.primarySwatch),
      padding: const EdgeInsets.all(16),
    ),
  );

  static ButtonStyle redButton() {
    return ButtonStyle(
      backgroundColor: MaterialStatePropertyAll(
        AppColors.primarySwatch.shade500,
      ),
    );
  }
}
