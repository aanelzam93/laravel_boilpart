import 'package:dio/dio.dart';
import '../../core/constants/app_constants.dart';
import '../../core/network/dio_client.dart';
import '../models/product_model.dart';

class ProductService {
  final DioClient _dioClient;

  ProductService(this._dioClient);

  /// Get all products with pagination
  Future<Map<String, dynamic>> getProducts({
    int limit = 20,
    int skip = 0,
  }) async {
    try {
      final response = await _dioClient.dio.get(
        AppConstants.products,
        queryParameters: {
          'limit': limit,
          'skip': skip,
        },
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

  /// Search products
  Future<Map<String, dynamic>> searchProducts(String query) async {
    try {
      final response = await _dioClient.dio.get(
        '${AppConstants.products}/search',
        queryParameters: {
          'q': query,
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

  /// Get products by category
  Future<Map<String, dynamic>> getProductsByCategory(String category) async {
    try {
      final response = await _dioClient.dio.get(
        '${AppConstants.products}/category/$category',
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
}
