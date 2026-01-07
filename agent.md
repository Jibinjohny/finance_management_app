# agent.md — CashFlow (Flutter)

## Quick context
- Flutter 3 / Dart 3 personal finance app with Provider state management.
- Local-first SQLite via `lib/services/database_helper.dart` (schema v10); backup/restore and export supported.
- Features: auth + PIN/biometric app lock, accounts/transactions/budgets/goals/tags, notifications, home-screen widget, PDF monthly reports, multi-language (ARB + gen-l10n).

## Boot & state wiring
- `lib/main.dart` sets `MultiProvider`, initializes notifications, and manages app-lock overlay via `SecurityProvider` in `AppLifecycleManager`.
- Auth drives user scoping: proxy providers call `setUserId` on Transaction/Budget/Recurring/Goal/Tag providers. Ensure `userId` is set before persisting.
- `TransactionProvider._notifyListeners` also updates HomeWidget data; call it when mutating transactions.

## Where things live
- Models: `lib/models/` (account, transaction, budget, goal, recurring_transaction, tag, notification, insight, user).
- Providers: `lib/providers/` (auth, account, transaction, budget, recurring_transaction, goal, tag, category, insights, notification, language, security).
- Services: `lib/services/` (database_helper migrations, backup_service export/import, notification_service, home_widget_service, pdf_service).
- UI: `lib/screens/` for flows (auth, dashboard/insights, accounts add/edit, transactions add/edit, budgets/goals/recurring, reports, notifications, profile/settings). `lib/widgets/` for reusable glass components/selectors; `lib/utils/` for colors/formatters/validators/constants.
- Localization: ARB files under `lib/l10n`; generated `app_localizations_*.dart`—edit ARB then run `flutter gen-l10n`.

## Build/Test
- Install deps: `flutter pub get`.
- Analyze: `flutter analyze` (current errors: undefined `accountName` placeholders in generated l10n files; argument issues in `lib/screens/edit_account_screen.dart`).
- Tests: `flutter test` (unit tests in `test/`; DB tests use `sqflite_common_ffi`).

## Behavior notes
- Transactions adjust account balances and fire notifications for amounts ≥ `TransactionProvider.LARGE_TRANSACTION_THRESHOLD`.
- Backup/restore copies `cashflow_v4.db` with confirmation dialog; DB is closed before overwrite.
- App lock: `SecurityProvider` + `AppLockScreen`; avoid using `BuildContext` after async gaps without mounted checks.

## Guardrails
- Do not edit generated l10n Dart; fix ARB and regenerate.
- If changing schema, bump `DatabaseHelper` version/migrations and update models/providers.
- Replace `print` with structured logging/snackbars; clean deprecated API usages when touched.
- Update docs (`RELEASE_NOTES.md`, `PROJECT_DOCUMENTATION.md`, `USER_MANUAL.md`) when behavior changes.

