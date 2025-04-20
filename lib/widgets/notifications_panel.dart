import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hom/models/notification_model.dart';
import 'package:hom/theme/Appcolors.dart';

class NotificationsPanel extends StatefulWidget {
  final List<NotificationModel> notifications;
  final Function(int) markAsRead;
  final VoidCallback toggleNotifications;
  final VoidCallback markAllAsRead;

  const NotificationsPanel({
    super.key,
    required this.notifications,
    required this.markAsRead,
    required this.toggleNotifications,
    required this.markAllAsRead,
  });

  @override
  State<NotificationsPanel> createState() => _NotificationsPanelState();
}

class _NotificationsPanelState extends State<NotificationsPanel>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;

  // Map of notification types to emojis
  final Map<String, String> _notificationEmojis = {
    'default': '🔔',
    'message': '💬',
    'alert': '⚠️',
    'update': '🔄',
    'reminder': '⏰',
    'success': '✅',
    'warning': '⚠️',
    'error': '❌',
    'info': 'ℹ️',
  };

  String _getEmoji(NotificationModel notification) {
    // Get the type from notification or default to 'default'
    String type = notification.type ?? 'default';
    return _notificationEmojis[type] ?? _notificationEmojis['default']!;
  }

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    // Create slide animation
    _slideAnimation = Tween<double>(begin: -20.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );

    // Create fade animation
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );

    // Start the animation
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 60,
      right: 10,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, _slideAnimation.value),
            child: Opacity(opacity: _fadeAnimation.value, child: child),
          );
        },
        child: Material(
          color: Colors.transparent,
          elevation: 8,
          borderRadius: BorderRadius.circular(20), // Increased roundness
          child: Container(
            width: MediaQuery.of(context).size.width * 0.85,
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.6,
              maxWidth: 400,
            ),
            decoration: BoxDecoration(
              // Lighter background color with gradient
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.navyBlue.withOpacity(0.85),
                  Color(
                    0xFF253652,
                  ).withOpacity(0.90), // Slightly lighter variant
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.beige.withOpacity(
                  0.4,
                ), // Slightly more visible border
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.darkGray.withOpacity(0.4),
                  blurRadius: 15,
                  spreadRadius: 2,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header with glass-like effect and gradient
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 12.0,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.beige.withOpacity(0.15),
                        AppColors.beige.withOpacity(0.05),
                      ],
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          // Animated bell icon
                          TweenAnimationBuilder<double>(
                            tween: Tween<double>(begin: 0.0, end: 1.0),
                            duration: const Duration(milliseconds: 500),
                            builder: (context, value, child) {
                              return Transform.rotate(
                                angle: value *
                                    0.1 *
                                    (value < 0.5 ? value : 1 - value) *
                                    10,
                                child: Icon(
                                  Icons.notifications_none,
                                  color: AppColors.beige,
                                  size: 22,
                                ),
                              );
                            },
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "Notifications",
                            style: TextStyle(
                              color: AppColors.offWhite,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Montserrat',
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          // Mark all as read button with emoji
                          TextButton.icon(
                            icon: const Text(
                              "✨",
                              style: TextStyle(fontSize: 14),
                            ),
                            label: Text(
                              "Clear All",
                              style: TextStyle(
                                color: AppColors.beige,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                            onPressed: widget.markAllAsRead,
                            style: TextButton.styleFrom(
                              minimumSize: Size.zero,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                          ),
                          // Close button
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.beige.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: IconButton(
                              icon: const Icon(
                                CupertinoIcons.xmark,
                                color: AppColors.offWhite,
                              ),
                              onPressed: () {
                                // Run reverse animation before closing
                                _animationController.reverse().then((_) {
                                  widget.toggleNotifications();
                                });
                              },
                              padding: const EdgeInsets.all(4),
                              constraints: const BoxConstraints(),
                              iconSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Divider(
                  color: AppColors.beige,
                  thickness: 0.5,
                  height: 1,
                ),
                Container(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.45,
                  ),
                  child: widget.notifications.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  CupertinoIcons.bell_slash,
                                  color: AppColors.offWhite.withOpacity(0.6),
                                  size: 40,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "No notifications yet 🔕",
                                  style: TextStyle(
                                    color: AppColors.offWhite,
                                    fontSize: 16,
                                    fontFamily: 'Montserrat',
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "We'll notify you when something happens",
                                  style: TextStyle(
                                    color: AppColors.offWhite.withOpacity(
                                      0.6,
                                    ),
                                    fontSize: 14,
                                    fontFamily: 'Montserrat',
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        )
                      : ListView.separated(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: widget.notifications.length,
                          separatorBuilder: (context, index) => Divider(
                            color: AppColors.beige.withOpacity(0.1),
                            height: 1,
                            indent: 15,
                            endIndent: 15,
                          ),
                          itemBuilder: (context, index) {
                            final notification = widget.notifications[index];
                            final bool isRead = notification.read;
                            final String emoji = _getEmoji(notification);

                            return Dismissible(
                              key: Key('notification_$index'),
                              background: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Colors.red.withOpacity(0.0),
                                      Colors.red.withOpacity(0.7),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.only(right: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: const [
                                    Text(
                                      "Dismiss",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Icon(
                                      Icons.delete_outline,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                              direction: DismissDirection.endToStart,
                              onDismissed: (direction) {
                                // Handle dismiss (remove notification or mark as read)
                                widget.markAsRead(index);
                              },
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () => widget.markAsRead(index),
                                  splashColor: AppColors.beige.withOpacity(
                                    0.1,
                                  ),
                                  highlightColor: AppColors.beige.withOpacity(
                                    0.05,
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0,
                                      vertical: 12.0,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isRead
                                          ? Colors.transparent
                                          : AppColors.beige.withOpacity(
                                              0.08,
                                            ),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Emoji or icon for notification type
                                        Container(
                                          width: 30,
                                          height: 30,
                                          margin: const EdgeInsets.only(
                                            top: 2,
                                            right: 10,
                                          ),
                                          decoration: BoxDecoration(
                                            color: isRead
                                                ? AppColors.beige
                                                    .withOpacity(0.1)
                                                : AppColors.beige
                                                    .withOpacity(0.15),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Center(
                                            child: Text(
                                              emoji,
                                              style: const TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      notification.title,
                                                      style: TextStyle(
                                                        color:
                                                            AppColors.offWhite,
                                                        fontSize: 16,
                                                        fontWeight: isRead
                                                            ? FontWeight.w500
                                                            : FontWeight.w600,
                                                        fontFamily:
                                                            'Montserrat',
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 6,
                                                      vertical: 2,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: AppColors.beige
                                                          .withOpacity(0.08),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        10,
                                                      ),
                                                    ),
                                                    child: Text(
                                                      notification.time,
                                                      style: TextStyle(
                                                        color: AppColors
                                                            .offWhite
                                                            .withOpacity(0.7),
                                                        fontSize: 12,
                                                        fontFamily:
                                                            'Montserrat',
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 5),
                                              Text(
                                                notification.message,
                                                style: TextStyle(
                                                  color: AppColors.offWhite
                                                      .withOpacity(0.8),
                                                  fontSize: 14,
                                                  fontFamily: 'Montserrat',
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              if (notification.actionable)
                                                Row(
                                                  children: [
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        // Handle action button press
                                                        widget.markAsRead(
                                                          index,
                                                        );
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            AppColors.beige
                                                                .withOpacity(
                                                          0.2,
                                                        ),
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 10,
                                                          vertical: 5,
                                                        ),
                                                        minimumSize: Size.zero,
                                                        tapTargetSize:
                                                            MaterialTapTargetSize
                                                                .shrinkWrap,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            12,
                                                          ),
                                                        ),
                                                      ),
                                                      child: Text(
                                                        notification
                                                                .actionText ??
                                                            "View",
                                                        style: TextStyle(
                                                          color:
                                                              AppColors.beige,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 8),
                                                    TextButton(
                                                      onPressed: () =>
                                                          widget.markAsRead(
                                                        index,
                                                      ),
                                                      style:
                                                          TextButton.styleFrom(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 10,
                                                          vertical: 5,
                                                        ),
                                                        minimumSize: Size.zero,
                                                        tapTargetSize:
                                                            MaterialTapTargetSize
                                                                .shrinkWrap,
                                                      ),
                                                      child: Text(
                                                        "Dismiss",
                                                        style: TextStyle(
                                                          color: AppColors
                                                              .offWhite
                                                              .withOpacity(
                                                            0.6,
                                                          ),
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
