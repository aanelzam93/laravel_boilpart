import 'package:dio/dio.dart';
import '../../core/constants/app_constants.dart';
import '../../core/network/dio_client.dart';
import '../models/product_model.dart';

class ProductService {
  final DioClient _dioClient;

  ProductService(this._dioClient);

  /// Get all products with pagination and sorting
  /// sortBy: 'title', 'price', 'rating', 'stock', 'brand', 'category'
  /// order: 'asc', 'desc'
  Future<Map<String, dynamic>> getProducts({
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
        AppConstants.products,
        queryParameters: queryParameters,
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to get products: ${response.statusMessage}');
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

  /// Get product by ID
  Future<ProductModel> getProductById(int id) async {
    try {
      final response = await _dioClient.dio.get(
        '${AppConstants.products}/$id',
      );

      if (response.statusCode == 200) {
        return ProductModel.fromJson(response.data);
      } else {
        throw Exception('Failed to get product: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    } catch (e) {
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  /// Search products with pagination
  Future<Map<String, dynamic>> searchProducts(
    String query, {
    int limit = 20,
    int skip = 0,
  }) async {
    try {
      final response = await _dioClient.dio.get(
        '${AppConstants.products}/search',
        queryParameters: {
          'q': query,
          'limit': limit,
          'skip': skip,
        },
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to search products: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    } catch (e) {
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  /// Get product categories
  Future<List<String>> getCategories() async {
    try {
      final response = await _dioClient.dio.get(
        '${AppConstants.products}/categories',
      );

      if (response.statusCode == 200) {
        // Handle both string arrays and object arrays
        if (response.data is List) {
          return (response.data as List).map((item) {
            if (item is String) return item;
            if (item is Map) return item['slug']?.toString() ?? item['name']?.toString() ?? item.toString();
            return item.toString();
          }).toList();
        }
        return [];
      } else {
        throw Exception('Failed to get categories: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    } catch (e) {
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  /// Get products by category with pagination
  Future<Map<String, dynamic>> getProductsByCategory(
    String category, {
    int limit = 20,
    int skip = 0,
  }) async {
    try {
      final response = await _dioClient.dio.get(
        '${AppConstants.products}/category/$category',
        queryParameters: {
          'limit': limit,
          'skip': skip,
        },
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to get products by category: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    } catch (e) {
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }

  /// Get category list (slug format)
  Future<List<String>> getCategoryList() async {
    try {
      final response = await _dioClient.dio.get(
        '${AppConstants.products}/category-list',
      );

      if (response.statusCode == 200) {
        // Handle both string arrays and object arrays
        if (response.data is List) {
          return (response.data as List).map((item) {
            if (item is String) return item;
            if (item is Map) return item['slug']?.toString() ?? item['name']?.toString() ?? item.toString();
            return item.toString();
          }).toList();
        }
        return [];
      } else {
        throw Exception('Failed to get category list: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    } catch (e) {
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }
}
