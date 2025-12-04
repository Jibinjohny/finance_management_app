import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cashflow_app/providers/transaction_provider.dart';
import 'package:cashflow_app/providers/notification_provider.dart';
import 'package:cashflow_app/models/transaction.dart' as model;
import 'package:cashflow_app/services/database_helper.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart' as sqflite;

// Manual Spy for NotificationProvider
class TestNotificationProvider extends NotificationProvider {
  int addNotificationCallCount = 0;
  String? lastTitle;
  String? lastMessage;

  @override
  Future<void> addNotification({
    required String userId,
    required String title,
    required String message,
  }) async {
    addNotificationCallCount++;
    lastTitle = title;
    lastMessage = message;
    return Future.value();
  }
}

void main() {
  // Initialize binding for platform channels
  TestWidgetsFlutterBinding.ensureInitialized();

  group('TransactionProvider Large Transaction Tests', () {
    late TransactionProvider transactionProvider;
    late TestNotificationProvider testNotificationProvider;

    setUpAll(() {
      // Initialize FFI
      sqflite.sqfliteFfiInit();
      sqflite.databaseFactory = sqflite.databaseFactoryFfi;

      // Use in-memory database
      DatabaseHelper.dbNameOverride = sqflite.inMemoryDatabasePath;

      // Mock HomeWidget Channel
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(const MethodChannel('home_widget'), (
            MethodCall methodCall,
          ) async {
            return null;
          });

      // Mock Local Notifications Channel
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
            const MethodChannel('dexterous.com/flutter/local_notifications'),
            (MethodCall methodCall) async {
              return null;
            },
          );
    });

    setUp(() async {
      // Reset database for each test
      await DatabaseHelper.instance.deleteDB();

      // Create a user and an account to satisfy foreign key constraints
      final db = await DatabaseHelper.instance.database;

      // Insert User
      await db.insert('users', {
        'id': 'test_user_id',
        'firstName': 'Test',
        'lastName': 'User',
        'username': 'testuser',
        'password': 'password',
      });

      // Insert Account
      await db.insert('accounts', {
        'id': 'test_account_id',
        'name': 'Test Account',
        'type': 'CASH',
        'balance': 10000.0,
        'color': 0xFF000000,
        'icon': 0xe000,
      });

      testNotificationProvider = TestNotificationProvider();
      transactionProvider = TransactionProvider();
      transactionProvider.setNotificationProvider(testNotificationProvider);
    });

    test('should trigger notification for transaction >= 5000', () async {
      // Set user ID to enable DB operations
      transactionProvider.setUserId('test_user_id');

      final largeTransaction = model.Transaction(
        id: '1',
        title: 'Large Expense',
        amount: 5000.0,
        date: DateTime.now(),
        isExpense: true,
        category: 'Shopping',
        userId: 'test_user_id',
        accountId: 'test_account_id',
      );

      try {
        await transactionProvider.addTransaction(largeTransaction);
      } catch (e) {
        // Even if it fails (e.g. some other unmocked channel), we want to see if provider was called
      }

      // Verify that addNotification was called
      expect(testNotificationProvider.addNotificationCallCount, 1);
      expect(testNotificationProvider.lastTitle, 'Large Transaction Alert');
      expect(testNotificationProvider.lastMessage, contains('5000.00'));
    });
  });
}
