import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../storage/local_storage.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final LocalStorage _localStorage;

  ThemeCubit(this._localStorage) : super(ThemeMode.light) {
    _loadSavedTheme();
  }

  void _loadSavedTheme() {
    final savedTheme = _localStorage.getString('theme_mode');
    if (savedTheme != null) {
      if (savedTheme == 'dark') {
        emit(ThemeMode.dark);
      } else if (savedTheme == 'light') {
        emit(ThemeMode.light);
      } else {
        emit(ThemeMode.system);
      }
    } else {
      // Default to light mode
      emit(ThemeMode.light);
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    await _localStorage.setString('theme_mode', mode.toString().split('.').last);
    emit(mode);
  }

  void setLightMode() => setThemeMode(ThemeMode.light);
  void setDarkMode() => setThemeMode(ThemeMode.dark);
  void setSystemMode() => setThemeMode(ThemeMode.system);
}
