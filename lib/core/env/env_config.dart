import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  static String get apiBaseUrl => dotenv.env['API_BASE_URL'] ?? '';
  static String get appMode => dotenv.env['APP_MODE'] ?? 'development';
  static String get appName => dotenv.env['APP_NAME'] ?? 'BoilPart Flutter';
  
  static bool get isDevelopment => appMode == 'development';
  static bool get isProduction => appMode == 'production';
}
