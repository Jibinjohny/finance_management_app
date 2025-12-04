import 'package:cashflow_app/models/transaction.dart';
import 'package:cashflow_app/providers/transaction_provider.dart';
import 'package:cashflow_app/services/database_helper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart' hide Transaction;

void main() {
  late TransactionProvider transactionProvider;
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

    // Create a user first as foreign key constraint exists
    await db.insert('users', {
      'id': userId,
      'firstName': 'Test',
      'lastName': 'User',
      'username': 'testuser',
      'password': 'password',
    });

    transactionProvider = TransactionProvider();
    transactionProvider.setUserId(userId);
  });

  tearDown(() async {
    await dbHelper.close();
  });

  group('TransactionProvider Tests', () {
    final tx1 = Transaction(
      id: 't1',
      title: 'Salary',
      amount: 5000.0,
      date: DateTime(2023, 5, 1),
      isExpense: false,
      category: 'Income',
      userId: userId,
    );

    final tx2 = Transaction(
      id: 't2',
      title: 'Groceries',
      amount: 150.0,
      date: DateTime(2023, 5, 2),
      isExpense: true,
      category: 'Food',
      userId: userId,
    );

    test('Initial state should be empty', () {
      expect(transactionProvider.transactions, isEmpty);
      expect(transactionProvider.totalBalance, 0.0);
    });

    test('addTransaction should add to list and database', () async {
      await transactionProvider.addTransaction(tx1);

      expect(transactionProvider.transactions.length, 1);
      expect(transactionProvider.transactions.first.id, tx1.id);
      expect(transactionProvider.totalBalance, 5000.0);
    });

    test('deleteTransaction should remove from list and database', () async {
      await transactionProvider.addTransaction(tx1);
      await transactionProvider.deleteTransaction(tx1.id);

      expect(transactionProvider.transactions, isEmpty);
      expect(transactionProvider.totalBalance, 0.0);
    });

    test('Calculations should be correct', () async {
      await transactionProvider.addTransaction(tx1); // +5000
      await transactionProvider.addTransaction(tx2); // -150

      expect(transactionProvider.totalIncome, 5000.0);
      expect(transactionProvider.totalExpense, 150.0);
      expect(transactionProvider.totalBalance, 4850.0);
    });

    test('recentTransactions should return sorted list limited to 5', () async {
      // Add 6 transactions with different dates
      for (int i = 1; i <= 6; i++) {
        await transactionProvider.addTransaction(
          Transaction(
            id: 'tx$i',
            title: 'Tx $i',
            amount: 100.0,
            date: DateTime(2023, 5, i),
            isExpense: true,
            category: 'Test',
            userId: userId,
          ),
        );
      }

      final recent = transactionProvider.recentTransactions;

      expect(recent.length, 5);
      // Should be sorted descending by date (latest first)
      expect(recent.first.id, 'tx6');
      expect(recent.last.id, 'tx2');
    });

    test('transactionsByMonth should group correctly', () async {
      await transactionProvider.addTransaction(
        Transaction(
          id: 'may1',
          title: 'May Tx',
          amount: 100,
          date: DateTime(2023, 5, 1),
          isExpense: true,
          category: 'Test',
          userId: userId,
        ),
      );

      await transactionProvider.addTransaction(
        Transaction(
          id: 'june1',
          title: 'June Tx',
          amount: 200,
          date: DateTime(2023, 6, 1),
          isExpense: true,
          category: 'Test',
          userId: userId,
        ),
      );

      final grouped = transactionProvider.transactionsByMonth;

      expect(grouped.keys.length, 2);
      expect(grouped.containsKey('2023-05'), true);
      expect(grouped.containsKey('2023-06'), true);
      expect(grouped['2023-05']!.length, 1);
    });

    test('getCategoryBreakdown should calculate correctly', () async {
      await transactionProvider.addTransaction(
        Transaction(
          id: 't1',
          title: 'Food 1',
          amount: 100,
          date: DateTime(2023, 5, 1),
          isExpense: true,
          category: 'Food',
          userId: userId,
        ),
      );

      await transactionProvider.addTransaction(
        Transaction(
          id: 't2',
          title: 'Food 2',
          amount: 50,
          date: DateTime(2023, 5, 2),
          isExpense: true,
          category: 'Food',
          userId: userId,
        ),
      );

      await transactionProvider.addTransaction(
        Transaction(
          id: 't3',
          title: 'Transport',
          amount: 30,
          date: DateTime(2023, 5, 3),
          isExpense: true,
          category: 'Transport',
          userId: userId,
        ),
      );

      final breakdown = transactionProvider.getCategoryBreakdown(
        monthKey: '2024-03',
      );

      expect(breakdown['Food'], 150.0);
      expect(breakdown['Transport'], 30.0);
    });
  });
}
