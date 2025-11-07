import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  final SharedPreferences _prefs;

  LocalStorage(this._prefs);

  // Generic methods
  Future<bool> setString(String key, String value) async {
    return await _prefs.setString(key, value);
  }

  String? getString(String key) {
    return _prefs.getString(key);
  }

  Future<bool> setBool(String key, bool value) async {
    return await _prefs.setBool(key, value);
  }

  bool? getBool(String key) {
    return _prefs.getBool(key);
  }

  Future<bool> setInt(String key, int value) async {
    return await _prefs.setInt(key, value);
  }

  int? getInt(String key) {
    return _prefs.getInt(key);
  }

  Future<bool> remove(String key) async {
    return await _prefs.remove(key);
  }

  Future<bool> clear() async {
    return await _prefs.clear();
  }

  // Specific methods
  Future<bool> saveToken(String token) async {
    return await setString('token', token);
  }

  String? getToken() {
    return getString('token');
  }

  Future<bool> removeToken() async {
    return await remove('token');
  }

  Future<bool> saveLanguage(String languageCode) async {
    return await setString('language', languageCode);
  }

  String? getLanguage() {
    return getString('language');
  }
}
