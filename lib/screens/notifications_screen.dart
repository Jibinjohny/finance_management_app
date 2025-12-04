import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/notification_provider.dart';
import '../providers/auth_provider.dart';
import '../utils/app_colors.dart';
import '../widgets/glass_container.dart';
import 'package:cashflow_app/l10n/app_localizations.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userId = Provider.of<AuthProvider>(
        context,
        listen: false,
      ).currentUser?.id;
      if (userId != null) {
        Provider.of<NotificationProvider>(
          context,
          listen: false,
        ).loadNotifications(userId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          AppLocalizations.of(context)!.notificationsTitle,
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          Consumer<NotificationProvider>(
            builder: (context, provider, child) {
              if (provider.notifications.isEmpty) return SizedBox();
              return TextButton(
                onPressed: () {
                  final userId = Provider.of<AuthProvider>(
                    context,
                    listen: false,
                  ).currentUser?.id;
                  if (userId != null) {
                    provider.clearAllNotifications(userId);
                  }
                },
                child: Text(
                  AppLocalizations.of(context)!.clearAll,
                  style: TextStyle(color: AppColors.secondary),
                ),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Gradient Background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF1A1A2E),
                  Color(0xFF16213E),
                  Color(0xFF0F3460),
                  Color(0xFF1A1A2E),
                  Color(0xFF16213E),
                ],
              ),
            ),
          ),
          // Background Blobs
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withValues(alpha: 0.3),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 100,
                    spreadRadius: 50,
                  ),
                ],
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // Notifications List
                Expanded(
                  child: Consumer<NotificationProvider>(
                    builder: (context, provider, child) {
                      if (provider.isLoading) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (provider.notifications.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.notifications_none,
                                size: 80,
                                color: Colors.white30,
                              ),
                              SizedBox(height: 20),
                              Text(
                                AppLocalizations.of(
                                  context,
                                )!.noNotificationsYet,
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      return ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        itemCount: provider.notifications.length,
                        itemBuilder: (context, index) {
                          final notification = provider.notifications[index];
                          return Dismissible(
                            key: ValueKey(notification.id),
                            background: Container(
                              margin: EdgeInsets.only(bottom: 15),
                              decoration: BoxDecoration(
                                color: AppColors.error.withValues(alpha: 0.8),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.only(right: 20),
                              child: Icon(
                                Icons.delete,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) {
                              provider.deleteNotification(notification.id);
                            },
                            child: GestureDetector(
                              onTap: () {
                                if (!notification.isRead) {
                                  provider.markAsRead(notification.id);
                                }
                              },
                              child: GlassContainer(
                                margin: EdgeInsets.only(bottom: 15),
                                padding: EdgeInsets.all(15),
                                borderRadius: BorderRadius.circular(20),
                                color: notification.isRead
                                    ? Colors.transparent
                                    : AppColors.primary.withValues(alpha: 0.1),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: AppColors.primary.withValues(
                                          alpha: 0.2,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Icon(
                                        Icons.notifications,
                                        color: AppColors.primary,
                                        size: 20,
                                      ),
                                    ),
                                    SizedBox(width: 15),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  notification.title,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              if (!notification.isRead)
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
                                          SizedBox(height: 5),
                                          Text(
                                            notification.message,
                                            style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 14,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            _formatTimestamp(
                                              notification.timestamp,
                                            ),
                                            style: TextStyle(
                                              color: Colors.white38,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return AppLocalizations.of(context)!.justNow;
    } else if (difference.inHours < 1) {
      return AppLocalizations.of(context)!.minutesAgo(difference.inMinutes);
    } else if (difference.inDays < 1) {
      return AppLocalizations.of(context)!.hoursAgo(difference.inHours);
    } else if (difference.inDays < 7) {
      return AppLocalizations.of(context)!.daysAgo(difference.inDays);
    } else {
      return DateFormat('MMM d, y').format(timestamp);
    }
  }
}
