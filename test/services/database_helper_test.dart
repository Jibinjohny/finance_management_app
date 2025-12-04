import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:cashflow_app/services/database_helper.dart';

void main() {
  // Setup sqflite_common_ffi for testing
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    DatabaseHelper.dbNameOverride = inMemoryDatabasePath;
  });

  group('DatabaseHelper Tests', () {
    late DatabaseHelper dbHelper;

    setUp(() async {
      dbHelper = DatabaseHelper.instance;
      // Ensure we start with a clean state
      await dbHelper.deleteDB();
    });

    tearDown(() async {
      await dbHelper.close();
    });

    test('database getter should initialize database', () async {
      final db = await dbHelper.database;
      expect(db.isOpen, true);
    });

    test('should create all required tables', () async {
      final db = await dbHelper.database;

      final tables = await db.query(
        'sqlite_master',
        where: 'type = ?',
        whereArgs: ['table'],
      );
      final tableNames = tables.map((t) => t['name'] as String).toList();

      expect(tableNames, contains('users'));
      expect(tableNames, contains('transactions'));
      expect(tableNames, contains('notifications'));
    });

    test('users table should have correct columns', () async {
      final db = await dbHelper.database;
      final columns = await db.rawQuery('PRAGMA table_info(users)');
      final columnNames = columns.map((c) => c['name'] as String).toList();

      expect(columnNames, contains('id'));
      expect(columnNames, contains('firstName'));
      expect(columnNames, contains('lastName'));
      expect(columnNames, contains('username'));
      expect(columnNames, contains('password'));
    });

    test('transactions table should have correct columns', () async {
      final db = await dbHelper.database;
      final columns = await db.rawQuery('PRAGMA table_info(transactions)');
      final columnNames = columns.map((c) => c['name'] as String).toList();

      expect(columnNames, contains('id'));
      expect(columnNames, contains('title'));
      expect(columnNames, contains('amount'));
      expect(columnNames, contains('date'));
      expect(columnNames, contains('isExpense'));
      expect(columnNames, contains('category'));
      expect(columnNames, contains('userId'));
    });

    test('notifications table should have correct columns', () async {
      final db = await dbHelper.database;
      final columns = await db.rawQuery('PRAGMA table_info(notifications)');
      final columnNames = columns.map((c) => c['name'] as String).toList();

      expect(columnNames, contains('id'));
      expect(columnNames, contains('title'));
      expect(columnNames, contains('message'));
      expect(columnNames, contains('timestamp'));
      expect(columnNames, contains('isRead'));
      expect(columnNames, contains('userId'));
    });
  });
}
