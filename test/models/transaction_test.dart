import 'package:flutter_test/flutter_test.dart';
import 'package:cashflow_app/models/transaction.dart';

void main() {
  group('Transaction Model Tests', () {
    final testDate = DateTime(2023, 5, 15, 10, 30);
    final transaction = Transaction(
      id: 't1',
      title: 'Groceries',
      amount: 150.50,
      date: testDate,
      isExpense: true,
      category: 'Food',
      userId: 'u1',
    );

    test('should create a valid Transaction instance', () {
      expect(transaction.id, 't1');
      expect(transaction.title, 'Groceries');
      expect(transaction.amount, 150.50);
      expect(transaction.date, testDate);
      expect(transaction.isExpense, true);
      expect(transaction.category, 'Food');
      expect(transaction.userId, 'u1');
    });

    test('toMap should return a valid map', () {
      final map = transaction.toMap();

      expect(map['id'], 't1');
      expect(map['title'], 'Groceries');
      expect(map['amount'], 150.50);
      expect(map['date'], testDate.toIso8601String());
      expect(map['isExpense'], 1); // stored as int in SQLite
      expect(map['category'], 'Food');
      expect(map['userId'], 'u1');
    });

    test('fromMap should return a valid Transaction object', () {
      final map = {
        'id': 't1',
        'title': 'Groceries',
        'amount': 150.50,
        'date': testDate.toIso8601String(),
        'isExpense': 1,
        'category': 'Food',
        'userId': 'u1',
      };

      final result = Transaction.fromMap(map);

      expect(result.id, transaction.id);
      expect(result.title, transaction.title);
      expect(result.amount, transaction.amount);
      expect(result.date, transaction.date);
      expect(result.isExpense, transaction.isExpense);
      expect(result.category, transaction.category);
      expect(result.userId, transaction.userId);
    });

    test('fromMap should handle isExpense as 0 correctly', () {
      final map = {
        'id': 't2',
        'title': 'Salary',
        'amount': 5000.0,
        'date': testDate.toIso8601String(),
        'isExpense': 0,
        'category': 'Income',
        'userId': 'u1',
      };

      final result = Transaction.fromMap(map);
      expect(result.isExpense, false);
    });
  });
}
