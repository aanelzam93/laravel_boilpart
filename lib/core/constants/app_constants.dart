import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {
  // API Configuration from .env
  static String get baseUrl => dotenv.get('API_BASE_URL', fallback: 'https://dummyjson.com');
  static String get apiVersion => '';
  static int get connectTimeout => int.tryParse(dotenv.get('API_TIMEOUT', fallback: '30000')) ?? 30000;
  static int get receiveTimeout => int.tryParse(dotenv.get('API_TIMEOUT', fallback: '30000')) ?? 30000;

  // API Endpoints
  static const String authLogin = '/auth/login';
  static const String authMe = '/auth/me';
  static const String users = '/users';
  static const String products = '/products';
  static const String posts = '/posts';
  static const String comments = '/comments';
  static const String todos = '/todos';
  static const String carts = '/carts';

  // Storage Keys
  static const String keyToken = 'token';
  static const String keyUserId = 'user_id';
  static const String keyUserData = 'user_data';
  static const String keyThemeMode = 'theme_mode';
  static const String keyLanguage = 'language';
  static const String keyIsLoggedIn = 'isLoggedIn';
  static const String keyUsername = 'username';

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // App Info from .env
  static String get appName => dotenv.get('APP_NAME', fallback: 'Flutter Boilerplate');
  static const String appVersion = '1.0.0';
  static String get appMode => dotenv.get('APP_MODE', fallback: 'development');

  // Test Credentials from .env
  static String get testUsername => dotenv.get('TEST_USERNAME', fallback: 'emilys');
  static String get testPassword => dotenv.get('TEST_PASSWORD', fallback: 'emilyspass');
}
