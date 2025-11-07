import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../data/models/post_model.dart';
import '../blog/blog_controller.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<BlogController, BlogState>(
        builder: (context, state) {
          if (state is BlogLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is BlogError) {
            return _buildError(state.message);
          }

          if (state is BlogLoaded || state is BlogLoadingMore) {
            final currentState = state is BlogLoadingMore
                ? state.currentState
                : state as BlogLoaded;

            return CustomScrollView(
              slivers: [
                // App Bar
                _buildAppBar(),

                // Search Bar
                SliverToBoxAdapter(child: _buildSearchBar(currentState)),

                // Section: Trending Topics
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 32, 24, 16),
                    child: Text(
                      currentState.selectedTag != null
                          ? 'Articles tagged with "${_formatTagName(currentState.selectedTag!)}"'
                          : 'Explore Topics',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),

                // Tags Grid or Articles
                if (currentState.selectedTag == null)
                  _buildTagsGrid(currentState)
                else
                  _buildArticlesList(currentState),

                const SliverToBoxAdapter(child: SizedBox(height: 100)),
              ],
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      floating: true,
      backgroundColor: Colors.white,
      elevation: 0,
      title: const Text(
        'Explore',
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          height: 1,
          color: Colors.grey[200],
        ),
      ),
    );
  }

  Widget _buildSearchBar(BlogLoaded state) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search articles...',
          hintStyle: TextStyle(color: Colors.grey[400]),
          filled: true,
          fillColor: Colors.grey[100],
          prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    Modular.get<BlogController>().searchPosts('');
                  },
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
        ),
        onSubmitted: (query) {
          Modular.get<BlogController>().searchPosts(query);
        },
      ),
    );
  }

  Widget _buildTagsGrid(BlogLoaded state) {
    if (state.tags.isEmpty) {
      return const SliverFillRemaining(
        child: Center(
          child: Text('No topics available'),
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2.5,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final tag = state.tags[index];
            return _buildTopicCard(tag);
          },
          childCount: state.tags.length,
        ),
      ),
    );
  }

  Widget _buildTopicCard(String tag) {
    final colors = [
      [const Color(0xFFFF6B6B), const Color(0xFFFFE66D)],
      [const Color(0xFF4FACFE), const Color(0xFF00F2FE)],
      [const Color(0xFF667EEA), const Color(0xFF764BA2)],
      [const Color(0xFFF093FB), const Color(0xFFF5576C)],
      [const Color(0xFF4FACFE), const Color(0xFF00F2FE)],
    ];

    final colorIndex = tag.hashCode % colors.length;

    return InkWell(
      onTap: () => Modular.get<BlogController>().filterByTag(tag),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors[colorIndex],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: colors[colorIndex][0].withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '#${_formatTagName(tag)}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildArticlesList(BlogLoaded state) {
    if (state.posts.isEmpty) {
      return const SliverFillRemaining(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.article_outlined, size: 64, color: Colors.grey),
              SizedBox(height: 16),
              Text('No articles found'),
            ],
          ),
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final post = state.posts[index];
            return _buildArticleCard(post);
          },
          childCount: state.posts.length,
        ),
      ),
    );
  }

  Widget _buildArticleCard(PostModel post) {
    return InkWell(
      onTap: () {
        Modular.to.pushNamed('/blog/detail/${post.id}');
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey[200]!),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Text(
              post.body,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.favorite_border, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  '${post.reactions}',
                  style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                ),
                const SizedBox(width: 16),
                Icon(Icons.visibility_outlined,
                    size: 16, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  '${post.views}',
                  style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatTagName(String tag) {
    return tag.split('-').map((word) {
      return word[0].toUpperCase() + word.substring(1);
    }).join(' ');
  }

  Widget _buildError(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          Text(message, textAlign: TextAlign.center),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => Modular.get<BlogController>().refresh(),
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }
}
