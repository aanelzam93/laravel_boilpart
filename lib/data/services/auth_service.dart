import 'package:dio/dio.dart';
import '../../core/constants/app_constants.dart';
import '../../core/network/dio_client.dart';
import '../models/user_model.dart';

class AuthService {
  final DioClient _dioClient;

  AuthService(this._dioClient);

  /// Login with username and password
  /// Returns token and user data
  Future<Map<String, dynamic>> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await _dioClient.dio.post(
        AppConstants.authLogin,
        data: {
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Login failed: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? 'Login failed. Please check your credentials.');
      } else {
        throw Exception(_handleDioError(e));
      }
    } catch (e) {
      throw Exception('Unexpected error during login: ${e.toString()}');
    }
  }

  /// Get current authenticated user
  Future<UserModel> getCurrentUser(String token) async {
    try {
      // Set token to dio client
      _dioClient.setToken(token);

      final response = await _dioClient.dio.get(AppConstants.authMe);

      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      } else {
        throw Exception('Failed to get user data: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? 'Failed to get user data');
      } else {
        throw Exception(_handleDioError(e));
      }
    } catch (e) {
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  /// Refresh token (if needed in future)
  Future<String> refreshToken(String refreshToken) async {
    try {
      final response = await _dioClient.dio.post(
        '/auth/refresh',
        data: {
          'refreshToken': refreshToken,
        },
      );

      if (response.statusCode == 200) {
        return response.data['token'];
      } else {
        throw Exception('Token refresh failed: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    } catch (e) {
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  String _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout. Please check your internet connection.';
      case DioExceptionType.sendTimeout:
        return 'Request timeout. Please try again.';
      case DioExceptionType.receiveTimeout:
        return 'Server response timeout. Please try again.';
      case DioExceptionType.badResponse:
        return 'Server error: ${e.response?.statusCode}. Please try again later.';
      case DioExceptionType.cancel:
        return 'Request was cancelled.';
      case DioExceptionType.connectionError:
        return 'No internet connection. Please check your network and try again.';
      default:
        return 'Network error: ${e.message ?? "Unknown error"}';
    }
  }
}
