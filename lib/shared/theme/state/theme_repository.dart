import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

abstract class ThemePersistence {
  Stream<CustomTheme> getTheme();
  Future<void> saveTheme(CustomTheme theme);
  void dispose();
}

enum CustomTheme { light, dark }

class ThemeRepository implements ThemePersistence {
  ThemeRepository({
    required Future<SharedPreferences> sharedPreferences,
  }) : _sharedPreferences = sharedPreferences {
    _init();
  }

  final Future<SharedPreferences> _sharedPreferences;

  static const _kThemePersistenceKey = '__theme_persistence_key__';

  final _controller = StreamController<CustomTheme>();

  Future<String?> _getValue(String key) async {
    try {
      return (await _sharedPreferences).getString(key);
    } catch (_) {
      return null;
    }
  }

  Future<void> _setValue(String key, String value) async =>
      (await _sharedPreferences).setString(key, value);

  Future<void> _init() async {
    final themeString = await _getValue(_kThemePersistenceKey);

    if (themeString == null) _controller.add(CustomTheme.light);

    if (themeString == CustomTheme.light.name) {
      _controller.add(CustomTheme.light);
    } else {
      _controller.add(CustomTheme.dark);
    }
  }

  @override
  Stream<CustomTheme> getTheme() async* {
    yield* _controller.stream;
  }

  @override
  Future<void> saveTheme(CustomTheme theme) async {
    _controller.add(theme);
    await _setValue(_kThemePersistenceKey, theme.name);
  }

  @override
  void dispose() => _controller.close();
}
