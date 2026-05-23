---
name: architecture-and-coding-standards
description: Unified coding standards, project folder boundaries, database migration protocols, serialization rules, and clean logging conventions for the CashFlow codebase.
---

# Architecture & Coding Standards Guidelines

This skill enforces technical consistency across all contributors and feature expansions in the CashFlow app. Follow these rules unconditionally.

---

## 1. Directory Structure & Boundaries

The codebase is organized into highly isolated functional layers under `/lib`. Never mix responsibilities between these folders.

### Folder Mapping

*   `lib/models/`: pure data entities. Exposes models with standard fields, basic validation, and `toMap`/`fromMap` mapping constructors. No business or state mutations are allowed here.
*   `lib/providers/`: reactive business state engines. Listens to actions, updates local variables, interacts with service layer IO operations, and triggers state updates via `notifyListeners()`.
*   `lib/screens/`: user interface screens. Handles capturing input, styling layouts, and rendering data from Providers. Screens must not perform database or file-system reads/writes.
*   `lib/services/`: hardware, IO, and operating system interfaces (e.g., `DatabaseHelper`, `NotificationService`, `HomeWidgetService`, `PdfService`).
*   `lib/utils/`: shared assets including colors (`app_colors.dart`), validators, number/currency formatters, and central constants.
*   `lib/widgets/`: custom UI components (e.g., custom glass-cards, account selectors, lists, and canvas charts).

---

## 2. Model & DB Serialization Standards

Every model class must implement consistent serialization methods to seamlessly persist to SQLite and simplify future server APIs:

```dart
class Account {
  final String id;
  final String name;
  final double balance;

  Account({
    required this.id,
    required this.name,
    required this.balance,
  });

  // Convert to SQLite/JSON Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'balance': balance,
    };
  }

  // Build from SQLite/JSON Map
  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      id: map['id'] as String,
      name: map['name'] as String,
      balance: (map['balance'] as num).toDouble(),
    );
  }
}
```

---

## 3. Database Migration Protocols

When database structures evolve (e.g., adding a new field or a transaction table), you must execute database upgrades gracefully without erasing user data.

1.  **Version Bump**: Increment the database version in `lib/services/database_helper.dart`:
    ```dart
    static const int _databaseVersion = 11; // Bump version by 1
    ```
2.  **Migration Paths**: Implement migrations sequentially in `onUpgrade` inside `DatabaseHelper`:
    ```dart
    Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
      if (oldVersion < 11) {
        await db.execute('ALTER TABLE accounts ADD COLUMN currency TEXT DEFAULT "USD"');
      }
    }
    ```
3.  **Model Sync**: Immediately update corresponding domain models, `fromMap`/`toMap` definitions, and providers to support the new fields.

---

## 4. Code Formatting & Naming Conventions

Strictly adhere to the Dart Style Guide (`dart format`):

*   **Classes & Enums**: `PascalCase` (e.g., `TransactionDetailsScreen`).
*   **Variables, Functions & Parameters**: `camelCase` (e.g., `roundToTwoDecimals`).
*   **Directories, Files & Resources**: `snake_case` (e.g., `database_helper.dart`).
*   **Constants & Static Keys**: `camelCase` (e.g., `largeTransactionThreshold`).
*   **Rules**: Never leave unused imports, wildcards, or dead variables. The codebase must compile cleanly under the project's `analysis_options.yaml` constraints.

---

## 5. Structured Logging & Debugging

*   **No print Statements**: Never use raw `print()` statements in production code, as they can leak sensitive financial transactions to system console logs.
*   **Production Logger**: Use structural snackbars, logging providers, or specialized wrappers to handle system logs:
    ```dart
    import 'dart:developer' as developer;

    void logSystemError(String message, Object error, StackTrace stackTrace) {
      developer.log(
        message,
        name: 'com.example.cashflow_app',
        error: error,
        stackTrace: stackTrace,
      );
    }
    ```
