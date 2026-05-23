import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import '../services/database_helper.dart';

class DemoSeeder {
  static Future<void> seedDemoData(String userId, String currencySymbol) async {
    final db = await DatabaseHelper.instance.database;

    // Use a transaction block to maintain database consistency and high-speed seeding
    await db.transaction((txn) async {
      // 1. Clear existing user records to avoid conflicts
      await txn.delete('accounts');
      await txn.delete('transactions', where: 'userId = ?', whereArgs: [userId]);
      await txn.delete('budgets', where: 'userId = ?', whereArgs: [userId]);
      await txn.delete('goals', where: 'userId = ?', whereArgs: [userId]);
      await txn.delete('tags', where: 'userId = ?', whereArgs: [userId]);

      const uuid = Uuid();

      // 2. Seed Beautiful Target Accounts
      final checkingId = uuid.v4();
      final savingsId = uuid.v4();
      final creditCardId = uuid.v4();
      final cashId = uuid.v4();

      // Checking Account
      await txn.insert('accounts', {
        'id': checkingId,
        'name': 'HDFC Checking',
        'type': 'BANK',
        'balance': 3450.00,
        'color': 0xFF6C63FF, // Indigo
        'icon': Icons.account_balance_rounded.codePoint,
      });

      // Savings Account
      await txn.insert('accounts', {
        'id': savingsId,
        'name': 'SBI Savings',
        'type': 'BANK',
        'balance': 14200.00,
        'color': 0xFF03DAC6, // Teal
        'icon': Icons.savings_rounded.codePoint,
      });

      // Credit Card
      await txn.insert('accounts', {
        'id': creditCardId,
        'name': 'Amazon ICICI Card',
        'type': 'CARD',
        'balance': 680.00, // Utilized credit
        'color': 0xFFFF7A00, // Orange accent
        'icon': Icons.credit_card_rounded.codePoint,
      });

      // Cash Wallet
      await txn.insert('accounts', {
        'id': cashId,
        'name': 'Cash Wallet',
        'type': 'CASH',
        'balance': 240.00,
        'color': 0xFF4CAF50, // Emerald Green
        'icon': Icons.payments_rounded.codePoint,
      });

      // 3. Seed Cohesive Category Budgets
      final now = DateTime.now();
      final monthStart = DateTime(now.year, now.month, 1);
      final formatter = DateFormat('yyyy-MM-dd HH:mm:ss');

      await txn.insert('budgets', {
        'id': uuid.v4(),
        'category': 'Food',
        'amount': 450.0,
        'period': 'MONTHLY',
        'startDate': formatter.format(monthStart),
        'userId': userId,
      });

      await txn.insert('budgets', {
        'id': uuid.v4(),
        'category': 'Transport',
        'amount': 200.0,
        'period': 'MONTHLY',
        'startDate': formatter.format(monthStart),
        'userId': userId,
      });

      await txn.insert('budgets', {
        'id': uuid.v4(),
        'category': 'Shopping',
        'amount': 300.0,
        'period': 'MONTHLY',
        'startDate': formatter.format(monthStart),
        'userId': userId,
      });

      // 4. Seed Beautiful Financial Goals
      final laptopDeadline = DateTime(now.year, now.month + 3, 20);
      final tripDeadline = DateTime(now.year + 1, now.month, 15);

      await txn.insert('goals', {
        'id': uuid.v4(),
        'name': 'New MacBook Pro',
        'targetAmount': 1500.0,
        'currentAmount': 750.0,
        'deadline': formatter.format(laptopDeadline),
        'icon': Icons.laptop_mac_rounded.codePoint,
        'color': 0xFF03DAC6,
        'userId': userId,
      });

      await txn.insert('goals', {
        'id': uuid.v4(),
        'name': 'Europe Summer Trip',
        'targetAmount': 5000.0,
        'currentAmount': 2200.0,
        'deadline': formatter.format(tripDeadline),
        'icon': Icons.flight_takeoff_rounded.codePoint,
        'color': 0xFF6C63FF,
        'userId': userId,
      });

      // 5. Seed Category tags
      final tagSalaryId = uuid.v4();
      final tagGroceriesId = uuid.v4();
      final tagFuelId = uuid.v4();
      final tagLeisureId = uuid.v4();

      await txn.insert('tags', {'id': tagSalaryId, 'name': 'Salary', 'color': 0xFF4CAF50, 'userId': userId});
      await txn.insert('tags', {'id': tagGroceriesId, 'name': 'Groceries', 'color': 0xFFFFA726, 'userId': userId});
      await txn.insert('tags', {'id': tagFuelId, 'name': 'Fuel', 'color': 0xFF3F51B5, 'userId': userId});
      await txn.insert('tags', {'id': tagLeisureId, 'name': 'Leisure', 'color': 0xFFE91E63, 'userId': userId});

      // 6. Seed Staggered Dynamic Transactions (Last 30 Days)
      final List<Map<String, dynamic>> mockTx = [
        // Income salary
        {
          'title': 'Monthly Payroll Direct Deposit',
          'amount': 4800.0,
          'date': formatter.format(now.subtract(const Duration(days: 25))),
          'isExpense': 0,
          'category': 'Income',
          'accountId': checkingId,
          'tags': 'Salary',
          'paymentMode': 'Direct Deposit',
        },
        // Rent
        {
          'title': 'Monthly Apartment Rent',
          'amount': 1200.0,
          'date': formatter.format(now.subtract(const Duration(days: 24))),
          'isExpense': 1,
          'category': 'Rent',
          'accountId': checkingId,
          'tags': 'Rent',
          'paymentMode': 'Bank Transfer',
        },
        // Groceries
        {
          'title': 'Weekly Groceries - Walmart',
          'amount': 114.50,
          'date': formatter.format(now.subtract(const Duration(days: 22))),
          'isExpense': 1,
          'category': 'Food',
          'accountId': checkingId,
          'tags': 'Groceries',
          'paymentMode': 'Debit Card',
        },
        // Petrol
        {
          'title': 'Shell Gas Station Fill',
          'amount': 45.00,
          'date': formatter.format(now.subtract(const Duration(days: 20))),
          'isExpense': 1,
          'category': 'Transport',
          'accountId': creditCardId,
          'tags': 'Fuel',
          'paymentMode': 'Credit Card',
        },
        // Dining Out
        {
          'title': 'Sushi Dinner with Friends',
          'amount': 86.40,
          'date': formatter.format(now.subtract(const Duration(days: 18))),
          'isExpense': 1,
          'category': 'Food',
          'accountId': creditCardId,
          'tags': 'Leisure',
          'paymentMode': 'Credit Card',
        },
        // Freelance
        {
          'title': 'Mobile App UI/UX Design Client',
          'amount': 950.0,
          'date': formatter.format(now.subtract(const Duration(days: 16))),
          'isExpense': 0,
          'category': 'Income',
          'accountId': checkingId,
          'tags': 'Freelance',
          'paymentMode': 'Direct Deposit',
        },
        // Electric
        {
          'title': 'Power Grid Electricity Utility',
          'amount': 142.30,
          'date': formatter.format(now.subtract(const Duration(days: 14))),
          'isExpense': 1,
          'category': 'Utilities',
          'accountId': checkingId,
          'tags': 'Utilities',
          'paymentMode': 'Bank Transfer',
        },
        // Subscription
        {
          'title': 'Netflix Standard Multi-screen',
          'amount': 15.99,
          'date': formatter.format(now.subtract(const Duration(days: 12))),
          'isExpense': 1,
          'category': 'Entertainment',
          'accountId': creditCardId,
          'tags': 'Subscription',
          'paymentMode': 'Credit Card',
        },
        // Coffee
        {
          'title': 'Blue Tokai Cappuccino & Muffin',
          'amount': 6.80,
          'date': formatter.format(now.subtract(const Duration(days: 10))),
          'isExpense': 1,
          'category': 'Food',
          'accountId': cashId,
          'tags': 'Leisure',
          'paymentMode': 'Cash',
        },
        // Groceries
        {
          'title': 'Local Organic Farms Market',
          'amount': 94.20,
          'date': formatter.format(now.subtract(const Duration(days: 8))),
          'isExpense': 1,
          'category': 'Food',
          'accountId': cashId,
          'tags': 'Groceries',
          'paymentMode': 'Cash',
        },
        // Uber
        {
          'title': 'Uber ride to Airport Terminal',
          'amount': 34.50,
          'date': formatter.format(now.subtract(const Duration(days: 7))),
          'isExpense': 1,
          'category': 'Transport',
          'accountId': creditCardId,
          'tags': 'Fuel',
          'paymentMode': 'Credit Card',
        },
        // Movie
        {
          'title': 'Cinema 3D IMAX Tickets',
          'amount': 28.00,
          'date': formatter.format(now.subtract(const Duration(days: 5))),
          'isExpense': 1,
          'category': 'Entertainment',
          'accountId': creditCardId,
          'tags': 'Leisure',
          'paymentMode': 'Credit Card',
        },
        // Gym
        {
          'title': 'Gold\'s Gym Monthly Membership',
          'amount': 50.00,
          'date': formatter.format(now.subtract(const Duration(days: 4))),
          'isExpense': 1,
          'category': 'Health',
          'accountId': checkingId,
          'tags': 'Fitness',
          'paymentMode': 'Debit Card',
        },
        // Petrol
        {
          'title': 'Shell Gas Station Fill',
          'amount': 42.00,
          'date': formatter.format(now.subtract(const Duration(days: 3))),
          'isExpense': 1,
          'category': 'Transport',
          'accountId': creditCardId,
          'tags': 'Fuel',
          'paymentMode': 'Credit Card',
        },
        // Dining Out
        {
          'title': 'Gourmet Wood-fired Pizza',
          'amount': 44.80,
          'date': formatter.format(now.subtract(const Duration(days: 2))),
          'isExpense': 1,
          'category': 'Food',
          'accountId': cashId,
          'tags': 'Leisure',
          'paymentMode': 'Cash',
        },
        // Shopping
        {
          'title': 'Ergonomic Desk Footrest - Amazon',
          'amount': 65.00,
          'date': formatter.format(now.subtract(const Duration(days: 1))),
          'isExpense': 1,
          'category': 'Shopping',
          'accountId': creditCardId,
          'tags': 'Shopping',
          'paymentMode': 'Credit Card',
        },
        // Daily Lunch
        {
          'title': 'Subway Club & Drink combo',
          'amount': 12.50,
          'date': formatter.format(now),
          'isExpense': 1,
          'category': 'Food',
          'accountId': cashId,
          'tags': 'Groceries',
          'paymentMode': 'Cash',
        },
      ];

      for (var tx in mockTx) {
        await txn.insert('transactions', {
          'id': uuid.v4(),
          'title': tx['title'],
          'amount': tx['amount'],
          'date': tx['date'],
          'isExpense': tx['isExpense'],
          'category': tx['category'],
          'userId': userId,
          'accountId': tx['accountId'],
          'tags': tx['tags'],
          'paymentMode': tx['paymentMode'],
        });
      }
    });
  }
}
