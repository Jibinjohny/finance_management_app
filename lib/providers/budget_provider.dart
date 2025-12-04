import 'package:flutter/material.dart';
import '../models/budget.dart';
import '../models/transaction.dart';
import '../services/database_helper.dart';

class BudgetProvider with ChangeNotifier {
  List<Budget> _budgets = [];
  String? _userId;

  List<Budget> get budgets => _budgets;

  void setUserId(String? id) {
    _userId = id;
    if (_userId != null) {
      fetchBudgets();
    } else {
      _budgets = [];
      notifyListeners();
    }
  }

  Future<void> fetchBudgets() async {
    if (_userId == null) return;

    final db = await DatabaseHelper.instance.database;
    final result = await db.query(
      'budgets',
      where: 'userId = ?',
      whereArgs: [_userId],
    );

    _budgets = result.map((json) => Budget.fromMap(json)).toList();
    notifyListeners();
  }

  Future<void> addBudget(Budget budget) async {
    final db = await DatabaseHelper.instance.database;
    await db.insert('budgets', budget.toMap());
    await fetchBudgets();
  }

  Future<void> updateBudget(Budget budget) async {
    final db = await DatabaseHelper.instance.database;
    await db.update(
      'budgets',
      budget.toMap(),
      where: 'id = ?',
      whereArgs: [budget.id],
    );
    await fetchBudgets();
  }

  Future<void> deleteBudget(String id) async {
    final db = await DatabaseHelper.instance.database;
    await db.delete('budgets', where: 'id = ?', whereArgs: [id]);
    await fetchBudgets();
  }

  double calculateSpent(Budget budget, List<Transaction> transactions) {
    final now = DateTime.now();
    DateTime start;
    DateTime end;

    if (budget.period == 'monthly') {
      start = DateTime(now.year, now.month, 1);
      end = DateTime(now.year, now.month + 1, 0, 23, 59, 59);
    } else {
      // Yearly
      start = DateTime(now.year, 1, 1);
      end = DateTime(now.year, 12, 31, 23, 59, 59);
    }

    return transactions
        .where(
          (tx) =>
              tx.isExpense &&
              tx.category == budget.category &&
              tx.date.isAfter(start.subtract(Duration(seconds: 1))) &&
              tx.date.isBefore(end.add(Duration(seconds: 1))),
        )
        .fold(0.0, (sum, tx) => sum + tx.amount);
  }

  double getProgress(Budget budget, List<Transaction> transactions) {
    final spent = calculateSpent(budget, transactions);
    if (budget.amount == 0) return 0.0;
    return (spent / budget.amount).clamp(
      0.0,
      1.0,
    ); // Cap at 1.0 for progress bar
  }
}
