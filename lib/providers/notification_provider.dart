import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/notification.dart';
import '../services/database_helper.dart';

class NotificationProvider with ChangeNotifier {
  List<AppNotification> _notifications = [];
  bool _isLoading = false;

  List<AppNotification> get notifications => _notifications;
  bool get isLoading => _isLoading;
  int get unreadCount => _notifications.where((n) => !n.isRead).length;

  Future<void> loadNotifications(String userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final db = await DatabaseHelper.instance.database;
      final maps = await db.query(
        'notifications',
        where: 'userId = ?',
        whereArgs: [userId],
        orderBy: 'timestamp DESC',
      );

      _notifications = maps.map((map) => AppNotification.fromMap(map)).toList();
    } catch (e) {
      print('Error loading notifications: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addNotification({
    required String userId,
    required String title,
    required String message,
  }) async {
    final notification = AppNotification(
      id: const Uuid().v4(),
      title: title,
      message: message,
      timestamp: DateTime.now(),
      isRead: false,
      userId: userId,
    );

    try {
      final db = await DatabaseHelper.instance.database;
      await db.insert('notifications', notification.toMap());
      _notifications.insert(0, notification);
      notifyListeners();
    } catch (e) {
      print('Error adding notification: $e');
    }
  }

  Future<void> markAsRead(String notificationId) async {
    try {
      final db = await DatabaseHelper.instance.database;
      await db.update(
        'notifications',
        {'isRead': 1},
        where: 'id = ?',
        whereArgs: [notificationId],
      );

      final index = _notifications.indexWhere((n) => n.id == notificationId);
      if (index != -1) {
        _notifications[index] = AppNotification(
          id: _notifications[index].id,
          title: _notifications[index].title,
          message: _notifications[index].message,
          timestamp: _notifications[index].timestamp,
          isRead: true,
          userId: _notifications[index].userId,
        );
        notifyListeners();
      }
    } catch (e) {
      print('Error marking notification as read: $e');
    }
  }

  Future<void> deleteNotification(String notificationId) async {
    try {
      final db = await DatabaseHelper.instance.database;
      await db.delete(
        'notifications',
        where: 'id = ?',
        whereArgs: [notificationId],
      );

      _notifications.removeWhere((n) => n.id == notificationId);
      notifyListeners();
    } catch (e) {
      print('Error deleting notification: $e');
    }
  }

  Future<void> clearAllNotifications(String userId) async {
    try {
      final db = await DatabaseHelper.instance.database;
      await db.delete(
        'notifications',
        where: 'userId = ?',
        whereArgs: [userId],
      );

      _notifications.clear();
      notifyListeners();
    } catch (e) {
      print('Error clearing notifications: $e');
    }
  }
}
