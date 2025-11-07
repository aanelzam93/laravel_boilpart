import 'package:dio/dio.dart';
import '../../core/constants/app_constants.dart';
import '../../core/network/dio_client.dart';
import '../models/user_model.dart';

class UserService {
  final DioClient _dioClient;

  UserService(this._dioClient);

  /// Get all users with pagination
  Future<Map<String, dynamic>> getUsers({
    int limit = 20,
    int skip = 0,
  }) async {
    try {
      final response = await _dioClient.dio.get(
        AppConstants.users,
        queryParameters: {
          'limit': limit,
          'skip': skip,
        },
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to get users');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    }
  }

  /// Get user by ID
  Future<UserModel> getUserById(int id) async {
    try {
      final response = await _dioClient.dio.get(
        '${AppConstants.users}/$id',
      );

      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      } else {
        throw Exception('Failed to get user');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    }
  }

  /// Search users
  Future<Map<String, dynamic>> searchUsers(String query) async {
    try {
      final response = await _dioClient.dio.get(
        '${AppConstants.users}/search',
        queryParameters: {
          'q': query,
        },
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to search users');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    }
  }
}
