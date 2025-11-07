import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/product_model.dart';
import '../../data/services/product_service.dart';

// States
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<ProductModel> products;
  final List<String> categories;
  final int total;
  final int skip;
  final int limit;
  final String? selectedCategory;
  final String? sortBy;
  final String? order;
  final String? searchQuery;
  final bool hasMore;

  HomeLoaded({
    required this.products,
    required this.categories,
    required this.total,
    this.skip = 0,
    this.limit = 20,
    this.selectedCategory,
    this.sortBy,
    this.order,
    this.searchQuery,
    this.hasMore = true,
  });

  HomeLoaded copyWith({
    List<ProductModel>? products,
    List<String>? categories,
    int? total,
    int? skip,
    int? limit,
    String? selectedCategory,
    String? sortBy,
    String? order,
    String? searchQuery,
    bool? hasMore,
  }) {
    return HomeLoaded(
      products: products ?? this.products,
      categories: categories ?? this.categories,
      total: total ?? this.total,
      skip: skip ?? this.skip,
      limit: limit ?? this.limit,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      sortBy: sortBy ?? this.sortBy,
      order: order ?? this.order,
      searchQuery: searchQuery ?? this.searchQuery,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}

class HomeLoadingMore extends HomeState {
  final HomeLoaded currentState;
  HomeLoadingMore(this.currentState);
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}

// Cubit
class HomeController extends Cubit<HomeState> {
  final ProductService productService;

  HomeController({
    required this.productService,
  }) : super(HomeInitial());

  Future<void> loadData({
    String? category,
    String? sortBy,
    String? order,
    String? searchQuery,
  }) async {
    emit(HomeLoading());

    try {
      // Load categories and products in parallel
      final results = await Future.wait([
        productService.getCategories(),
        _fetchProducts(
          category: category,
          sortBy: sortBy,
          order: order,
          searchQuery: searchQuery,
        ),
      ]);

      final categories = results[0] as List<String>;
      final productsData = results[1] as Map<String, dynamic>;

      // Safely parse products with error handling for individual items
      final productsList = productsData['products'];
      final products = productsList is List
          ? productsList
              .map((json) {
                try {
                  if (json is Map<String, dynamic>) {
                    return ProductModel.fromJson(json);
                  }
                  return null;
                } catch (e) {
                  print('Error parsing product: $e');
                  return null;
                }
              })
              .whereType<ProductModel>()
              .toList()
          : <ProductModel>[];

      final total = productsData['total'] is int
          ? productsData['total']
          : int.tryParse(productsData['total']?.toString() ?? '0') ?? 0;
      final limit = productsData['limit'] is int
          ? productsData['limit']
          : int.tryParse(productsData['limit']?.toString() ?? '20') ?? 20;
      final skip = productsData['skip'] is int
          ? productsData['skip']
          : int.tryParse(productsData['skip']?.toString() ?? '0') ?? 0;

      emit(HomeLoaded(
        products: products,
        categories: categories,
        total: total,
        skip: skip,
        limit: limit,
        selectedCategory: category,
        sortBy: sortBy,
        order: order,
        searchQuery: searchQuery,
        hasMore: products.length < total,
      ));
    } catch (e) {
      emit(HomeError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<Map<String, dynamic>> _fetchProducts({
    int skip = 0,
    int limit = 20,
    String? category,
    String? sortBy,
    String? order,
    String? searchQuery,
  }) async {
    if (searchQuery != null && searchQuery.isNotEmpty) {
      return await productService.searchProducts(
        searchQuery,
        limit: limit,
        skip: skip,
      );
    } else if (category != null && category.isNotEmpty) {
      return await productService.getProductsByCategory(
        category,
        limit: limit,
        skip: skip,
      );
    } else {
      return await productService.getProducts(
        limit: limit,
        skip: skip,
        sortBy: sortBy,
        order: order,
      );
    }
  }

  Future<void> loadMore() async {
    if (state is! HomeLoaded) return;

    final currentState = state as HomeLoaded;
    if (!currentState.hasMore) return;

    emit(HomeLoadingMore(currentState));

    try {
      final newSkip = currentState.skip + currentState.limit;

      final productsData = await _fetchProducts(
        skip: newSkip,
        limit: currentState.limit,
        category: currentState.selectedCategory,
        sortBy: currentState.sortBy,
        order: currentState.order,
        searchQuery: currentState.searchQuery,
      );

      // Safely parse products with error handling for individual items
      final productsList = productsData['products'];
      final newProducts = productsList is List
          ? productsList
              .map((json) {
                try {
                  if (json is Map<String, dynamic>) {
                    return ProductModel.fromJson(json);
                  }
                  return null;
                } catch (e) {
                  print('Error parsing product: $e');
                  return null;
                }
              })
              .whereType<ProductModel>()
              .toList()
          : <ProductModel>[];

      final allProducts = [...currentState.products, ...newProducts];

      emit(currentState.copyWith(
        products: allProducts,
        skip: newSkip,
        hasMore: allProducts.length < currentState.total,
      ));
    } catch (e) {
      emit(currentState); // Revert to previous state on error
    }
  }

  Future<void> searchProducts(String query) async {
    await loadData(
      searchQuery: query.isEmpty ? null : query,
      sortBy: state is HomeLoaded ? (state as HomeLoaded).sortBy : null,
      order: state is HomeLoaded ? (state as HomeLoaded).order : null,
    );
  }

  Future<void> filterByCategory(String? category) async {
    await loadData(
      category: category,
      sortBy: state is HomeLoaded ? (state as HomeLoaded).sortBy : null,
      order: state is HomeLoaded ? (state as HomeLoaded).order : null,
    );
  }

  Future<void> sortProducts(String? sortBy, String? order) async {
    await loadData(
      category: state is HomeLoaded ? (state as HomeLoaded).selectedCategory : null,
      sortBy: sortBy,
      order: order,
    );
  }

  Future<void> refresh() async {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      await loadData(
        category: currentState.selectedCategory,
        sortBy: currentState.sortBy,
        order: currentState.order,
        searchQuery: currentState.searchQuery,
      );
    } else {
      await loadData();
    }
  }
}
