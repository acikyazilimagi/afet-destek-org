part of 'theme_cubit.dart';

@immutable
abstract class ThemeState {
  const ThemeState({required this.themeMode});

  final ThemeMode themeMode;
}

class ThemeInitial extends ThemeState {
  const ThemeInitial({required super.themeMode});
}
