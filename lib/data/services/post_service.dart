import 'package:dio/dio.dart';
import '../../core/constants/app_constants.dart';
import '../../core/network/dio_client.dart';
import '../models/post_model.dart';

class PostService {
  final DioClient _dioClient;

  PostService(this._dioClient);

  /// Get all posts with pagination and sorting
  Future<Map<String, dynamic>> getPosts({
    int limit = 20,
    int skip = 0,
    String? sortBy,
    String? order,
  }) async {
    try {
      final queryParameters = <String, dynamic>{
        'limit': limit,
        'skip': skip,
      };

      if (sortBy != null && sortBy.isNotEmpty) {
        queryParameters['sortBy'] = sortBy;
      }
      if (order != null && order.isNotEmpty) {
        queryParameters['order'] = order;
      }

      final response = await _dioClient.dio.get(
        AppConstants.posts,
        queryParameters: queryParameters,
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to get posts: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    } catch (e) {
      throw Exception('Unexpected error: ${e.toString()}');
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
        throw Exception('Failed to get post: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    } catch (e) {
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  /// Search posts with pagination
  Future<Map<String, dynamic>> searchPosts(
    String query, {
    int limit = 20,
    int skip = 0,
  }) async {
    try {
      final response = await _dioClient.dio.get(
        '${AppConstants.posts}/search',
        queryParameters: {
          'q': query,
          'limit': limit,
          'skip': skip,
        },
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to search posts: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    } catch (e) {
      throw Exception('Unexpected error: ${e.toString()}');
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
        throw Exception('Failed to get posts by user: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    } catch (e) {
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  /// Get all post tags
  Future<List<String>> getTags() async {
    try {
      final response = await _dioClient.dio.get(
        '${AppConstants.posts}/tags',
      );

      if (response.statusCode == 200) {
        if (response.data is List) {
          return (response.data as List).map((item) {
            if (item is String) return item;
            if (item is Map) return item['slug']?.toString() ?? item['name']?.toString() ?? item.toString();
            return item.toString();
          }).toList();
        }
        return [];
      } else {
        throw Exception('Failed to get tags: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    } catch (e) {
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  /// Get posts by tag
  Future<Map<String, dynamic>> getPostsByTag(
    String tag, {
    int limit = 20,
    int skip = 0,
  }) async {
    try {
      final response = await _dioClient.dio.get(
        '${AppConstants.posts}/tag/$tag',
        queryParameters: {
          'limit': limit,
          'skip': skip,
        },
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to get posts by tag: ${response.statusMessage}');
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
