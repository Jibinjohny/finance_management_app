import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../services/database_helper.dart';
import '../services/home_widget_service.dart';
import '../services/notification_service.dart';
import 'account_provider.dart';
import 'notification_provider.dart';

class TransactionProvider with ChangeNotifier {
  List<Transaction> _transactions = [];
  String? _userId;
  String _currencySymbol = '₹';

  AccountProvider? _accountProvider;
  NotificationProvider? _notificationProvider;

  static const double LARGE_TRANSACTION_THRESHOLD = 5000.0;

  List<Transaction> get transactions {
    return [..._transactions];
  }

  List<Transaction> get recentTransactions {
    final recent = [..._transactions];
    recent.sort((a, b) => b.date.compareTo(a.date));
    return recent.take(5).toList();
  }

  double get totalBalance {
    return totalIncome - totalExpense;
  }

  double get totalIncome {
    return _transactions
        .where((tx) => !tx.isExpense && tx.category != 'Savings')
        .fold(0.0, (sum, item) => sum + item.amount);
  }

  double get totalExpense {
    return _transactions
        .where((tx) => tx.isExpense && tx.category != 'Savings')
        .fold(0.0, (sum, item) => sum + item.amount);
  }

  void setAccountProvider(AccountProvider provider) {
    _accountProvider = provider;
  }

  void setNotificationProvider(NotificationProvider provider) {
    _notificationProvider = provider;
  }

  void setUserId(String? userId) {
    _userId = userId;
    if (userId != null) {
      fetchTransactions();
    } else {
      _transactions = [];
      notifyListeners();
    }
  }

  void setCurrency(String symbol) {
    _currencySymbol = symbol;
    notifyListeners();
  }

  Future<void> fetchTransactions() async {
    if (_userId == null) return;

    final db = await DatabaseHelper.instance.database;
    final maps = await db.query(
      'transactions',
      where: 'userId = ?',
      whereArgs: [_userId],
    );

    _transactions = maps.map((map) => Transaction.fromMap(map)).toList();
    _notifyListeners();
  }

  void _notifyListeners() {
    notifyListeners();
    HomeWidgetService.updateData(
      income: totalIncome,
      expense: totalExpense,
      transactions: _transactions,
      currencySymbol: _currencySymbol,
    );
  }

  Future<void> addTransaction(Transaction transaction) async {
    if (_userId == null) return;

    // Create transaction with proper userId
    final txWithUserId = Transaction(
      id: transaction.id,
      title: transaction.title,
      amount: transaction.amount,
      date: transaction.date,
      isExpense: transaction.isExpense,
      category: transaction.category,
      userId: _userId!,
      accountId: transaction.accountId,
      tags: transaction.tags,
      paymentMode: transaction.paymentMode,
    );

    final db = await DatabaseHelper.instance.database;
    await db.insert('transactions', txWithUserId.toMap());
    _transactions.add(txWithUserId);
    notifyListeners();

    // Update Account Balance
    if (transaction.accountId != null && _accountProvider != null) {
      await _accountProvider!.updateAccountBalance(
        transaction.accountId!,
        transaction.amount,
        transaction.isExpense,
      );
    }

    // Check for large transaction
    if (transaction.amount >= LARGE_TRANSACTION_THRESHOLD) {
      if (_notificationProvider != null && _userId != null) {
        await _notificationProvider!.addNotification(
          userId: _userId!,
          title: 'Large Transaction Alert',
          message:
              'A large transaction of $_currencySymbol${transaction.amount.toStringAsFixed(2)} was recorded.',
        );
      }

      await NotificationService().showInstantNotification(
        title: 'Large Transaction Alert',
        body:
            'A large transaction of $_currencySymbol${transaction.amount.toStringAsFixed(2)} was recorded.',
      );
    }
  }

  Future<void> deleteTransaction(String id) async {
    final txToDelete = _transactions.firstWhere((tx) => tx.id == id);

    final db = await DatabaseHelper.instance.database;
    await db.delete('transactions', where: 'id = ?', whereArgs: [id]);

    _transactions.removeWhere((tx) => tx.id == id);
    notifyListeners();

    // Revert Account Balance
    if (txToDelete.accountId != null && _accountProvider != null) {
      // If it was an expense, we add it back (so isExpense=false for update)
      // If it was income, we subtract it (so isExpense=true for update)
      await _accountProvider!.updateAccountBalance(
        txToDelete.accountId!,
        txToDelete.amount,
        !txToDelete.isExpense,
      );
    }
  }

  /// Deletes all transactions associated with a specific account
  /// Returns the number of transactions deleted
  Future<int> deleteTransactionsByAccountId(String accountId) async {
    final transactionsToDelete = _transactions
        .where((tx) => tx.accountId == accountId)
        .toList();

    final count = transactionsToDelete.length;

    if (count > 0) {
      final db = await DatabaseHelper.instance.database;
      await db.delete(
        'transactions',
        where: 'accountId = ?',
        whereArgs: [accountId],
      );

      _transactions.removeWhere((tx) => tx.accountId == accountId);
      _notifyListeners();
    }

    return count;
  }

