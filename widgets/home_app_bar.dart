import 'package:flutter/material.dart';
import 'package:hom/models/notification_model.dart';
import 'package:hom/theme/Appcolors.dart';

class HomeAppBar extends StatelessWidget {
  final List<NotificationModel> notifications;
  final VoidCallback onNotificationPressed;
  final VoidCallback onProfilePressed;
  final int unreadNotificationsCount;
  final Animation<double> nameScaleAnimation;
  final Animation<double> nameSlideAnimation;

  const HomeAppBar({
    super.key,
    required this.notifications,
    required this.onNotificationPressed,
    required this.onProfilePressed,
    required this.unreadNotificationsCount,
    required this.nameScaleAnimation,
    required this.nameSlideAnimation,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome back,",
                style: textTheme.titleMedium?.copyWith(
                  color: AppColors.navyBlue.withOpacity(0.7),
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 4),
              AnimatedBuilder(
                animation: nameScaleAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, nameSlideAnimation.value),
                    child: Transform.scale(
                      scale: nameScaleAnimation.value,
                      child: Text(
                        "Nagham",
                        style: textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                          fontFamily: 'Poppins',
                          color: AppColors.navyBlue.withOpacity(0.9),
                          fontSize: 36,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          Row(
            children: [
              _buildNotificationIcon(),
              const SizedBox(width: 16),
              _buildProfileAvatar(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationIcon() {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.offWhite,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.darkGray.withOpacity(0.15),
            offset: const Offset(0, 4),
            blurRadius: 12,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: onNotificationPressed,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Stack(
              children: [
                const Icon(
                  Icons.notifications_none,
                  color: AppColors.navyBlue,
                  size: 26,
                ),
                if (unreadNotificationsCount > 0)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        unreadNotificationsCount > 9
                            ? '9+'
                            : unreadNotificationsCount.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileAvatar() {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.offWhite,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.darkGray.withOpacity(0.15),
            offset: const Offset(0, 4),
            blurRadius: 12,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: onProfilePressed,
          child: const Padding(
            padding: EdgeInsets.all(8),
            child: CircleAvatar(
              radius: 25,
              backgroundColor: Color(0x33E3D9D0),
              child: Text(
                "N",
                style: TextStyle(
                  color: AppColors.navyBlue,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
