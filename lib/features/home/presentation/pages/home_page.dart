import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/localization/language_cubit.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.home),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () => _showLanguageDialog(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.welcome,
                      style: AppTextStyles.h2,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${l10n.hello}! 👋',
                      style: AppTextStyles.bodyLarge,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            // Features Section
            Text(
              'Features',
              style: AppTextStyles.h3,
            ),
            const SizedBox(height: 16),
            
            _buildFeatureCard(
              context,
              icon: Icons.architecture,
              title: 'Clean Architecture',
              description: 'Structured with separation of concerns',
            ),
            const SizedBox(height: 12),
            
            _buildFeatureCard(
              context,
              icon: Icons.language,
              title: 'Multi-Language',
              description: 'Support for Indonesian and English',
            ),
            const SizedBox(height: 12),
            
            _buildFeatureCard(
              context,
              icon: Icons.dark_mode,
              title: 'Dark Mode',
              description: 'Light and dark theme support',
            ),
            const SizedBox(height: 12),
            
            _buildFeatureCard(
              context,
              icon: Icons.route,
              title: 'Navigation',
              description: 'GoRouter for declarative routing',
            ),
            const SizedBox(height: 12),
            
            _buildFeatureCard(
              context,
              icon: Icons.storage,
              title: 'State Management',
              description: 'BLoC pattern with flutter_bloc',
            ),
            const SizedBox(height: 12),
            
            _buildFeatureCard(
              context,
              icon: Icons.api,
              title: 'API Integration',
              description: 'Dio with interceptors and logging',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.primary.withOpacity(0.1),
          child: Icon(icon, color: AppColors.primary),
        ),
        title: Text(
          title,
          style: AppTextStyles.h4,
        ),
        subtitle: Text(
          description,
          style: AppTextStyles.bodyMedium,
        ),
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.language),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Text('🇮🇩', style: TextStyle(fontSize: 24)),
              title: const Text('Bahasa Indonesia'),
              onTap: () {
                context.read<LanguageCubit>().toIndonesian();
                Navigator.pop(dialogContext);
              },
            ),
            ListTile(
              leading: const Text('🇬🇧', style: TextStyle(fontSize: 24)),
              title: const Text('English'),
              onTap: () {
                context.read<LanguageCubit>().toEnglish();
                Navigator.pop(dialogContext);
              },
            ),
          ],
        ),
      ),
    );
  }
}
