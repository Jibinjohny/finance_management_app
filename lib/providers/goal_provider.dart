import 'package:flutter/material.dart';
import '../models/goal.dart';
import '../services/database_helper.dart';

class GoalProvider with ChangeNotifier {
  List<Goal> _goals = [];
  String? _userId;

  List<Goal> get goals => [..._goals];

  double get totalGoalAmount {
    return _goals.fold(0.0, (sum, goal) => sum + goal.currentAmount);
  }

  void setUserId(String? userId) {
    _userId = userId;
    if (userId != null) {
      fetchGoals();
    } else {
      _goals = [];
      notifyListeners();
    }
  }

  Future<void> fetchGoals() async {
    if (_userId == null) return;

    final db = await DatabaseHelper.instance.database;
    final result = await db.query(
      'goals',
      where: 'userId = ?',
      whereArgs: [_userId],
      orderBy: 'deadline ASC',
    );

    _goals = result.map((json) => Goal.fromMap(json)).toList();
    notifyListeners();
  }

  Future<void> addGoal(Goal goal) async {
    if (_userId == null) return;

    final db = await DatabaseHelper.instance.database;
    await db.insert('goals', goal.toMap());
    _goals.add(goal);
    notifyListeners();
  }

  Future<void> updateGoal(Goal goal) async {
    final db = await DatabaseHelper.instance.database;
    await db.update(
      'goals',
      goal.toMap(),
      where: 'id = ?',
      whereArgs: [goal.id],
    );

    final index = _goals.indexWhere((g) => g.id == goal.id);
    if (index != -1) {
      _goals[index] = goal;
      notifyListeners();
    }
  }

  Future<void> deleteGoal(String id) async {
    final db = await DatabaseHelper.instance.database;
    await db.delete('goals', where: 'id = ?', whereArgs: [id]);

    _goals.removeWhere((g) => g.id == id);
    notifyListeners();
  }

  Future<void> addFunds(
    String goalId,
    double amount,
    String accountId,
    String userId,
  ) async {
    try {
      final index = _goals.indexWhere((g) => g.id == goalId);
      if (index == -1) {
        throw Exception('Goal not found');
      }

      final goal = _goals[index];

      // Create transaction for goal contribution
      final db = await DatabaseHelper.instance.database;
      final transactionId = DateTime.now().millisecondsSinceEpoch.toString();

      await db.insert('transactions', {
        'id': transactionId,
        'amount': amount,
        'category': 'Savings',
        'title': 'Contribution to ${goal.name}',
        'date': DateTime.now().toIso8601String(),
        'isExpense': 1, // true for expense
        'accountId': accountId,
        'userId': userId,
        'tags': '',
      });

      // Update account balance
      final accountResult = await db.query(
        'accounts',
        where: 'id = ?',
        whereArgs: [accountId],
      );

      if (accountResult.isEmpty) {
        throw Exception('Account not found');
      }

      final currentBalance = (accountResult.first['balance'] as num).toDouble();

      if (currentBalance < amount) {
        throw Exception('Insufficient balance');
      }

      await db.update(
        'accounts',
        {'balance': currentBalance - amount},
        where: 'id = ?',
        whereArgs: [accountId],
      );

      // Update goal
      final updatedGoal = Goal(
        id: goal.id,
        name: goal.name,
        targetAmount: goal.targetAmount,
        currentAmount: goal.currentAmount + amount,
        deadline: goal.deadline,
        icon: goal.icon,
        color: goal.color,
        userId: goal.userId,
      );

      await updateGoal(updatedGoal);
    } catch (e) {
      print('Error in addFunds: $e');
      rethrow;
    }
  }

  Future<void> withdrawFunds(
    String goalId,
    double amount,
    String accountId,
    String userId,
  ) async {
    try {
      final index = _goals.indexWhere((g) => g.id == goalId);
      if (index == -1) {
        throw Exception('Goal not found');
      }

      final goal = _goals[index];

      if (goal.currentAmount < amount) {
        throw Exception('Insufficient funds in goal');
      }

      // Create transaction for goal withdrawal
      final db = await DatabaseHelper.instance.database;
      final transactionId = DateTime.now().millisecondsSinceEpoch.toString();

      await db.insert('transactions', {
        'id': transactionId,
        'amount': amount,
        'category': 'Savings',
        'title': 'Withdrawal from ${goal.name}',
        'date': DateTime.now().toIso8601String(),
        'isExpense': 0, // false for income
        'accountId': accountId,
        'userId': userId,
        'tags': '',
      });

      // Update account balance (add money back)
      final accountResult = await db.query(
        'accounts',
        where: 'id = ?',
        whereArgs: [accountId],
      );

      if (accountResult.isEmpty) {
        throw Exception('Account not found');
      }

      final currentBalance = (accountResult.first['balance'] as num).toDouble();
      await db.update(
        'accounts',
        {'balance': currentBalance + amount},
        where: 'id = ?',
        whereArgs: [accountId],
      );

      // Update goal
      final updatedGoal = Goal(
        id: goal.id,
        name: goal.name,
        targetAmount: goal.targetAmount,
        currentAmount: (goal.currentAmount - amount).clamp(
          0.0,
          double.infinity,
        ),
        deadline: goal.deadline,
        icon: goal.icon,
        color: goal.color,
        userId: goal.userId,
      );

      await updateGoal(updatedGoal);
    } catch (e) {
      print('Error in withdrawFunds: $e');
      rethrow;
    }
  }
}
