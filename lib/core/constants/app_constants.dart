class AppConstants {
  // API - DummyJSON
  static const String baseUrl = 'https://dummyjson.com';
  static const String apiVersion = '';
  static const int connectTimeout = 30000;
  static const int receiveTimeout = 30000;

  // API Endpoints
  static const String authLogin = '/auth/login';
  static const String authMe = '/auth/me';
  static const String users = '/users';
  static const String products = '/products';
  static const String posts = '/posts';
  static const String comments = '/comments';
  static const String todos = '/todos';
  static const String carts = '/carts';

  // Alternative APIs
  static const String reqResBaseUrl = 'https://reqres.in/api';
  static const String jsonPlaceholderUrl = 'https://jsonplaceholder.typicode.com';

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

  // App Info
  static const String appName = 'Flutter Boilerplate';
  static const String appVersion = '1.0.0';

  // Test Credentials - DummyJSON
  static const String testUsername = 'emilys';
  static const String testPassword = 'emilyspass';
}
