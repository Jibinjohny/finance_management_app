import 'package:flutter/material.dart';
import '../models/account.dart';
import '../services/database_helper.dart';
import 'transaction_provider.dart';

class AccountProvider with ChangeNotifier {
  List<Account> _accounts = [];
  bool _isLoading = false;

  List<Account> get accounts => _accounts;
  bool get isLoading => _isLoading;

  double get totalNetWorth {
    return _accounts.fold(0, (sum, account) => sum + account.balance);
  }

  // Account type totals
  double get totalBankBalance {
    return _accounts
        .where((a) => a.type == AccountType.bank)
        .fold(0, (sum, account) => sum + account.balance);
  }

  double get totalCashBalance {
    return _accounts
        .where((a) => a.type == AccountType.cash)
        .fold(0, (sum, account) => sum + account.balance);
  }

  double get totalInvestmentBalance {
    return _accounts
        .where((a) => a.type == AccountType.investment)
        .fold(0, (sum, account) => sum + account.balance);
  }

  double get totalLoanBalance {
    return _accounts
        .where((a) => a.type == AccountType.loan)
        .fold(0, (sum, account) => sum + account.remainingLoanBalance);
  }

  // Account type filters
  List<Account> getLoanAccounts() {
    return _accounts.where((a) => a.type == AccountType.loan).toList();
  }

  List<Account> getBankAccounts() {
    return _accounts.where((a) => a.type == AccountType.bank).toList();
  }

  List<Account> getInvestmentAccounts() {
    return _accounts.where((a) => a.type == AccountType.investment).toList();
  }

  List<Account> getCashAccounts() {
    return _accounts.where((a) => a.type == AccountType.cash).toList();
  }

  Future<void> loadAccounts() async {
    _isLoading = true;
    notifyListeners();

    try {
      final db = await DatabaseHelper.instance.database;
      final result = await db.query('accounts');
      _accounts = result.map((e) => Account.fromMap(e)).toList();
    } catch (e) {
      print('Error loading accounts: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addAccount(Account account) async {
    try {
      final db = await DatabaseHelper.instance.database;
      await db.insert('accounts', account.toMap());
      _accounts.add(account);
      notifyListeners();
    } catch (e) {
      print('Error adding account: $e');
      rethrow;
    }
  }

  Future<void> updateAccount(Account account) async {
    try {
      final db = await DatabaseHelper.instance.database;
      await db.update(
        'accounts',
        account.toMap(),
        where: 'id = ?',
        whereArgs: [account.id],
      );
      final index = _accounts.indexWhere((a) => a.id == account.id);
      if (index != -1) {
        _accounts[index] = account;
        notifyListeners();
      }
    } catch (e) {
      print('Error updating account: $e');
      rethrow;
    }
  }

  Future<int> deleteAccount(
    String id,
    TransactionProvider? transactionProvider,
  ) async {
    int deletedTransactionsCount = 0;

    // Delete associated transactions first if provider is available
    if (transactionProvider != null) {
      deletedTransactionsCount = await transactionProvider
          .deleteTransactionsByAccountId(id);
    }

    try {
      final db = await DatabaseHelper.instance.database;
      await db.delete('accounts', where: 'id = ?', whereArgs: [id]);
      _accounts.removeWhere((a) => a.id == id);
      notifyListeners();

      return deletedTransactionsCount;
    } catch (e) {
      print('Error deleting account: $e');
      rethrow;
    }
  }

  Account? getAccountById(String id) {
    try {
      return _accounts.firstWhere((a) => a.id == id);
    } catch (e) {
      return null;
    }
  }

  String getAccountName(String id) {
    final account = getAccountById(id);
    if (account == null) return 'Unknown Account';
    if (account.type == AccountType.bank && account.bankName != null) {
      return '${account.bankName} (${account.name})';
    }
    return account.name;
  }

  Future<void> updateAccountBalance(
    String accountId,
    double amount,
    bool isExpense,
  ) async {
    final account = getAccountById(accountId);
    if (account != null) {
      final newBalance = isExpense
          ? account.balance - amount
          : account.balance + amount;

      final updatedAccount = account.copyWith(balance: newBalance);
      await updateAccount(updatedAccount);
    }
  }

  // Record EMI payment for loan account
  Future<void> recordEmiPayment(String accountId) async {
    final account = getAccountById(accountId);
    if (account != null && account.type == AccountType.loan) {
      final currentEmisPaid = account.emisPaid ?? 0;
      final updatedAccount = account.copyWith(emisPaid: currentEmisPaid + 1);
      await updateAccount(updatedAccount);
    }
  }
}
