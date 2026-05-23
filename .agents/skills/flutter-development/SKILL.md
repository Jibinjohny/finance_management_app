---
name: flutter-development
description: Pro-level Flutter and Dart development guidelines for CashFlow, covering async gaps, Provider state management, HomeWidget integration, and localization workflows.
---

# Flutter Core Development Guidelines

This skill provides comprehensive standards and instructions for building and modifying screens, providers, widgets, and services in the CashFlow app.

---

## 1. Safety in Asynchronous Operations (Async Gaps)

In Flutter, referencing a `BuildContext` after an asynchronous gap (e.g., after `await`) can lead to crashes if the widget is no longer in the widget tree (i.e., unmounted).

### Rule: Always Check `mounted`
Before using `BuildContext` after an `await` statement, check if the state is still active using `mounted`.

```dart
// ❌ INCORRECT - Dangerous after async gap
ElevatedButton(
  onPressed: () async {
    await provider.performAsyncOperation();
    Navigator.of(context).pop(); // Will crash if user navigated away during async operation!
  },
  child: Text("Save"),
);

//  CORRECT - Guarded with mounted check
ElevatedButton(
  onPressed: () async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    await provider.performAsyncOperation();
    
    // Check if the widget is still mounted in the tree
    if (!context.mounted) return;
    
    Navigator.of(context).pop();
    scaffoldMessenger.showSnackBar(
      SnackBar(content: Text("Success!")),
    );
  },
  child: Text("Save"),
);
```

---

## 2. State Wiring and Dependency Tree (`MultiProvider`)

CashFlow uses the `Provider` package for state management. State stores are initialized globally in `lib/main.dart` within a `MultiProvider`.

### Auth Scoping and Proxy Providers
To guarantee data is scoped per-user (local accounts), dependent providers rely on the current logged-in `userId`.
1. When a user logs in, `AuthProvider` updates its state.
2. In `lib/main.dart`, we wire dependent providers (e.g., `TransactionProvider`, `BudgetProvider`, etc.) using `ChangeNotifierProxyProvider`.
3. In these proxy mappings, call `.setUserId(authProvider.currentUserId)` to scope SQLite queries accurately.

> [!IMPORTANT]
> When creating or editing providers, always verify that `userId` is set before executing database transactions to prevent uncategorized or globally visible data leakages.

---

## 3. Dynamic Widget Synchronization (`HomeWidget`)

CashFlow features a home-screen widget configured for both iOS and Android. Whenever transactions are created, modified, or deleted, the home-screen widget must reflect the new totals synchronously.

### Synchronization Rules
1. In `TransactionProvider`, whenever mutating operations are performed (e.g., `addTransaction`, `deleteTransaction`), call the private helper `_notifyListeners()`.
2. Inside `_notifyListeners()`, the `HomeWidgetService` is invoked to update the widget data key-value stores.
3. Keep the shared widget group ID consistent: `group.com.example.cashflow_app`. Do not modify this native bundle key.

---

## 4. Multi-Language Expansion (l10n)

Localization is configured using Flutter's native generated l10n support. The source translation catalogs are stored in `/lib/l10n/*.arb`.

### l10n Workflow
1. **Never edit generated Dart files** in `.dart_tool` or `/lib/l10n/app_localizations_*.dart`. These are completely transient.
2. To modify or add strings, open the corresponding translation file (e.g., `lib/l10n/app_en.arb` for English, `app_es.arb` for Spanish).
3. Add or edit your key-value pair under the JSON structure:
   ```json
   "accountNamePlaceholder": "Account Name",
   "@accountNamePlaceholder": {
     "description": "Label for account name input"
   }
   ```
4. Regenerate localization classes using:
   ```bash
   flutter gen-l10n
   ```
5. Reference the generated localization keys in screens/widgets using:
   ```dart
   AppLocalizations.of(context)!.accountNamePlaceholder
   ```