  // Monthly Report Logic
  Map<String, List<Transaction>> get transactionsByMonth {
    Map<String, List<Transaction>> grouped = {};

    for (var tx in _transactions) {
      String monthKey =
          '${tx.date.year}-${tx.date.month.toString().padLeft(2, '0')}';
      if (!grouped.containsKey(monthKey)) {
        grouped[monthKey] = [];
      }
      grouped[monthKey]!.add(tx);
    }
    return grouped;
  }

  double getMonthlyIncome(String monthKey) {
    final monthlyTx = transactionsByMonth[monthKey] ?? [];
    return monthlyTx
        .where((tx) => !tx.isExpense && tx.category != 'Savings')
        .fold(0.0, (sum, item) => sum + item.amount);
  }

  double getMonthlyExpense(String monthKey) {
    final monthlyTx = transactionsByMonth[monthKey] ?? [];
    return monthlyTx
        .where((tx) => tx.isExpense && tx.category != 'Savings')
        .fold(0.0, (sum, item) => sum + item.amount);
  }

  Map<String, double> get topExpenses {
    final Map<String, double> breakdown = {};
    final expenses = _transactions.where(
      (tx) => tx.isExpense && tx.category != 'Savings',
    );

    for (var tx in expenses) {
      if (!breakdown.containsKey(tx.category)) {
        breakdown[tx.category] = 0.0;
      }
      breakdown[tx.category] = breakdown[tx.category]! + tx.amount;
    }

    final sortedEntries = breakdown.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    final Map<String, double> top5 = {};
    for (var i = 0; i < sortedEntries.length && i < 5; i++) {
      top5[sortedEntries[i].key] = sortedEntries[i].value;
    }
    return top5;
  }

  double getAccountIncome(String accountId) {
    return _transactions
        .where(
          (tx) =>
              tx.accountId == accountId &&
              !tx.isExpense &&
              tx.category != 'Savings',
        )
        .fold(0.0, (sum, item) => sum + item.amount);
  }

  double getAccountExpense(String accountId) {
    return _transactions
        .where(
          (tx) =>
              tx.accountId == accountId &&
              tx.isExpense &&
              tx.category != 'Savings',
        )
        .fold(0.0, (sum, item) => sum + item.amount);
  }

  // Flexible Filtering Methods
  List<Transaction> getFilteredTransactions({
    String? accountId,
    String? monthKey,
    List<String>? tagIds,
  }) {
    return _transactions.where((tx) {
      bool matchesAccount = accountId == null || tx.accountId == accountId;
      bool matchesMonth = true;
      if (monthKey != null) {
        final txMonthKey =
            '${tx.date.year}-${tx.date.month.toString().padLeft(2, '0')}';
        matchesMonth = txMonthKey == monthKey;
      }
      bool matchesTags = true;
      if (tagIds != null && tagIds.isNotEmpty) {
        matchesTags = tagIds.any((tagId) => tx.tags.contains(tagId));
      }
      return matchesAccount && matchesMonth && matchesTags;
    }).toList();
  }

  double getIncome({String? accountId, String? monthKey}) {
    return getFilteredTransactions(accountId: accountId, monthKey: monthKey)
        .where((tx) => !tx.isExpense && tx.category != 'Savings')
        .fold(0.0, (sum, item) => sum + item.amount);
  }

  double getExpense({String? accountId, String? monthKey}) {
    return getFilteredTransactions(accountId: accountId, monthKey: monthKey)
        .where((tx) => tx.isExpense && tx.category != 'Savings')
        .fold(0.0, (sum, item) => sum + item.amount);
  }

  Map<String, double> getCategoryBreakdown({
    String? accountId,
    String? monthKey,
  }) {
    final filteredTx = getFilteredTransactions(
      accountId: accountId,
      monthKey: monthKey,
    );
    final Map<String, double> breakdown = {};

    for (var tx in filteredTx) {
      if (tx.isExpense && tx.category != 'Savings') {
        if (!breakdown.containsKey(tx.category)) {
          breakdown[tx.category] = 0.0;
        }
        breakdown[tx.category] = breakdown[tx.category]! + tx.amount;
      }
    }
    return breakdown;
  }

  Map<String, double> getTagSpendingBreakdown({
    String? accountId,
    String? monthKey,
  }) {
    final filteredTx = getFilteredTransactions(
      accountId: accountId,
      monthKey: monthKey,
    );
    final Map<String, double> breakdown = {};

    for (var tx in filteredTx) {
      if (tx.isExpense && tx.tags.isNotEmpty) {
        for (var tagId in tx.tags) {
          if (!breakdown.containsKey(tagId)) {
            breakdown[tagId] = 0.0;
          }
          breakdown[tagId] = breakdown[tagId]! + tx.amount;
        }
      }
    }
    return breakdown;
  }

  // Financial Trend Data
  List<Map<String, dynamic>> getLast6MonthsData({String? accountId}) {
    final List<Map<String, dynamic>> data = [];
    final now = DateTime.now();

    for (int i = 5; i >= 0; i--) {
      final date = DateTime(now.year, now.month - i, 1);
      final monthKey = '${date.year}-${date.month.toString().padLeft(2, '0')}';

      // Get month name (e.g., "Jan", "Feb")
      const monthNames = [
        '',
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
      final monthName = monthNames[date.month];

      final income = getIncome(accountId: accountId, monthKey: monthKey);
      final expense = getExpense(accountId: accountId, monthKey: monthKey);

      data.add({'month': monthName, 'income': income, 'expense': expense});
    }
    return data;
  }
}
