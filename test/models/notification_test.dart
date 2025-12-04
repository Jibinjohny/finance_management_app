import 'package:flutter_test/flutter_test.dart';
import 'package:cashflow_app/models/notification.dart';

void main() {
  group('AppNotification Model Tests', () {
    final testDate = DateTime(2023, 5, 15, 10, 30);
    final notification = AppNotification(
      id: 'n1',
      title: 'Alert',
      message: 'This is a test notification',
      timestamp: testDate,
      isRead: false,
      userId: 'u1',
    );

    test('should create a valid AppNotification instance', () {
      expect(notification.id, 'n1');
      expect(notification.title, 'Alert');
      expect(notification.message, 'This is a test notification');
      expect(notification.timestamp, testDate);
      expect(notification.isRead, false);
      expect(notification.userId, 'u1');
    });

    test('toMap should return a valid map', () {
      final map = notification.toMap();

      expect(map['id'], 'n1');
      expect(map['title'], 'Alert');
      expect(map['message'], 'This is a test notification');
      expect(map['timestamp'], testDate.toIso8601String());
      expect(map['isRead'], 0); // stored as int in SQLite
      expect(map['userId'], 'u1');
    });

    test('fromMap should return a valid AppNotification object', () {
      final map = {
        'id': 'n1',
        'title': 'Alert',
        'message': 'This is a test notification',
        'timestamp': testDate.toIso8601String(),
        'isRead': 0,
        'userId': 'u1',
      };

      final result = AppNotification.fromMap(map);

      expect(result.id, notification.id);
      expect(result.title, notification.title);
      expect(result.message, notification.message);
      expect(result.timestamp, notification.timestamp);
      expect(result.isRead, notification.isRead);
      expect(result.userId, notification.userId);
    });

    test('fromMap should handle isRead as 1 correctly', () {
      final map = {
        'id': 'n1',
        'title': 'Alert',
        'message': 'This is a test notification',
        'timestamp': testDate.toIso8601String(),
        'isRead': 1,
        'userId': 'u1',
      };

      final result = AppNotification.fromMap(map);
      expect(result.isRead, true);
    });
  });
}
