import 'package:dio/dio.dart';
import '../../core/constants/app_constants.dart';
import '../../core/network/dio_client.dart';
import '../models/post_model.dart';

class PostService {
  final DioClient _dioClient;

  PostService(this._dioClient);

  /// Get all posts with pagination
  Future<Map<String, dynamic>> getPosts({
    int limit = 20,
    int skip = 0,
  }) async {
    try {
      final response = await _dioClient.dio.get(
        AppConstants.posts,
        queryParameters: {
          'limit': limit,
          'skip': skip,
        },
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to get posts');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    }
  }

  /// Get post by ID
  Future<PostModel> getPostById(int id) async {
    try {
      final response = await _dioClient.dio.get(
        '${AppConstants.posts}/$id',
      );

      if (response.statusCode == 200) {
        return PostModel.fromJson(response.data);
      } else {
        throw Exception('Failed to get post');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    }
  }

  /// Search posts
  Future<Map<String, dynamic>> searchPosts(String query) async {
    try {
      final response = await _dioClient.dio.get(
        '${AppConstants.posts}/search',
        queryParameters: {
          'q': query,
        },
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to search posts');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    }
  }

  /// Get posts by user ID
  Future<Map<String, dynamic>> getPostsByUserId(int userId) async {
    try {
      final response = await _dioClient.dio.get(
        '${AppConstants.posts}/user/$userId',
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to get posts by user');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    }
  }
}
