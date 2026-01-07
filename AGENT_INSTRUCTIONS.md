# Agent Instructions – CashFlow (Flutter)

## What this app is
- Flutter 3/Dart 3 app for personal finance tracking with Provider state management.
- Data is local-first via SQLite (`lib/services/database_helper.dart`, version 10 schema) with backup/restore and export.
- Features: auth + app lock (PIN/biometrics), accounts, transactions, budgets, goals, tags, notifications, home-screen widget, PDF monthly reports, localization (multiple ARB files).

## How the app boots and wires state
- `lib/main.dart` sets up `MultiProvider` and `AppLifecycleManager` for app-lock handling. SecurityProvider enforces auto-lock on resume; AppLockScreen overlays when locked.
- Auth state seeds other providers (`TransactionProvider`, `BudgetProvider`, `RecurringTransactionProvider`, `GoalProvider`, `TagProvider`) via `setUserId` in proxy providers. When you add data, ensure `userId` is set or data will be dropped.
- `NotificationService` initializes at startup; `HomeWidgetService` gets updates whenever `TransactionProvider._notifyListeners` runs (income/expense and recent tx summary for the widget).

## Key directories (lib/)
- `models/`: plain models with `toMap/fromMap` for SQLite (accounts, transactions, budgets, goals, tags, recurring transactions, notifications, user, insight).
- `providers/`: ChangeNotifiers for each domain; most persist via `DatabaseHelper` and coordinate cross-updates (e.g., TransactionProvider adjusts account balances and pushes notifications for large tx).
- `services/`: database, backup/export/import, notifications (flutter_local_notifications + timezone), home widget glue, PDF generation.
- `screens/`: UI flows (auth, dashboard, accounts, add/edit flows, budgets, goals, insights, reports, notifications, settings/profile, recurring tx).
- `utils/`: colors, formatters, validators, constants, theme helpers.
- `widgets/`: reusable UI (glass cards/dialogs, selectors, charts, list items, etc.).
- `l10n/`: ARB sources + generated localization classes; prefer editing ARB and regenerating.

## Build, run, test
- Install deps: `flutter pub get`.
- Static checks: `flutter analyze` (see current analyzer output in `analysis_final.txt`; main errors are undefined `accountName` placeholders in generated l10n files and an argument type issue in `lib/screens/edit_account_screen.dart`).
- Tests: `flutter test` (unit tests live under `test/` covering models, utils, providers, widgets). If adding DB-dependent tests, use `sqflite_common_ffi` as seen in existing tests.
- Run app: `flutter run` (Android/iOS/macOS); iOS/macOS use `Podfile`/`Runner` already present.

## Localization notes
- ARB files live in `lib/l10n/arb` (multiple locales). Generated Dart files are in the same folder and should not be hand-edited.
- Current analyzer errors reference `accountName` in generated files—fix by updating the relevant ARB entry and regenerating via `flutter gen-l10n`.

## Data and persistence
- SQLite schema built/migrated in `DatabaseHelper` (version 10; tables for users, accounts, transactions, budgets, goals, tags, notifications, recurring_transactions).
- Transactions update account balances and trigger notifications for amounts ≥ `TransactionProvider.LARGE_TRANSACTION_THRESHOLD`.
- Backup/restore: `BackupService.exportDatabase/importDatabase` copies `cashflow_v4.db` via `Share`/`FilePicker`; prompts user and closes DB before overwrite.

## Notifications and widget
- `NotificationService` handles scheduling/local auth permissions; `NotificationProvider` tracks in-app notification records.
- `HomeWidgetService` pushes summarized data for the home-screen widget; ensure to call `_notifyListeners` in TransactionProvider when mutating `_transactions` so the widget stays in sync.

## Security
- `SecurityProvider` manages PIN, biometrics (via `local_auth`), auto-lock timing; `AppLockScreen` overlays the UI when locked. When adding screens, keep actions respect lock state and avoid using `BuildContext` after async gaps without mounted checks.

## UI patterns
- Uses glassmorphism styling (see `utils/app_colors.dart`, `widgets/glass_*` components).
- Many add/edit screens rely on form controllers; there are several lints about deprecated `value` parameters—prefer `initialValue`/new APIs when touching forms.

## Testing and quality guardrails
- Keep lints in mind (`analysis_options.yaml` uses `flutter_lints`). Replace `print` with logging/snackbars in production code.
- When touching localization, regenerate; when touching schema, bump `DatabaseHelper` version and migrations.
- Prefer updating providers to keep state and persistence consistent; screens should call provider methods rather than hitting services directly.

## Useful file pointers
- Entry/root: `lib/main.dart`, `lib/utils/app_colors.dart`.
- Auth & lock: `providers/auth_provider.dart`, `providers/security_provider.dart`, `screens/login_screen.dart`, `screens/app_lock_screen.dart`.
- Data flows: `services/database_helper.dart`, `providers/*`, `models/*`.
- Backup/restore: `services/backup_service.dart`, `widgets/glass_dialog.dart`.
- Reports: `services/pdf_service.dart`, `screens/monthly_report_screen.dart`.
- Home widget: `services/home_widget_service.dart`, `main.dart` widget handling in `_MyAppState._handleWidgetLaunch`.

## Open issues to remember
- Analyzer errors for undefined `accountName` in generated l10n files; likely missing placeholder in ARB.
- `lib/screens/edit_account_screen.dart` has argument type and extra positional argument errors—fix before shipping.
- Multiple `avoid_print` and deprecated API warnings across providers/screens; clean as you touch those files.

## How to contribute safely
- Run `flutter analyze` and `flutter test` before handing off.
- Keep generated localization files untouched; edit ARB then run `flutter gen-l10n`.
- When adding persistence fields, update migrations and models and ensure providers set defaults.
- When adding transactions, always consider account balance adjustments and notification thresholds.
- Document user-facing changes in `RELEASE_NOTES.md` and keep `PROJECT_DOCUMENTATION.md`/`USER_MANUAL.md` in sync if behavior changes.

