import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/post_model.dart';
import '../../data/services/post_service.dart';

// States
abstract class BlogState {}

class BlogInitial extends BlogState {}

class BlogLoading extends BlogState {}

class BlogLoaded extends BlogState {
  final List<PostModel> posts;
  final List<String> tags;
  final int total;
  final int skip;
  final int limit;
  final String? selectedTag;
  final String? sortBy;
  final String? order;
  final String? searchQuery;
  final bool hasMore;

  BlogLoaded({
    required this.posts,
    required this.tags,
    required this.total,
    this.skip = 0,
    this.limit = 20,
    this.selectedTag,
    this.sortBy,
    this.order,
    this.searchQuery,
    this.hasMore = true,
  });

  BlogLoaded copyWith({
    List<PostModel>? posts,
    List<String>? tags,
    int? total,
    int? skip,
    int? limit,
    String? selectedTag,
    String? sortBy,
    String? order,
    String? searchQuery,
    bool? hasMore,
  }) {
    return BlogLoaded(
      posts: posts ?? this.posts,
      tags: tags ?? this.tags,
      total: total ?? this.total,
      skip: skip ?? this.skip,
      limit: limit ?? this.limit,
      selectedTag: selectedTag ?? this.selectedTag,
      sortBy: sortBy ?? this.sortBy,
      order: order ?? this.order,
      searchQuery: searchQuery ?? this.searchQuery,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}

class BlogLoadingMore extends BlogState {
  final BlogLoaded currentState;
  BlogLoadingMore(this.currentState);
}

class BlogError extends BlogState {
  final String message;
  BlogError(this.message);
}

// Cubit
class BlogController extends Cubit<BlogState> {
  final PostService postService;

  BlogController({
    required this.postService,
  }) : super(BlogInitial());

  Future<void> loadData({
    String? tag,
    String? sortBy,
    String? order,
    String? searchQuery,
  }) async {
    emit(BlogLoading());

    try {
      // Load tags and posts in parallel
      final results = await Future.wait([
        postService.getTags(),
        _fetchPosts(
          tag: tag,
          sortBy: sortBy,
          order: order,
          searchQuery: searchQuery,
        ),
      ]);

      final tags = results[0] as List<String>;
      final postsData = results[1] as Map<String, dynamic>;

      // Safely parse posts with error handling for individual items
      final postsList = postsData['posts'];
      final posts = postsList is List
          ? postsList
              .map((json) {
                try {
                  if (json is Map<String, dynamic>) {
                    return PostModel.fromJson(json);
                  }
                  return null;
                } catch (e) {
                  print('Error parsing post: $e');
                  return null;
                }
              })
              .whereType<PostModel>()
              .toList()
          : <PostModel>[];

      final total = postsData['total'] is int
          ? postsData['total']
          : int.tryParse(postsData['total']?.toString() ?? '0') ?? 0;
      final limit = postsData['limit'] is int
          ? postsData['limit']
          : int.tryParse(postsData['limit']?.toString() ?? '20') ?? 20;
      final skip = postsData['skip'] is int
          ? postsData['skip']
          : int.tryParse(postsData['skip']?.toString() ?? '0') ?? 0;

      emit(BlogLoaded(
        posts: posts,
        tags: tags,
        total: total,
        skip: skip,
        limit: limit,
        selectedTag: tag,
        sortBy: sortBy,
        order: order,
        searchQuery: searchQuery,
        hasMore: posts.length < total,
      ));
    } catch (e) {
      emit(BlogError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<Map<String, dynamic>> _fetchPosts({
    int skip = 0,
    int limit = 20,
    String? tag,
    String? sortBy,
    String? order,
    String? searchQuery,
  }) async {
    if (searchQuery != null && searchQuery.isNotEmpty) {
      return await postService.searchPosts(
        searchQuery,
        limit: limit,
        skip: skip,
      );
    } else if (tag != null && tag.isNotEmpty) {
      return await postService.getPostsByTag(
        tag,
        limit: limit,
        skip: skip,
      );
    } else {
      return await postService.getPosts(
        limit: limit,
        skip: skip,
        sortBy: sortBy,
        order: order,
      );
    }
  }

  Future<void> loadMore() async {
    if (state is! BlogLoaded) return;

    final currentState = state as BlogLoaded;
    if (!currentState.hasMore) return;

    emit(BlogLoadingMore(currentState));

    try {
      final newSkip = currentState.skip + currentState.limit;

      final postsData = await _fetchPosts(
        skip: newSkip,
        limit: currentState.limit,
        tag: currentState.selectedTag,
        sortBy: currentState.sortBy,
        order: currentState.order,
        searchQuery: currentState.searchQuery,
      );

      // Safely parse posts with error handling for individual items
      final postsList = postsData['posts'];
      final newPosts = postsList is List
          ? postsList
              .map((json) {
                try {
                  if (json is Map<String, dynamic>) {
                    return PostModel.fromJson(json);
                  }
                  return null;
                } catch (e) {
                  print('Error parsing post: $e');
                  return null;
                }
              })
              .whereType<PostModel>()
              .toList()
          : <PostModel>[];

      final allPosts = [...currentState.posts, ...newPosts];

      emit(currentState.copyWith(
        posts: allPosts,
        skip: newSkip,
        hasMore: allPosts.length < currentState.total,
      ));
    } catch (e) {
      emit(currentState); // Revert to previous state on error
    }
  }

  Future<void> searchPosts(String query) async {
    await loadData(
      searchQuery: query.isEmpty ? null : query,
      sortBy: state is BlogLoaded ? (state as BlogLoaded).sortBy : null,
      order: state is BlogLoaded ? (state as BlogLoaded).order : null,
    );
  }

  Future<void> filterByTag(String? tag) async {
    await loadData(
      tag: tag,
      sortBy: state is BlogLoaded ? (state as BlogLoaded).sortBy : null,
      order: state is BlogLoaded ? (state as BlogLoaded).order : null,
    );
  }

  Future<void> sortPosts(String? sortBy, String? order) async {
    await loadData(
      tag: state is BlogLoaded ? (state as BlogLoaded).selectedTag : null,
      sortBy: sortBy,
      order: order,
    );
  }

  Future<void> refresh() async {
    if (state is BlogLoaded) {
      final currentState = state as BlogLoaded;
      await loadData(
        tag: currentState.selectedTag,
        sortBy: currentState.sortBy,
        order: currentState.order,
        searchQuery: currentState.searchQuery,
      );
    } else {
      await loadData();
    }
  }
}
