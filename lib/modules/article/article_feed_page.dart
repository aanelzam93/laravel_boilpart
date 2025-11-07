import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../data/models/post_model.dart';
import '../auth/auth_controller.dart';
import '../blog/blog_controller.dart';

class ArticleFeedPage extends StatefulWidget {
  const ArticleFeedPage({super.key});

  @override
  State<ArticleFeedPage> createState() => _ArticleFeedPageState();
}

class _ArticleFeedPageState extends State<ArticleFeedPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final controller = Modular.get<BlogController>();
      if (controller.state is BlogLoaded) {
        controller.loadMore();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authController = Modular.get<AuthController>();
    final user = authController.getCurrentUser();

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

            return RefreshIndicator(
              onRefresh: () => Modular.get<BlogController>().refresh(),
              child: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  // App Bar
                  _buildAppBar(user?.fullName ?? user?.username ?? 'Guest'),

                  // Tag Pills
                  SliverToBoxAdapter(child: _buildTagPills(currentState)),

                  // Article List
                  _buildArticleList(currentState),

                  // Loading More Indicator
                  if (state is BlogLoadingMore)
                    const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    ),

                  // Bottom Padding
                  const SliverToBoxAdapter(child: SizedBox(height: 100)),
                ],
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildAppBar(String userName) {
    return SliverAppBar(
      floating: true,
      pinned: true,
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: const Text(
              'Medium',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'Georgia',
                letterSpacing: -0.5,
              ),
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: Colors.black87),
          onPressed: () {
            // TODO: Implement search
          },
        ),
        IconButton(
          icon: const Icon(Icons.notifications_outlined, color: Colors.black87),
          onPressed: () {
            // TODO: Implement notifications
          },
        ),
        const SizedBox(width: 8),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          height: 1,
          color: Colors.grey[200],
        ),
      ),
    );
  }

  Widget _buildTagPills(BlogLoaded state) {
    return Container(
      height: 48,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          _buildTagPill(
            label: 'For you',
            isSelected: state.selectedTag == null,
            onTap: () => Modular.get<BlogController>().filterByTag(null),
          ),
          ...state.tags.take(10).map((tag) {
            return _buildTagPill(
              label: _formatTagName(tag),
              isSelected: state.selectedTag == tag,
              onTap: () => Modular.get<BlogController>().filterByTag(tag),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildTagPill({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Material(
        color: isSelected ? Colors.black : Colors.transparent,
        borderRadius: BorderRadius.circular(24),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(
                color: isSelected ? Colors.black : Colors.grey[300]!,
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildArticleList(BlogLoaded state) {
    if (state.posts.isEmpty) {
      return const SliverFillRemaining(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.article_outlined, size: 64, color: Colors.grey),
              SizedBox(height: 16),
              Text(
                'No articles found',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
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
    final readTime = (post.body.length / 200).ceil(); // Rough estimate

    return InkWell(
      onTap: () => Modular.to.pushNamed('/blog/detail/${post.id}'),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 24),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey[200]!),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Author Info
            Row(
              children: [
                CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.grey[300],
                  child: Text(
                    'U${post.userId}',
                    style: const TextStyle(fontSize: 10, color: Colors.black54),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'User ${post.userId}',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Article Title
            Text(
              post.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                height: 1.3,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),

            // Article Preview
            Text(
              post.body,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[700],
                height: 1.5,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 16),

            // Meta Info & Tags
            Row(
              children: [
                // Tags
                if (post.tags.isNotEmpty) ...[
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      post.tags.first,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                ],

                // Read time
                Text(
                  '$readTime min read',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(width: 8),

                const Text('·', style: TextStyle(color: Colors.grey)),
                const SizedBox(width: 8),

                // Reactions
                Icon(Icons.favorite_border, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  '${post.reactions}',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),

                const Spacer(),

                // Bookmark icon
                Icon(Icons.bookmark_border, size: 20, color: Colors.grey[600]),
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
          Text(
            message,
            style: TextStyle(color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => Modular.get<BlogController>().refresh(),
            icon: const Icon(Icons.refresh),
            label: const Text('Try Again'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
