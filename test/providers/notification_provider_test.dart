import 'package:flutter_test/flutter_test.dart';
import 'package:cashflow_app/providers/notification_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:cashflow_app/services/database_helper.dart';

void main() {
  late NotificationProvider notificationProvider;
  late DatabaseHelper dbHelper;
  final userId = 'test_user_id';

  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    DatabaseHelper.dbNameOverride = inMemoryDatabasePath;
  });

  setUp(() async {
    dbHelper = DatabaseHelper.instance;
    await dbHelper.deleteDB();

    // Re-initialize database
    final db = await dbHelper.database;

    // Create a user first
    await db.insert('users', {
      'id': userId,
      'firstName': 'Test',
      'lastName': 'User',
      'username': 'testuser',
      'password': 'password',
    });

    notificationProvider = NotificationProvider();
  });

  tearDown(() async {
    await dbHelper.close();
  });

  group('NotificationProvider Tests', () {
    test('Initial state should be empty', () {
      expect(notificationProvider.notifications, isEmpty);
      expect(notificationProvider.unreadCount, 0);
    });

    test('addNotification should add to list and database', () async {
      await notificationProvider.addNotification(
        userId: userId,
        title: 'Test Alert',
        message: 'This is a test',
      );

      expect(notificationProvider.notifications.length, 1);
      expect(notificationProvider.notifications.first.title, 'Test Alert');
      expect(notificationProvider.unreadCount, 1);
    });

    test('markAsRead should update status', () async {
      await notificationProvider.addNotification(
        userId: userId,
        title: 'Test Alert',
        message: 'This is a test',
      );

      final notificationId = notificationProvider.notifications.first.id;
      await notificationProvider.markAsRead(notificationId);

      expect(notificationProvider.notifications.first.isRead, true);
      expect(notificationProvider.unreadCount, 0);
    });

    test('deleteNotification should remove from list', () async {
      await notificationProvider.addNotification(
        userId: userId,
        title: 'Test Alert',
        message: 'This is a test',
      );

      final notificationId = notificationProvider.notifications.first.id;
      await notificationProvider.deleteNotification(notificationId);

      expect(notificationProvider.notifications, isEmpty);
    });

    test('clearAllNotifications should remove all for user', () async {
      await notificationProvider.addNotification(
        userId: userId,
        title: 'Alert 1',
        message: 'Test 1',
      );
      await notificationProvider.addNotification(
        userId: userId,
        title: 'Alert 2',
        message: 'Test 2',
      );

      expect(notificationProvider.notifications.length, 2);

      await notificationProvider.clearAllNotifications(userId);

      expect(notificationProvider.notifications, isEmpty);
    });

    test('loadNotifications should fetch from database', () async {
      // Manually insert notification
      await notificationProvider.addNotification(
        userId: userId,
        title: 'Persisted Alert',
        message: 'Test',
      );

      // Create new provider instance
      final newProvider = NotificationProvider();
      await newProvider.loadNotifications(userId);

      expect(newProvider.notifications.length, 1);
      expect(newProvider.notifications.first.title, 'Persisted Alert');
    });
  });
}
