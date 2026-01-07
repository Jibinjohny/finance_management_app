# Code Map for Agents

## Core flow
- `lib/main.dart`: wires providers, app lifecycle, localization delegates, app lock overlay, and widget deep links (`add_transaction` route).
- State is provider-driven; most providers persist to SQLite via `DatabaseHelper`. Auth sets `userId` on dependent providers so data is scoped per user.
- UI screens call provider methods; services handle IO (DB, notifications, PDF, backup, widget).

## Models (`lib/models`)
- `account.dart`: account types (cash/bank/card/loan/etc.), balance, color/icon metadata, optional loan fields and payment day.
- `transaction.dart`: income/expense flag, category, tags, payment mode, accountId, userId, amount/date.
- `budget.dart`, `goal.dart`, `recurring_transaction.dart`, `tag.dart`, `notification.dart`, `insight.dart`, `user.dart`: domain entities with `toMap/fromMap`.

## Providers (`lib/providers`)
- `auth_provider.dart`: in-memory users (email/PIN), sets current user ID for others.
- `account_provider.dart`: CRUD accounts, balance updates when transactions change.
- `transaction_provider.dart`: CRUD transactions, computes totals, updates widget, triggers large-transaction notifications, deletes by account.
- `budget_provider.dart`: budgets per category/period with spend calculations.
- `recurring_transaction_provider.dart`: schedules/marks recurring tx and can auto-add to transactions.
- `goal_provider.dart`: track goal progress and completion.
- `tag_provider.dart` and `category_provider.dart`: tag/category catalogs.
- `insights_provider.dart`: aggregates for charts (totals by category/time).
- `notification_provider.dart`: stores in-app notification records.
- `language_provider.dart`: current locale management.
- `security_provider.dart`: PIN/biometric/app-lock timers.

## Services (`lib/services`)
- `database_helper.dart`: SQLite init/migrations (v10), schema for users/accounts/transactions/budgets/goals/tags/notifications/recurring_transactions; exposes singleton DB.
- `backup_service.dart`: export/import DB via `Share` and `FilePicker`; prompts with `GlassDialog`.
- `notification_service.dart`: flutter_local_notifications setup, permission requests, scheduling utilities.
- `home_widget_service.dart`: packages data for the home-screen widget (income/expense/recent tx).
- `pdf_service.dart`: builds monthly PDF reports from transaction/budget data.

## Screens (`lib/screens`) highlights
- Auth/lock: `login_screen.dart`, `app_lock_screen.dart`, `splash_screen.dart`.
- Dashboard & insights: `dashboard_screen.dart`, `insights_screen.dart`, `stats_screen.dart`.
- Accounts: `accounts_screen.dart`, add/edit flows (`add_account_screen.dart`, `edit_account_screen.dart`).
- Transactions: `add_transaction_screen.dart`, `add_transaction_screen_multistep.dart`, `transaction_details_screen.dart`.
- Budgets/goals/recurring: `add_edit_budget_screen.dart`, `add_edit_goal_screen.dart`, `add_edit_recurring_transaction_screen.dart`, `budgets_screen.dart`, `goals_screen.dart`.
- Reports/notifications/profile: `monthly_report_screen.dart`, `notifications_screen.dart`, `profile_screen.dart`, `settings` features within profile.
- Misc helpers: `add_category_screen.dart`, `add_edit_tag_screen.dart`, `currency_settings` inside profile flows.

## Utils & widgets
- `lib/utils/`: `app_colors.dart`, `formatters.dart`, `validators.dart`, constants and helpers.
- `lib/widgets/`: glass components, selectors (account/payment mode/tag/category), list items for accounts/transactions, charts, buttons, dialogs.

## Localization (`lib/l10n`)
- ARB files for many locales; generated `app_localizations_*.dart` plus wrapper `app_localizations.dart` and `l10n/l10n.dart`. Edit ARB then run `flutter gen-l10n`; avoid hand-editing generated Dart.

## Tests (`test/`)
- Unit tests for models/utils/providers/widgets; DB-backed tests rely on `sqflite_common_ffi` when needed. Use `flutter test` and keep in-memory DB patterns for deterministic runs.

## Platform bits
- Android/iOS/macOS/windows/linux scaffolds present. Home widget integration uses native configuration (`android/app/src/...` and iOS Runner assets) already set up; avoid breaking bundle IDs or widget group ID (`group.com.example.cashflow_app` in `main.dart`) without updating native files.

