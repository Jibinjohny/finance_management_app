import 'package:flutter/material.dart';
import '../models/insight.dart';

import 'transaction_provider.dart';

class InsightsProvider with ChangeNotifier {
  List<Insight> _insights = [];
  TransactionProvider? _transactionProvider;

  List<Insight> get insights => [..._insights];

  void setTransactionProvider(TransactionProvider? provider) {
    _transactionProvider = provider;
    if (provider != null) {
      generateInsights();
    }
  }

  void generateInsights() {
    if (_transactionProvider == null) return;

    final transactions = _transactionProvider!.transactions;
    if (transactions.isEmpty) {
      _insights = [];
      notifyListeners();
      return;
    }

    final List<Insight> newInsights = [];

    // 1. High Spending Alert
    final now = DateTime.now();
    final currentMonth = DateTime(now.year, now.month);
    final currentMonthTransactions = transactions.where((t) {
      return t.date.year == currentMonth.year &&
          t.date.month == currentMonth.month &&
          t.isExpense;
    }).toList();

    double totalExpense = 0;
    for (var t in currentMonthTransactions) {
      totalExpense += t.amount;
    }

    if (totalExpense > 0) {
      // Find top category
      final Map<String, double> categoryTotals = {};
      for (var t in currentMonthTransactions) {
        categoryTotals[t.category] =
            (categoryTotals[t.category] ?? 0) + t.amount;
      }

      if (categoryTotals.isNotEmpty) {
        final topCategory = categoryTotals.entries.reduce(
          (a, b) => a.value > b.value ? a : b,
        );

        if (topCategory.value > totalExpense * 0.4) {
          newInsights.add(
            Insight(
              title: 'High Spending in ${topCategory.key}',
              message:
                  'You spent ${(topCategory.value / totalExpense * 100).toStringAsFixed(0)}% of your monthly expenses on ${topCategory.key}.',
              type: InsightType.warning,
              icon: Icons.warning_amber_rounded,
            ),
          );
        }
      }
    }

    // 2. Income vs Expense
    final currentMonthIncome = transactions
        .where((t) {
          return t.date.year == currentMonth.year &&
              t.date.month == currentMonth.month &&
              !t.isExpense;
        })
        .fold(0.0, (sum, t) => sum + t.amount);

    if (totalExpense > currentMonthIncome && currentMonthIncome > 0) {
      newInsights.add(
        Insight(
          title: 'Overspending Alert',
          message: 'You have spent more than you earned this month.',
          type: InsightType.warning,
          icon: Icons.trending_down,
        ),
      );
    } else if (currentMonthIncome > 0 &&
        totalExpense < currentMonthIncome * 0.5) {
      newInsights.add(
        Insight(
          title: 'Great Savings!',
          message: 'You have saved more than 50% of your income this month.',
          type: InsightType.success,
          icon: Icons.thumb_up,
        ),
      );
    }

    // 3. Subscription Detection (Simple Logic: Same amount, same day, different months)
    // This is complex to implement efficiently here, skipping for now.

    // 4. General Tip
    if (newInsights.isEmpty) {
      newInsights.add(
        Insight(
          title: 'Keep Tracking',
          message:
              'Regularly tracking your expenses is the first step to financial freedom.',
          type: InsightType.info,
          icon: Icons.lightbulb_outline,
        ),
      );
    }

    _insights = newInsights;
    notifyListeners();
  }
}
