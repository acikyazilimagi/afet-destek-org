import 'package:deprem_destek/pages/shared/theme/theme/app_theme_light.dart';
import 'package:flutter/material.dart';

class DepremDestekApp extends StatefulWidget {
  const DepremDestekApp({super.key});

  @override
  State<DepremDestekApp> createState() => _DepremDestekAppState();
}

class _DepremDestekAppState extends State<DepremDestekApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppThemeLight.instance.theme,
    );
  }
}
