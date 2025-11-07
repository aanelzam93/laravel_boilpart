import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../storage/local_storage.dart';

class LanguageCubit extends Cubit<Locale> {
  final LocalStorage _localStorage;

  LanguageCubit(this._localStorage) : super(const Locale('id')) {
    _loadSavedLanguage();
  }

  void _loadSavedLanguage() {
    final savedLanguage = _localStorage.getLanguage();
    if (savedLanguage != null) {
      emit(Locale(savedLanguage));
    }
  }

  Future<void> changeLanguage(String languageCode) async {
    await _localStorage.saveLanguage(languageCode);
    emit(Locale(languageCode));
  }

  void toEnglish() => changeLanguage('en');
  void toIndonesian() => changeLanguage('id');
}
