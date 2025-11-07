import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/product_model.dart';
import '../../data/models/post_model.dart';
import '../../data/services/product_service.dart';
import '../../data/services/post_service.dart';

// States
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<ProductModel> products;
  final List<PostModel> posts;
  final List<String> categories;

  HomeLoaded({
    required this.products,
    required this.posts,
    required this.categories,
  });
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}

// Cubit
class HomeController extends Cubit<HomeState> {
  final ProductService productService;
  final PostService postService;

  HomeController({
    required this.productService,
    required this.postService,
  }) : super(HomeInitial());

  Future<void> loadData() async {
    emit(HomeLoading());

    try {
      // Load products, posts, and categories in parallel
      final results = await Future.wait([
        productService.getProducts(limit: 10),
        postService.getPosts(limit: 6),
        productService.getCategories(),
      ]);

      final productsData = results[0] as Map<String, dynamic>;
      final postsData = results[1] as Map<String, dynamic>;
      final categories = results[2] as List<String>;

      final products = (productsData['products'] as List)
          .map((json) => ProductModel.fromJson(json))
          .toList();

      final posts = (postsData['posts'] as List)
          .map((json) => PostModel.fromJson(json))
          .toList();

      emit(HomeLoaded(
        products: products,
        posts: posts,
        categories: categories.take(4).toList(),
      ));
    } catch (e) {
      emit(HomeError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> searchProducts(String query) async {
    if (query.isEmpty) {
      await loadData();
      return;
    }

    try {
      final response = await productService.searchProducts(query);
      final products = (response['products'] as List)
          .map((json) => ProductModel.fromJson(json))
          .toList();

      if (state is HomeLoaded) {
        final currentState = state as HomeLoaded;
        emit(HomeLoaded(
          products: products,
          posts: currentState.posts,
          categories: currentState.categories,
        ));
      }
    } catch (e) {
      emit(HomeError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> loadProductsByCategory(String category) async {
    try {
      final response = await productService.getProductsByCategory(category);
      final products = (response['products'] as List)
          .map((json) => ProductModel.fromJson(json))
          .toList();

      if (state is HomeLoaded) {
        final currentState = state as HomeLoaded;
        emit(HomeLoaded(
          products: products,
          posts: currentState.posts,
          categories: currentState.categories,
        ));
      }
    } catch (e) {
      emit(HomeError(e.toString().replaceAll('Exception: ', '')));
    }
  }
}
