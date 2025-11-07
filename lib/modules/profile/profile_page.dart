import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/localization/language_cubit.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/theme_cubit.dart';
import '../../data/models/user_model.dart';
import '../auth/auth_controller.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final authController = context.read<AuthController>();
    final user = authController.getCurrentUser() ?? UserModel.dummy();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        slivers: [
          // Custom App Bar with Gradient
          SliverAppBar(
            expandedHeight: 280,
            floating: false,
            pinned: true,
            backgroundColor: AppColors.primary,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primary, AppColors.primary.withOpacity(0.8)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),

                      // Avatar with border and badge
                      Stack(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 4,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: user.image != null
                                ? CircleAvatar(
                                    radius: 50,
                                    backgroundImage: NetworkImage(user.image!),
                                    backgroundColor: Colors.white,
                                  )
                                : CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Colors.white,
                                    child: Icon(
                                      Icons.person,
                                      size: 50,
                                      color: AppColors.primary,
                                    ),
                                  ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Color(0xFFFFC837), Color(0xFFFF8008)],
                                ),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 3,
                                ),
                              ),
                              child: const Icon(
                                Icons.emoji_events,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Name
                      Text(
                        user.fullName,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),

                      // Username
                      Text(
                        '@${user.username}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.8),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 2),

                      // Email
                      Text(
                        user.email,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Level Badge
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.star, color: Colors.white, size: 16),
                            SizedBox(width: 6),
                            Text(
                              'Level 8 - Pro Learner',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Edit Profile Button
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.edit, color: Colors.white, size: 16),
                        label: const Text(
                          'Edit Profile',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.2),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Stats Row
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          icon: Icons.school,
                          value: '24',
                          label: 'Courses\nCompleted',
                          gradient: const [Color(0xFF667EEA), Color(0xFF764BA2)],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildStatCard(
                          icon: Icons.access_time,
                          value: '156',
                          label: 'Hours\nLearned',
                          gradient: const [Color(0xFF4FACFE), Color(0xFF00F2FE)],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildStatCard(
                          icon: Icons.trending_up,
                          value: '#42',
                          label: 'Global\nRank',
                          gradient: const [Color(0xFFF093FB), Color(0xFFF5576C)],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),

                  // Achievements Section
                  const Text(
                    'My Achievements 🏆',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Achievement Badges Grid
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 4,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    children: [
                      _buildAchievementBadge(
                        icon: Icons.local_fire_department,
                        color: const Color(0xFFFF6B6B),
                        label: 'Streak',
                      ),
                      _buildAchievementBadge(
                        icon: Icons.emoji_events,
                        color: const Color(0xFFFFC837),
                        label: 'Winner',
                      ),
                      _buildAchievementBadge(
                        icon: Icons.speed,
                        color: const Color(0xFF4FACFE),
                        label: 'Speed',
                      ),
                      _buildAchievementBadge(
                        icon: Icons.stars,
                        color: const Color(0xFFF093FB),
                        label: 'Star',
                      ),
                      _buildAchievementBadge(
                        icon: Icons.workspace_premium,
                        color: const Color(0xFF11998E),
                        label: 'Premium',
                      ),
                      _buildAchievementBadge(
                        icon: Icons.diamond,
                        color: const Color(0xFF667EEA),
                        label: 'Diamond',
                      ),
                      _buildAchievementBadge(
                        icon: Icons.verified,
                        color: const Color(0xFF00D2FF),
                        label: 'Verified',
                      ),
                      _buildAchievementBadge(
                        icon: Icons.military_tech,
                        color: const Color(0xFFFF6B9D),
                        label: 'Master',
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),

                  // Account Info Section
                  const Text(
                    'Account Information',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  _buildInfoCard(
                    context,
                    icon: Icons.email_outlined,
                    title: l10n.email,
                    value: user.email,
                    color: const Color(0xFF667EEA),
                  ),
                  const SizedBox(height: 12),

                  _buildInfoCard(
                    context,
                    icon: Icons.phone_outlined,
                    title: 'Phone',
                    value: user.phone ?? '+62 812-3456-7890',
                    color: const Color(0xFF4FACFE),
                  ),
                  const SizedBox(height: 12),

                  _buildInfoCard(
                    context,
                    icon: Icons.badge_outlined,
                    title: 'User ID',
                    value: user.id.toString(),
                    color: const Color(0xFFF093FB),
                  ),
                  const SizedBox(height: 12),

                  _buildInfoCard(
                    context,
                    icon: Icons.calendar_today,
                    title: 'Member Since',
                    value: 'January 2024',
                    color: const Color(0xFF11998E),
                  ),
                  const SizedBox(height: 28),

                  // Quick Actions
                  const Text(
                    'Quick Actions',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(
                        child: _buildActionButton(
                          icon: Icons.history,
                          label: 'Learning\nHistory',
                          color: const Color(0xFF667EEA),
                          onTap: () {},
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildActionButton(
                          icon: Icons.bookmark,
                          label: 'Saved\nCourses',
                          color: const Color(0xFFF093FB),
                          onTap: () {},
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildActionButton(
                          icon: Icons.card_giftcard,
                          label: 'My\nRewards',
                          color: const Color(0xFFFFC837),
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),

                  // Settings Section
                  Text(
                    l10n.settings,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Language Selector
                  BlocBuilder<LanguageCubit, Locale>(
                    builder: (context, locale) {
                      return Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: AppColors.secondary.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(
                                    Icons.language,
                                    color: AppColors.secondary,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  l10n.language,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            
                            // Indonesian
                            InkWell(
                              onTap: () {
                                BlocProvider.of<LanguageCubit>(context).toIndonesian();
                              },
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: locale.languageCode == 'id'
                                      ? AppColors.secondary.withOpacity(0.1)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: locale.languageCode == 'id'
                                        ? AppColors.secondary
                                        : Colors.transparent,
                                    width: 2,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    const Text('🇮🇩', style: TextStyle(fontSize: 24)),
                                    const SizedBox(width: 12),
                                    const Expanded(
                                      child: Text(
                                        'Bahasa Indonesia',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    if (locale.languageCode == 'id')
                                      Icon(
                                        Icons.check_circle,
                                        color: AppColors.secondary,
                                        size: 24,
                                      ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            
                            // English
                            InkWell(
                              onTap: () {
                                BlocProvider.of<LanguageCubit>(context).toEnglish();
                              },
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: locale.languageCode == 'en'
                                      ? AppColors.secondary.withOpacity(0.1)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: locale.languageCode == 'en'
                                        ? AppColors.secondary
                                        : Colors.transparent,
                                    width: 2,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    const Text('🇬🇧', style: TextStyle(fontSize: 24)),
                                    const SizedBox(width: 12),
                                    const Expanded(
                                      child: Text(
                                        'English',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    if (locale.languageCode == 'en')
                                      Icon(
                                        Icons.check_circle,
                                        color: AppColors.secondary,
                                        size: 24,
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  
                  // Theme Selector
                  BlocBuilder<ThemeCubit, ThemeMode>(
                    builder: (context, themeMode) {
                      return Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(
                                    Icons.palette_outlined,
                                    color: AppColors.primary,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  l10n.theme,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                              
                              // Light Mode
                              RadioListTile<ThemeMode>(
                                title: Row(
                                  children: [
                                    const Icon(Icons.light_mode, size: 20),
                                    const SizedBox(width: 8),
                                    Text(l10n.lightMode),
                                  ],
                                ),
                                value: ThemeMode.light,
                                groupValue: themeMode,
                                onChanged: (value) {
                                  if (value != null) {
                                    BlocProvider.of<ThemeCubit>(context).setLightMode();
                                  }
                                },
                                activeColor: AppColors.primary,
                              ),
                              
                              // Dark Mode
                              RadioListTile<ThemeMode>(
                                title: Row(
                                  children: [
                                    const Icon(Icons.dark_mode, size: 20),
                                    const SizedBox(width: 8),
                                    Text(l10n.darkMode),
                                  ],
                                ),
                                value: ThemeMode.dark,
                                groupValue: themeMode,
                                onChanged: (value) {
                                  if (value != null) {
                                    BlocProvider.of<ThemeCubit>(context).setDarkMode();
                                  }
                                },
                                activeColor: AppColors.primary,
                              ),
                              
                              // System Mode
                              RadioListTile<ThemeMode>(
                                title: Row(
                                  children: [
                                    const Icon(Icons.settings_suggest, size: 20),
                                    const SizedBox(width: 8),
                                    Text(l10n.systemMode),
                                  ],
                                ),
                                value: ThemeMode.system,
                                groupValue: themeMode,
                                onChanged: (value) {
                                  if (value != null) {
                                    BlocProvider.of<ThemeCubit>(context).setSystemMode();
                                  }
                                },
                                activeColor: AppColors.primary,
                              ),
                            ],
                          ),
                        );
                    },
                  ),
                  const SizedBox(height: 28),

                  // Logout Button
                  Container(
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFEB3349), Color(0xFFF45C43)],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFEB3349).withOpacity(0.4),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: ElevatedButton.icon(
                      onPressed: () => _showLogoutDialog(context),
                      icon: const Icon(Icons.logout, size: 20),
                      label: Text(
                        l10n.logout,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Stat Card Widget
  Widget _buildStatCard({
    required IconData icon,
    required String value,
    required String label,
    required List<Color> gradient,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: gradient[0].withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 28),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 11,
              fontWeight: FontWeight.w500,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  // Achievement Badge Widget
  Widget _buildAchievementBadge({
    required IconData icon,
    required Color color,
    required String label,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: color.withOpacity(0.3),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(icon, color: color, size: 28),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
          ),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  // Action Button Widget
  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: color.withOpacity(0.3),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color, color.withOpacity(0.8)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: color.withOpacity(0.5),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.logout),
        content: const Text('Apakah Anda yakin ingin keluar?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              BlocProvider.of<AuthController>(context).logout();
              Navigator.pop(dialogContext);
              Modular.to.navigate('/auth/');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
            ),
            child: Text(l10n.logout),
          ),
        ],
      ),
    );
  }
}
