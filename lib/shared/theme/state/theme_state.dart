import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

@freezed
class ThemeState {
  const ThemeState({
    this.themeMode = ThemeMode.light,
  }); // Default theme = light theme
  final ThemeMode themeMode;

  ThemeState copyWith({ThemeMode? themeMode}) {
    return ThemeState(
      themeMode: themeMode ?? this.themeMode,
    );
  }
}
