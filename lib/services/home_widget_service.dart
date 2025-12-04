import 'dart:convert';
import 'package:home_widget/home_widget.dart';
import '../models/transaction.dart';

class HomeWidgetService {
  static const String _androidWidgetProvider = 'HomeWidgetProvider';

  /// Update widget with basic income/expense data and chart data
  static Future<void> updateData({
    required double income,
    required double expense,
    required List<Transaction> transactions,
    required String currencySymbol,
    String viewMode = 'daily', // 'daily' or 'monthly'
  }) async {
    // Basic data
    await HomeWidget.saveWidgetData<String>(
      'income',
      '$currencySymbol${income.toStringAsFixed(2)}',
    );
    await HomeWidget.saveWidgetData<String>(
      'expense',
      '$currencySymbol${expense.toStringAsFixed(2)}',
    );

    // Calculate and save net worth
    final netWorth = income - expense;
    await HomeWidget.saveWidgetData<String>(
      'networth',
      '$currencySymbol${netWorth.toStringAsFixed(2)}',
    );

    // Calculate and save chart data
    final dailyData = _calculateDailyData(transactions);
    final monthlyData = _calculateMonthlyData(transactions);

    await HomeWidget.saveWidgetData<String>(
      'chart_data_daily',
      jsonEncode(dailyData),
    );
    await HomeWidget.saveWidgetData<String>(
      'chart_data_monthly',
      jsonEncode(monthlyData),
    );

    // Calculate totals for current period
    final todayExpense = _getTodayExpense(transactions);
    final monthExpense = _getCurrentMonthExpense(transactions);

    await HomeWidget.saveWidgetData<String>(
      'total_expense_today',
      '$currencySymbol${todayExpense.toStringAsFixed(0)}',
    );
    await HomeWidget.saveWidgetData<String>(
      'total_expense_month',
      '$currencySymbol${monthExpense.toStringAsFixed(0)}',
    );

    // Save max values for chart scaling (as strings to avoid type issues)
    final dailyMax = _getMaxValue(dailyData);
    final monthlyMax = _getMaxValue(monthlyData);

    await HomeWidget.saveWidgetData<String>(
      'max_value_daily',
      dailyMax.toString(),
    );
    await HomeWidget.saveWidgetData<String>(
      'max_value_monthly',
      monthlyMax.toString(),
    );

    // Save current view mode
    await HomeWidget.saveWidgetData<String>('view_mode', viewMode);

    // Update widget
    await HomeWidget.updateWidget(
      name: _androidWidgetProvider,
      iOSName: 'HomeWidget',
      qualifiedAndroidName: 'com.example.cashflow_app.HomeWidgetProvider',
    );
  }

  /// Calculate daily expense data for the last 7 days
  static List<Map<String, dynamic>> _calculateDailyData(
    List<Transaction> transactions,
  ) {
    final now = DateTime.now();
    final last7Days = List.generate(
      7,
      (i) => now.subtract(Duration(days: 6 - i)),
    );

    return last7Days.map((date) {
      final dayTransactions = transactions.where(
        (tx) =>
            tx.date.year == date.year &&
            tx.date.month == date.month &&
            tx.date.day == date.day,
      );

      final expense = dayTransactions
          .where((tx) => tx.isExpense)
          .fold(0.0, (sum, tx) => sum + tx.amount);

      return {
        'label': '${date.day}/${date.month}',
        'value': expense,
        'date': date.toIso8601String(),
      };
    }).toList();
  }

  /// Calculate monthly expense data for the last 6 months
  static List<Map<String, dynamic>> _calculateMonthlyData(
    List<Transaction> transactions,
  ) {
    final now = DateTime.now();
    final last6Months = List.generate(6, (i) {
      final month = now.month - (5 - i);
      final year = now.year + (month <= 0 ? -1 : 0);
      final adjustedMonth = month <= 0 ? month + 12 : month;
      return DateTime(year, adjustedMonth);
    });

    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    return last6Months.map((date) {
      final monthTransactions = transactions.where(
        (tx) => tx.date.year == date.year && tx.date.month == date.month,
      );

      final expense = monthTransactions
          .where((tx) => tx.isExpense)
          .fold(0.0, (sum, tx) => sum + tx.amount);

      return {
        'label': months[date.month - 1],
        'value': expense,
        'date': date.toIso8601String(),
      };
    }).toList();
  }

  /// Get today's total expense
  static double _getTodayExpense(List<Transaction> transactions) {
    final now = DateTime.now();
    return transactions
        .where(
          (tx) =>
              tx.isExpense &&
              tx.date.year == now.year &&
              tx.date.month == now.month &&
              tx.date.day == now.day,
        )
        .fold(0.0, (sum, tx) => sum + tx.amount);
  }

  /// Get current month's total expense
  static double _getCurrentMonthExpense(List<Transaction> transactions) {
    final now = DateTime.now();
    return transactions
        .where(
          (tx) =>
              tx.isExpense &&
              tx.date.year == now.year &&
              tx.date.month == now.month,
        )
        .fold(0.0, (sum, tx) => sum + tx.amount);
  }

  /// Get maximum value from chart data for scaling
  static double _getMaxValue(List<Map<String, dynamic>> data) {
    if (data.isEmpty) return 100.0;

    double max = 0.0;
    for (var item in data) {
      final value = (item['value'] as num).toDouble();
      if (value > max) max = value;
    }

    // Return max with 20% padding, minimum 100
    final result = max == 0 ? 100.0 : max * 1.2;
    return result;
  }

  /// Toggle view mode and update widget
  static Future<void> toggleViewMode() async {
    final currentMode = await HomeWidget.getWidgetData<String>(
      'view_mode',
      defaultValue: 'daily',
    );

    final newMode = currentMode == 'daily' ? 'monthly' : 'daily';

    await HomeWidget.saveWidgetData<String>('view_mode', newMode);

    await HomeWidget.updateWidget(
      name: _androidWidgetProvider,
      iOSName: 'HomeWidget',
      qualifiedAndroidName: 'com.example.cashflow_app.HomeWidgetProvider',
    );
  }
}
