import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../core/localization/app_localizations.dart';
import '../profile/profile_page.dart';
import '../blog/blog_controller.dart';
import '../article/article_feed_page.dart';
import '../article/explore_page.dart';
import '../article/write_article_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _navigateToWrite() {
    Modular.to.pushNamed('/article/write');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    final pages = [
      BlocProvider.value(
        value: Modular.get<BlogController>()..loadData(),
        child: const ArticleFeedPage(),
      ),
      BlocProvider.value(
        value: Modular.get<BlogController>(),
        child: const ExplorePage(),
      ),
      Container(), // Placeholder for Write (handled by navigation)
      const ProfilePage(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  icon: Icons.home_outlined,
                  selectedIcon: Icons.home,
                  label: 'Home',
                  index: 0,
                ),
                _buildNavItem(
                  icon: Icons.explore_outlined,
                  selectedIcon: Icons.explore,
                  label: 'Explore',
                  index: 1,
                ),
                _buildWriteButton(),
                _buildNavItem(
                  icon: Icons.person_outline,
                  selectedIcon: Icons.person,
                  label: 'Profile',
                  index: 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required IconData selectedIcon,
    required String label,
    required int index,
  }) {
    final isSelected = _currentIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? selectedIcon : icon,
              color: isSelected ? Colors.black : Colors.grey[600],
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected ? Colors.black : Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWriteButton() {
    return GestureDetector(
      onTap: _navigateToWrite,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.edit_outlined,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Write',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.normal,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
