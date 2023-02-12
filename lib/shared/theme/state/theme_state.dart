import 'package:flutter/material.dart';

class ThemeState {
  const ThemeState({
    this.themeMode = ThemeMode.light,
  }); // Default theme = light theme

  final ThemeMode themeMode;

  ThemeState copyWith({ThemeMode? themeMode}) => ThemeState(
        themeMode: themeMode ?? this.themeMode,
      );
}
