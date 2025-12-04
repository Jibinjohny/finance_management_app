import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:cashflow_app/providers/account_provider.dart';
import 'package:cashflow_app/models/account.dart';
import 'package:cashflow_app/services/database_helper.dart';

@GenerateMocks([DatabaseHelper])
void main() {
  late AccountProvider accountProvider;
  late DatabaseHelper databaseHelper;

  setUpAll(() {
    // Initialize ffi loader
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  setUp(() async {
    // Use in-memory database for testing
    DatabaseHelper.dbNameOverride = inMemoryDatabasePath;
    databaseHelper = DatabaseHelper.instance;

    // Initialize database
    await databaseHelper.database;

    accountProvider = AccountProvider();
  });

  tearDown(() async {
    await databaseHelper.deleteDB();
  });

  group('AccountProvider Tests', () {
    test('should load accounts initially', () async {
      await accountProvider.loadAccounts();
      // In-memory DB starts fresh with onCreate, no migration
      expect(accountProvider.accounts.length, 0);
    });

    test('should add account correctly', () async {
      await accountProvider.loadAccounts();

      final account = Account(
        id: 'test_id',
        name: 'Test Account',
        type: AccountType.bank,
        balance: 500.0,
        color: 0xFF000000,
        icon: 12345,
      );

      await accountProvider.addAccount(account);

      expect(accountProvider.accounts.length, 1);
      final addedAccount = accountProvider.accounts.firstWhere(
        (a) => a.id == 'test_id',
      );
      expect(addedAccount.name, 'Test Account');
      expect(addedAccount.balance, 500.0);
    });

    test('should update account balance correctly', () async {
      await accountProvider.loadAccounts();

      final account = Account(
        id: 'test_id_2',
        name: 'Test Account 2',
        type: AccountType.bank,
        balance: 1000.0,
        color: 0xFF000000,
        icon: 12345,
      );

      await accountProvider.addAccount(account);

      // Add 500 (Income)
      await accountProvider.updateAccountBalance('test_id_2', 500.0, false);
      var updatedAccount = accountProvider.accounts.firstWhere(
        (a) => a.id == 'test_id_2',
      );
      expect(updatedAccount.balance, 1500.0);

      // Subtract 200 (Expense)
      await accountProvider.updateAccountBalance('test_id_2', 200.0, true);
      updatedAccount = accountProvider.accounts.firstWhere(
        (a) => a.id == 'test_id_2',
      );
      expect(updatedAccount.balance, 1300.0);
    });

    test('should delete account correctly', () async {
      await accountProvider.loadAccounts();

      final account = Account(
        id: 'test_id_3',
        name: 'Test Account 3',
        type: AccountType.bank,
        balance: 1000.0,
        color: 0xFF000000,
        icon: 12345,
      );

      await accountProvider.addAccount(account);
      expect(accountProvider.accounts.any((a) => a.id == 'test_id_3'), true);

      await accountProvider.deleteAccount('test_id_3', null);
      expect(accountProvider.accounts.any((a) => a.id == 'test_id_3'), false);
    });

    test('should calculate total net worth correctly', () async {
      await accountProvider.loadAccounts();

      final account1 = Account(
        id: 'test_id_4',
        name: 'Account 1',
        type: AccountType.bank,
        balance: 1000.0,
        color: 0xFF000000,
        icon: 12345,
      );

      final account2 = Account(
        id: 'test_id_5',
        name: 'Account 2',
        type: AccountType.cash,
        balance: 500.0,
        color: 0xFF000000,
        icon: 12345,
      );

      await accountProvider.addAccount(account1);
      await accountProvider.addAccount(account2);

      expect(accountProvider.totalNetWorth, 1500.0);
    });
  });
}
