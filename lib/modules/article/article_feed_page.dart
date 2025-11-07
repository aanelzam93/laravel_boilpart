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
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
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
      backgroundColor: const Color(0xFFF8F9FA),
      body: BlocBuilder<BlogController, BlogState>(
        builder: (context, state) {
          if (state is BlogLoading) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.purple.shade400),
              ),
            );
          }

          if (state is BlogError) {
            return _buildError(state.message);
          }

          if (state is BlogLoaded || state is BlogLoadingMore) {
            final currentState = state is BlogLoadingMore
                ? state.currentState
                : state as BlogLoaded;

            return RefreshIndicator(
              color: Colors.purple.shade400,
              onRefresh: () => Modular.get<BlogController>().refresh(),
              child: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  _buildAppBar(user?.fullName ?? user?.username ?? 'Guest'),
                  SliverToBoxAdapter(child: _buildSearchBar()),
                  if (currentState.posts.isNotEmpty &&
                      currentState.selectedTag == null)
                    SliverToBoxAdapter(
                        child: _buildFeaturedArticle(currentState.posts.first)),
                  SliverToBoxAdapter(child: _buildSectionTitle(currentState)),
                  SliverToBoxAdapter(child: _buildTagPills(currentState)),
                  _buildArticleGrid(currentState),
                  if (state is BlogLoadingMore)
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation(Colors.purple.shade400),
                          ),
                        ),
                      ),
                    ),
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
      expandedHeight: 160,
      floating: false,
      pinned: true,
      backgroundColor: Colors.white,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF6366F1),
                const Color(0xFF8B5CF6),
                const Color(0xFFEC4899),
              ],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white.withOpacity(0.3),
                          child: Text(
                            userName[0].toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Welcome back! 👋',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              userName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.notifications_outlined,
                            color: Colors.white),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Discover Stories',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search articles, topics, authors...',
          hintStyle: TextStyle(color: Colors.grey.shade400),
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(Icons.search, color: Colors.purple.shade400),
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
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
        onSubmitted: (query) {
          Modular.get<BlogController>().searchPosts(query);
        },
      ),
    );
  }

  Widget _buildFeaturedArticle(PostModel post) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 8, 20, 24),
      height: 280,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF6366F1),
            const Color(0xFF8B5CF6),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.purple.shade200.withOpacity(0.5),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => Modular.to.pushNamed('/blog/detail/${post.id}'),
          borderRadius: BorderRadius.circular(24),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.star, size: 16, color: Colors.white),
                          SizedBox(width: 4),
                          Text(
                            'Featured',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  post.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.2,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Text(
                  post.body,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                    height: 1.4,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Icon(Icons.favorite, size: 16, color: Colors.white.withOpacity(0.9)),
                    const SizedBox(width: 4),
                    Text(
                      '${post.reactions}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Icon(Icons.visibility, size: 16, color: Colors.white.withOpacity(0.9)),
                    const SizedBox(width: 4),
                    Text(
                      '${post.views}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.purple.shade600,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BlogLoaded state) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 24,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF6366F1), Color(0xFFEC4899)],
              ),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            state.selectedTag != null
                ? '#${_formatTagName(state.selectedTag!)}'
                : 'Trending Articles',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937),
            ),
          ),
          const Spacer(),
          Text(
            '${state.total} stories',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTagPills(BlogLoaded state) {
    return Container(
      height: 48,
      margin: const EdgeInsets.only(bottom: 16),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          _buildTagPill(
            label: 'All',
            isSelected: state.selectedTag == null,
            onTap: () => Modular.get<BlogController>().filterByTag(null),
            gradient: const LinearGradient(
              colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
            ),
          ),
          ...state.tags.take(10).map((tag) {
            return _buildTagPill(
              label: _formatTagName(tag),
              isSelected: state.selectedTag == tag,
              onTap: () => Modular.get<BlogController>().filterByTag(tag),
              gradient: LinearGradient(
                colors: _getGradientForTag(tag),
              ),
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
    required Gradient gradient,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              gradient: isSelected ? gradient : null,
              color: isSelected ? null : Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: Colors.purple.shade200.withOpacity(0.5),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : null,
            ),
            child: Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey.shade700,
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildArticleGrid(BlogLoaded state) {
    if (state.posts.isEmpty) {
      return const SliverFillRemaining(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.article_outlined, size: 64, color: Colors.grey),
              SizedBox(height: 16),
              Text('No articles found', style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      );
    }

    final postsToShow = (state.selectedTag == null)
        ? state.posts.skip(1).toList()
        : state.posts;

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) => _buildArticleCard(postsToShow[index], index),
          childCount: postsToShow.length,
        ),
      ),
    );
  }

  Widget _buildArticleCard(PostModel post, int index) {
    final gradients = [
      [const Color(0xFF6366F1), const Color(0xFF8B5CF6)],
      [const Color(0xFFEC4899), const Color(0xFFF59E0B)],
      [const Color(0xFF3B82F6), const Color(0xFF06B6D4)],
      [const Color(0xFF8B5CF6), const Color(0xFFEC4899)],
    ];

    final gradient = gradients[index % gradients.length];

    return InkWell(
      onTap: () => Modular.to.pushNamed('/blog/detail/${post.id}'),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: gradient,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Center(
                child: Icon(
                  Icons.article,
                  size: 48,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (post.tags.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: gradient[0].withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          '#${post.tags.first}',
                          style: TextStyle(
                            color: gradient[0],
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    const SizedBox(height: 8),
                    Text(
                      post.title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F2937),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Icon(Icons.favorite_border,
                            size: 14, color: Colors.grey.shade600),
                        const SizedBox(width: 4),
                        Text(
                          '${post.reactions}',
                          style: TextStyle(
                              fontSize: 12, color: Colors.grey.shade600),
                        ),
                        const SizedBox(width: 12),
                        Icon(Icons.visibility_outlined,
                            size: 14, color: Colors.grey.shade600),
                        const SizedBox(width: 4),
                        Text(
                          '${post.views}',
                          style: TextStyle(
                              fontSize: 12, color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Color> _getGradientForTag(String tag) {
    final gradients = [
      [const Color(0xFF6366F1), const Color(0xFF8B5CF6)],
      [const Color(0xFFEC4899), const Color(0xFFF59E0B)],
      [const Color(0xFF3B82F6), const Color(0xFF06B6D4)],
      [const Color(0xFF10B981), const Color(0xFF34D399)],
      [const Color(0xFFF59E0B), const Color(0xFFEF4444)],
    ];
    return gradients[tag.hashCode % gradients.length];
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
          ElevatedButton.icon(
            onPressed: () => Modular.get<BlogController>().refresh(),
            icon: const Icon(Icons.refresh),
            label: const Text('Try Again'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple.shade400,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
