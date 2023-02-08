import 'package:deprem_destek/shared/theme/colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData theme(BuildContext context) {
    return Theme.of(context).copyWith(
      primaryColor: AppColors.primarySwatch,
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: AppColors.primarySwatch,
      ),
      sliderTheme: const SliderThemeData(
        showValueIndicator: ShowValueIndicator.always,
        valueIndicatorTextStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
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
      chipTheme: chipThemeData,
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
  }

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

  static ChipThemeData chipThemeData = ChipThemeData(
    selectedColor: const Color(0xff1F2937),
    backgroundColor: Colors.white,
    secondaryLabelStyle: const TextStyle(color: AppColors.white),
    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(9),
      side: const BorderSide(color: Color(0xffD0D5DD)),
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
