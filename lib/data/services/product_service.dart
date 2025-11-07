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
      final queryParameters = {
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
        throw Exception('Failed to get products');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
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
        throw Exception('Failed to get product');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
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
        throw Exception('Failed to search products');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    }
  }

  /// Get product categories
  Future<List<String>> getCategories() async {
    try {
      final response = await _dioClient.dio.get(
        '${AppConstants.products}/categories',
      );

      if (response.statusCode == 200) {
        return List<String>.from(response.data);
      } else {
        throw Exception('Failed to get categories');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
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
        throw Exception('Failed to get products by category');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    }
  }

  /// Get category list (slug format)
  Future<List<String>> getCategoryList() async {
    try {
      final response = await _dioClient.dio.get(
        '${AppConstants.products}/category-list',
      );

      if (response.statusCode == 200) {
        return List<String>.from(response.data);
      } else {
        throw Exception('Failed to get category list');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    }
  }
}
