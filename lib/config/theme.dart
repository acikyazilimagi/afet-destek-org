import 'package:deprem_destek/config/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

mixin CustomTheme {
  //? THEME
  static const bool _isDarkEnabled = false;

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Palette.backgroundColor,
    backgroundColor: Palette.backgroundColor,
    primaryColor: Palette.primaryColor,
    iconTheme: IconThemeData(
      color: Palette.primaryColor,
    ),
    appBarTheme: AppBarTheme(
      color: Palette.backgroundColor,
      elevation: 0,
      shadowColor: Colors.grey[50]?.withAlpha(100),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
      ),
      centerTitle: true,
      iconTheme: IconThemeData(
        color: Palette.primaryColor,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Palette.primaryColor,
      unselectedItemColor: Colors.grey[800],
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(Palette.primaryColor),
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      elevation: 3.0,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
    ),
  );

  static ThemeData darkTheme = _isDarkEnabled ? ThemeData.dark() : lightTheme;

  //? Fonts

  static TextStyle baseStyle(
    TextStyle style, {
    FontStyle fontStyle = FontStyle.normal,
    FontWeight fontWeight = FontWeight.normal,
    TextDecoration? decoration,
    Color? color,
  }) {
    return style.copyWith(
      fontFamily: "NunitoSans",
      color: color ?? Palette.primaryTextColor,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      decoration: decoration,
      letterSpacing: .6,
    );
  }

  static TextStyle headline1(
    BuildContext context, {
    FontWeight fontWeight = FontWeight.normal,
    FontStyle fontStyle = FontStyle.normal,
    TextDecoration? decoration,
    Color? color,
  }) {
    return baseStyle(
      Theme.of(context).textTheme.headline1!,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      color: color ?? Palette.primaryTextColor,
      decoration: decoration,
    );
  }

  static TextStyle headline2(
    BuildContext context, {
    FontWeight fontWeight = FontWeight.normal,
    FontStyle fontStyle = FontStyle.normal,
    TextDecoration? decoration,
    Color? color,
  }) {
    return baseStyle(
      Theme.of(context).textTheme.headline2!,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      color: color ?? Palette.primaryTextColor,
      decoration: decoration,
    );
  }

  static TextStyle headline3(
    BuildContext context, {
    FontWeight fontWeight = FontWeight.normal,
    FontStyle fontStyle = FontStyle.normal,
    TextDecoration? decoration,
    Color? color,
  }) {
    return baseStyle(
      Theme.of(context).textTheme.headline3!,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      color: color ?? Palette.primaryTextColor,
      decoration: decoration,
    );
  }

  static TextStyle headline4(
    BuildContext context, {
    FontWeight fontWeight = FontWeight.normal,
    FontStyle fontStyle = FontStyle.normal,
    TextDecoration? decoration,
    Color? color,
  }) {
    return baseStyle(
      Theme.of(context).textTheme.headline4!,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      color: color ?? Palette.primaryTextColor,
      decoration: decoration,
    );
  }

  static TextStyle headline5(
    BuildContext context, {
    FontWeight fontWeight = FontWeight.normal,
    FontStyle fontStyle = FontStyle.normal,
    TextDecoration? decoration,
    Color? color,
  }) {
    return baseStyle(
      Theme.of(context).textTheme.headline5!,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      color: color ?? Palette.primaryTextColor,
      decoration: decoration,
    );
  }

  static TextStyle headline6(
    BuildContext context, {
    FontWeight fontWeight = FontWeight.normal,
    FontStyle fontStyle = FontStyle.normal,
    TextDecoration? decoration,
    Color? color,
  }) {
    return baseStyle(
      Theme.of(context).textTheme.headline6!,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      color: color ?? Palette.primaryTextColor,
      decoration: decoration,
    );
  }

  static TextStyle subtitle(
    BuildContext context, {
    FontWeight fontWeight = FontWeight.normal,
    FontStyle fontStyle = FontStyle.normal,
    TextDecoration? decoration,
    Color? color,
  }) {
    return baseStyle(
      Theme.of(context).textTheme.subtitle1!,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      color: color ?? Palette.primaryTextColor,
      decoration: decoration,
    );
  }

  static TextStyle body(
    BuildContext context, {
    FontWeight fontWeight = FontWeight.normal,
    FontStyle fontStyle = FontStyle.normal,
    TextDecoration? decoration,
    Color? color,
  }) {
    return baseStyle(
      Theme.of(context).textTheme.bodyText1!,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      color: color ?? Palette.primaryTextColor,
      decoration: decoration,
    );
  }

  static TextStyle caption(
    BuildContext context, {
    FontWeight fontWeight = FontWeight.normal,
    FontStyle fontStyle = FontStyle.normal,
    TextDecoration? decoration,
    Color? color,
  }) {
    return baseStyle(
      Theme.of(context).textTheme.caption!,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      color: color ?? Palette.primaryTextColor,
      decoration: decoration,
    );
  }

  static TextStyle button(
    BuildContext context, {
    FontWeight fontWeight = FontWeight.normal,
    FontStyle fontStyle = FontStyle.normal,
    TextDecoration? decoration,
    Color? color,
  }) {
    return baseStyle(
      Theme.of(context).textTheme.button!,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      color: color ?? Palette.primaryTextColor,
      decoration: decoration,
    );
  }

  static TextStyle overline(
    BuildContext context, {
    FontWeight fontWeight = FontWeight.normal,
    FontStyle fontStyle = FontStyle.normal,
    TextDecoration? decoration,
    Color? color,
  }) {
    return baseStyle(
      Theme.of(context).textTheme.overline!,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      color: color ?? Palette.primaryTextColor,
      decoration: decoration,
    );
  }
}
