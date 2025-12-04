import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;
  static String? dbNameOverride;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    // print('Initializing Database...');
    _database = await _initDB(dbNameOverride ?? 'cashflow_v4.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final path = filePath == inMemoryDatabasePath
        ? inMemoryDatabasePath
        : join(await getDatabasesPath(), filePath);
    // print('Database path: $path');

    return await openDatabase(
      path,
      version: 10,
      onCreate: _createDB,
      onUpgrade: _onUpgrade,
    );
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Add notifications table
      const idType = 'TEXT PRIMARY KEY';
      const textType = 'TEXT NOT NULL';
      const boolType = 'INTEGER NOT NULL';

      await db.execute('''
CREATE TABLE notifications ( 
  id $idType, 
  title $textType,
  message $textType,
  timestamp $textType,
  isRead $boolType,
  userId $textType
  )
''');
    }

    if (oldVersion < 3) {
      const idType = 'TEXT PRIMARY KEY';
      const textType = 'TEXT NOT NULL';
      const doubleType = 'REAL NOT NULL';
      const intType = 'INTEGER NOT NULL';

      // 1. Create accounts table
      await db.execute('''
CREATE TABLE accounts (
  id $idType,
  name $textType,
  type $textType,
  balance $doubleType,
  color $intType,
  icon $intType
)
''');

      // 2. Create default Cash account
      final defaultAccountId = DateTime.now().millisecondsSinceEpoch.toString();
      await db.insert('accounts', {
        'id': defaultAccountId,
        'name': 'Cash',
        'type': 'CASH',
        'balance': 0.0,
        'color': 0xFF4CAF50, // Green
        'icon': 0xe3f8, // money_off (placeholder, will be updated)
      });
      // print('Default Cash account created');

      // 3. Add accountId to transactions table
      // SQLite doesn't support adding a column with NOT NULL constraint if it doesn't have a default value
      // So we add it as nullable first, update it, then we could recreate the table but for simplicity we'll keep it nullable or use a default
      await db.execute('ALTER TABLE transactions ADD COLUMN accountId TEXT');
      // print('accountId column added to transactions');

      // 4. Link existing transactions to default account
      await db.update('transactions', {
        'accountId': defaultAccountId,
      }, where: 'accountId IS NULL');
    }

    if (oldVersion < 4) {
      // Add new columns to accounts table
      await db.execute('ALTER TABLE accounts ADD COLUMN bankName TEXT');
      await db.execute('ALTER TABLE accounts ADD COLUMN accountNumber TEXT');
      await db.execute('ALTER TABLE accounts ADD COLUMN loanPrincipal REAL');
      await db.execute('ALTER TABLE accounts ADD COLUMN loanInterestRate REAL');
      await db.execute(
        'ALTER TABLE accounts ADD COLUMN loanTenureMonths INTEGER',
      );
      await db.execute('ALTER TABLE accounts ADD COLUMN loanStartDate TEXT');
      await db.execute('ALTER TABLE accounts ADD COLUMN emiAmount REAL');
      await db.execute(
        'ALTER TABLE accounts ADD COLUMN emisPaid INTEGER DEFAULT 0',
      );
    }

    if (oldVersion < 5) {
      // Add EMI payment day column
      await db.execute('ALTER TABLE accounts ADD COLUMN emiPaymentDay INTEGER');
    }
    if (oldVersion < 6) {
      const idType = 'TEXT PRIMARY KEY';
      const textType = 'TEXT NOT NULL';
      const doubleType = 'REAL NOT NULL';
      const intType = 'INTEGER NOT NULL';
      const boolType = 'INTEGER NOT NULL';

      // 1. Create budgets table
      await db.execute('''
CREATE TABLE budgets (
  id $idType,
  category $textType,
  amount $doubleType,
  period $textType,
  startDate $textType,
  userId $textType
)
''');

      // 2. Create goals table
      await db.execute('''
CREATE TABLE goals (
  id $idType,
  name $textType,
  targetAmount $doubleType,
  currentAmount $doubleType,
  deadline TEXT,
  icon $intType,
  color $intType,
  userId $textType
)
''');

      // 3. Create recurring_transactions table
      await db.execute('''
CREATE TABLE recurring_transactions (
  id $idType,
  title $textType,
  amount $doubleType,
  category $textType,
  frequency $textType,
  nextDueDate $textType,
  isAutoAdd $boolType,
  accountId TEXT,
  userId $textType
)
''');

      // 4. Add tags to transactions table
      await db.execute('ALTER TABLE transactions ADD COLUMN tags TEXT');

      // print('Database migrated to v6 with advanced features tables');
    }

    if (oldVersion < 7) {
      // Add isExpense to recurring_transactions table
      await db.execute(
        'ALTER TABLE recurring_transactions ADD COLUMN isExpense INTEGER DEFAULT 1',
      );
    }
    if (oldVersion < 8) {
      const idType = 'TEXT PRIMARY KEY';
      const textType = 'TEXT NOT NULL';
      const intType = 'INTEGER NOT NULL';

      // Create tags table
      await db.execute('''
CREATE TABLE tags (
  id $idType,
  name $textType,
  color $intType,
  userId $textType
)
''');
    }

    if (oldVersion < 9) {
      // Add currency to users table
      await db.execute(
        "ALTER TABLE users ADD COLUMN currency TEXT DEFAULT '₹'",
      );
    }

    if (oldVersion < 10) {
      // Add paymentMode to transactions table
      await db.execute(
        "ALTER TABLE transactions ADD COLUMN paymentMode TEXT DEFAULT 'Cash'",
      );
    }
  }

  Future _createDB(Database db, int version) async {
    const idType = 'TEXT PRIMARY KEY';
    const textType = 'TEXT NOT NULL';
    const doubleType = 'REAL NOT NULL';
    const boolType = 'INTEGER NOT NULL';
    const intType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE users ( 
  id $idType, 
  firstName $textType,
  lastName $textType,
  username $textType,
  password $textType,
  currency TEXT DEFAULT '₹'
  )
''');
    // print('Users table created');

    await db.execute('''
CREATE TABLE accounts (
  id $idType,
  name $textType,
  type $textType,
  balance $doubleType,
  color $intType,
  icon $intType,
  bankName TEXT,
  accountNumber TEXT,
  loanPrincipal REAL,
  loanInterestRate REAL,
  loanTenureMonths INTEGER,
  loanStartDate TEXT,
  emiAmount REAL,
  emisPaid INTEGER DEFAULT 0,
  emiPaymentDay INTEGER
)
''');
    // print('Accounts table created');

    await db.execute('''
CREATE TABLE transactions ( 
  id $idType, 
  title $textType,
  amount $doubleType,
  date $textType,
  isExpense $boolType,
  category $textType,
  userId $textType,
  accountId $textType,
  tags TEXT,
  paymentMode TEXT DEFAULT 'Cash',
  FOREIGN KEY (userId) REFERENCES users (id) ON DELETE CASCADE,
  FOREIGN KEY (accountId) REFERENCES accounts (id) ON DELETE CASCADE
  )
''');
    // print('Transactions table created');

    await db.execute('''
CREATE TABLE budgets (
  id $idType,
  category $textType,
  amount $doubleType,
  period $textType,
  startDate $textType,
  userId $textType
)
''');
    // print('Budgets table created');

    await db.execute('''
CREATE TABLE goals (
  id $idType,
  name $textType,
  targetAmount $doubleType,
  currentAmount $doubleType,
  deadline TEXT,
  icon $intType,
  color $intType,
  userId $textType
)
''');
    // print('Goals table created');

    await db.execute('''
CREATE TABLE recurring_transactions (
  id $idType,
  title $textType,
  amount $doubleType,
  category $textType,
  frequency $textType,
  nextDueDate $textType,
  isAutoAdd $boolType,
  accountId TEXT,
  userId $textType,
  isExpense $boolType
)
''');

    await db.execute('''
CREATE TABLE notifications ( 
  id $idType, 
  title $textType,
  message $textType,
  timestamp $textType,
  isRead $boolType,
  userId $textType
  )
''');
    // print('Notifications table created');

    await db.execute('''
CREATE TABLE tags (
  id $idType,
  name $textType,
  color $intType,
  userId $textType
)
''');
    // print('Tags table created');
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }

  Future<void> deleteDB() async {
    try {
      final dbPath = await getDatabasesPath();
      final dbName = dbNameOverride ?? 'cashflow_v4.db';
      final path = join(dbPath, dbName);

      // Close existing connection if open
      if (_database != null) {
        await _database!.close();
        _database = null;
      }

      // if (dbName != ':memory:') {
      //   await deleteDatabase(path);
      // }
      await deleteDatabase(path);
    } catch (e) {
      // debugPrint('Error clearing database: $e');
    }
  }
}
