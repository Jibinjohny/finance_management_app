---
name: flutter-testing
description: Safe automated testing protocols for CashFlow including mocked dependencies, isolated in-memory SQLite configurations, and zero side-effect directives on real user data.
---

# Safe Automated Testing Guidelines

This skill provides absolute directives and detailed structures for writing unit, widget, and integration tests in the CashFlow app without risking any data integrity or corrupting active local databases.

---

## 1. Zero Side-Effect Directive

> [!CAUTION]
> **STRICT SECURITY & SAFETY POLICY:**
> Automated test suites must NEVER write, modify, or delete files in the active app directories (e.g., live databases, configurations, local assets, backups, or secure keychain storage). Doing so can result in user data loss.

### Safety Measures
1. All database-driven test cases must run inside an isolated in-memory database instance.
2. Any service touching disk storage (e.g., `backup_service.dart`, `path_provider`, `shared_preferences`) must be fully mocked.
3. If temporary folders are absolutely required, create and teardown temporary directories using Dart’s `Directory.systemTemp.createTempSync()` inside the test fixture setup/teardown hooks.

---

## 2. In-Memory SQLite Testing (`sqflite_common_ffi`)

To test providers and services that rely on SQLite without touching the production database, utilize `sqflite_common_ffi` in in-memory mode (`:memory:`).

### In-Memory DB Setup Pattern
Implement this database setup pattern in test files under `test/`:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:cashflow_app/services/database_helper.dart';

void main() {
  // Initialize FFI for tests
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  late Database db;

  setUp(() async {
    // Open an in-memory database specifically for this test run
    db = await databaseFactory.openDatabase(
      inMemoryDatabasePath,
      options: OpenDatabaseOptions(
        version: 10, // Must match the active schema version
        onCreate: (db, version) async {
          // Construct schemas locally
          await db.execute('''
            CREATE TABLE accounts (
              id TEXT PRIMARY KEY,
              name TEXT,
              type TEXT,
              balance REAL,
              color INTEGER,
              icon TEXT
            )
          ''');
          // Add remaining tables matching production schemas...
        },
      ),
    );
  });

  tearDown(() async {
    await db.close();
  });

  test('Should perform database insertion safely', () async {
    await db.insert('accounts', {
      'id': 'acc_1',
      'name': 'Test Checking',
      'type': 'bank',
      'balance': 1000.0,
      'color': 0xFF123456,
      'icon': 'account_balance'
    });

    final res = await db.query('accounts');
    expect(res.length, 1);
    expect(res.first['name'], 'Test Checking');
  });
}
```

---

## 3. Mocking Core System Dependencies

Providers often interact with system APIs (e.g., notifications, home widgets, and disk paths). These must be fully mocked to maintain clean, fast, and stable execution.

### Mocking `SharedPreferences`
```dart
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({
      'theme_mode': 'dark',
      'currency': 'USD',
    });
  });
}
```

### Mocking Services with `mockito`
Generate and inject mocks for external adapters:

```dart
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:cashflow_app/services/notification_service.dart';

@GenerateMocks([NotificationService])
void main() {
  // Use mockito generated classes to isolate providers
}
```

---

## 4. Running Test Commands

Ensure you run commands within the workspace context:

*   **Run all tests**:
    ```bash
    flutter test
    ```
*   **Run a specific test file**:
    ```bash
    flutter test test/providers/transaction_provider_test.dart
    ```
*   **Generate coverage reports safely**:
    ```bash
    flutter test --coverage
    ```
