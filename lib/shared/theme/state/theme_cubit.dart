import 'dart:async';

import 'package:afet_destek/shared/theme/state/theme_repository.dart';
import 'package:afet_destek/shared/theme/state/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit({
    required ThemePersistence themeRepository,
  })  : _themeRepository = themeRepository,
        super(const ThemeState());

  final ThemePersistence _themeRepository;
  late StreamSubscription<CustomTheme> _themeSubscription;
  static late bool _isDarkTheme;

  void getCurrentTheme() {
    _themeSubscription = _themeRepository.getTheme().listen(
      (customTheme) {
        if (customTheme.name == CustomTheme.light.name) {
          _isDarkTheme = false;
          emit(state.copyWith(themeMode: ThemeMode.light));
        } else {
          _isDarkTheme = true;
          emit(state.copyWith(themeMode: ThemeMode.dark));
        }
      },
    );
  }

  void switchTheme() {
    if (_isDarkTheme) {
      _themeRepository.saveTheme(CustomTheme.light);
    } else {
      _themeRepository.saveTheme(CustomTheme.dark);
    }
  }

  @override
  Future<void> close() {
    _themeSubscription.cancel();
    _themeRepository.dispose();
    return super.close();
  }
}
