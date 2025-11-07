import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Notifications',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Mark all as read
            },
            child: Text(
              'Mark all read',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Today Section
          const Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: Text(
              'Today',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          
          _buildNotificationItem(
            context,
            icon: Icons.celebration,
            iconColor: AppColors.secondary,
            title: 'Congratulations!',
            message: 'You\'ve completed the Business Basics course and earned +100 XP',
            time: '5 min ago',
            isUnread: true,
          ),
          const SizedBox(height: 12),
          
          _buildNotificationItem(
            context,
            icon: Icons.star,
            iconColor: AppColors.warning,
            title: 'New Badge Earned!',
            message: 'You\'ve unlocked the "Quick Learner" badge',
            time: '1 hour ago',
            isUnread: true,
          ),
          const SizedBox(height: 12),
          
          _buildNotificationItem(
            context,
            icon: Icons.trending_up,
            iconColor: AppColors.success,
            title: 'Level Up!',
            message: 'Congratulations! You\'ve reached Level 8',
            time: '2 hours ago',
            isUnread: true,
          ),
          const SizedBox(height: 24),
          
          // Yesterday Section
          const Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: Text(
              'Yesterday',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          
          _buildNotificationItem(
            context,
            icon: Icons.assignment_turned_in,
            iconColor: AppColors.info,
            title: 'Task Completed',
            message: 'Market Research task has been marked as done',
            time: 'Yesterday, 6:30 PM',
            isUnread: false,
          ),
          const SizedBox(height: 12),
          
          _buildNotificationItem(
            context,
            icon: Icons.notifications_active,
            iconColor: AppColors.primary,
            title: 'Daily Challenge Available',
            message: 'Complete today\'s quiz to earn +50 XP bonus',
            time: 'Yesterday, 9:00 AM',
            isUnread: false,
          ),
          const SizedBox(height: 12),
          
          _buildNotificationItem(
            context,
            icon: Icons.people,
            iconColor: AppColors.secondary,
            title: 'New Connection',
            message: 'John Doe started following you',
            time: 'Yesterday, 8:15 AM',
            isUnread: false,
          ),
          const SizedBox(height: 24),
          
          // This Week Section
          const Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: Text(
              'This Week',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          
          _buildNotificationItem(
            context,
            icon: Icons.card_giftcard,
            iconColor: AppColors.error,
            title: 'Special Offer',
            message: 'Get 20% off on premium courses this week!',
            time: '3 days ago',
            isUnread: false,
          ),
          const SizedBox(height: 12),
          
          _buildNotificationItem(
            context,
            icon: Icons.update,
            iconColor: AppColors.info,
            title: 'App Update',
            message: 'New features and improvements are available',
            time: '4 days ago',
            isUnread: false,
          ),
          const SizedBox(height: 12),
          
          _buildNotificationItem(
            context,
            icon: Icons.lightbulb_outline,
            iconColor: AppColors.warning,
            title: 'Tip of the Day',
            message: 'Complete courses consistently to maintain your streak',
            time: '5 days ago',
            isUnread: false,
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String title,
    required String message,
    required String time,
    bool isUnread = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isUnread ? AppColors.primary.withOpacity(0.05) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: isUnread 
            ? Border.all(color: AppColors.primary.withOpacity(0.2), width: 1)
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 16),
          
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontWeight: isUnread ? FontWeight.bold : FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    if (isUnread)
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  message,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  time,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
