import 'package:deprem_destek/core/res/colors.dart';
import 'package:deprem_destek/core/res/utils.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData theme({bool isDark = false}) => ThemeData(
        primaryColor: AppColors.primarySwatch,
        colorScheme: ColorScheme.fromSwatch(
          brightness: isDark ? Brightness.dark : Brightness.light,
          primarySwatch: AppColors.primarySwatch,
        ),
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
            borderRadius: BorderRadius.circular(AppDimens.xs),
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
            borderRadius: BorderRadius.circular(AppDimens.s),
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
    padding: EdgeInsets.only(
      top: AppDimens.m,
      bottom: AppDimens.m,
      left: AppDimens.m,
      right: AppDimens.m,
    ),
  );

  static TextButtonThemeData textButtonTheme = TextButtonThemeData(
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.only(
        top: AppDimens.m,
        bottom: AppDimens.m,
        left: AppDimens.m,
        right: AppDimens.m,
      ),
    ),
  );
  static ElevatedButtonThemeData elevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      padding: const EdgeInsets.only(
        top: AppDimens.m,
        bottom: AppDimens.m,
        left: AppDimens.m,
        right: AppDimens.m,
      ),
    ),
  );

  static OutlinedButtonThemeData outlinedButtonThemeData =
      OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      side: BorderSide(color: AppColors.primarySwatch),
      padding: const EdgeInsets.only(
        top: AppDimens.m,
        bottom: AppDimens.m,
        left: AppDimens.m,
        right: AppDimens.m,
      ),
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
