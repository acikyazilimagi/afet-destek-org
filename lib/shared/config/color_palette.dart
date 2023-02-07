import 'package:flutter/material.dart';

class ColorPalette {
  static Color primaryColor = const Color(0xFFDC2626);
  static Color successColor = const Color(0xFF25D366);
  static Color backgroundColor = Colors.grey.shade50;

  static const MaterialColor grayColor = MaterialColor(
    _grayValue,
    <int, Color>{
      50: Color(0xFFF7F9FA),
      100: Color(0xFFEFF2F5),
      200: Color(0xFFDFE5EB),
      300: Color(0xFFCED8E1),
      400: Color(0xFFBECBD7),
      500: Color(_grayValue),
      600: Color(0xFF8B98A4),
      700: Color(0xFF68727B),
      800: Color(0xFF464C52),
      900: Color(0xFF232629),
    },
  );
  static const int _grayValue = 0xFFAEBECD;

  static Color primaryTextColor = Colors.black;
  static Color hintTextColor = grayColor.shade600;
  static Color greyTextColor = Colors.grey;
}
