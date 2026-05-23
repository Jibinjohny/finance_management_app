---
name: security-and-data-protection
description: Local security standards and server migration blueprint for CashFlow, detailing secure storage, biometric lockouts, SQL transaction boundaries, and remote API migration strategies.
---

# Security & Data Protection Guidelines

This skill defines the security protocols, biometric standards, and future server migration architectures for protecting user financial data within CashFlow.

---

## 1. Secure Local Storage Protocols

Never store sensitive user-identifying data (e.g., login passcodes, biometric state indicators, encryption seeds, or api tokens) in standard plaintext `SharedPreferences` or database logs.

### Encryption Standard
*   **Storage Tool**: Use the `flutter_secure_storage` package which leverages **iOS Keychain Services** and **Android Keystore (AES encryption)** under the hood.
*   **Usage Pattern**:
    ```dart
    import 'package:flutter_secure_storage/flutter_secure_storage.dart';

    class SecureStorageService {
      static const _storage = FlutterSecureStorage();

      static Future<void> saveUserPin(String pin) async {
        await _storage.write(key: 'app_lock_pin', value: pin);
      }

      static Future<String?> getUserPin() async {
        return await _storage.read(key: 'app_lock_pin');
      }
    }
    ```

---

## 2. Secure Local Authentication (Biometrics)

Manage app lockouts and local pin overlay routines safely using `local_auth`.

### Biometric Execution Standard
1.  **Config**: Ensure native configuration files (`AndroidManifest.xml` permissions, iOS `Info.plist` usage descriptions) are properly declared and never deleted.
2.  **State Guard**: Use secure lifecycle listening so the app-lock screen triggers the moment the application transitions to the background.
3.  **Authentication Code Pattern**:
    ```dart
    import 'package:local_auth/local_auth.dart';

    final LocalAuthentication auth = LocalAuthentication();

    Future<bool> authenticateUser() async {
      try {
        final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
        final bool canAuthenticate = canAuthenticateWithBiometrics || await auth.isDeviceSupported();
        
        if (!canAuthenticate) return false;

        return await auth.authenticate(
          localizedReason: 'Please authenticate to unlock CashFlow',
          options: const AuthenticationOptions(
            stickyAuth: true,
            biometricOnly: true,
          ),
        );
      } catch (e) {
        // Log failure safely without printing raw exception traces in production
        return false;
      }
    }
    ```

---

## 3. Database Transaction Boundaries

To prevent database corruption during concurrent operations (e.g., cascading recurring items while creating a transfer), always perform queries within a SQLite transaction.

```dart
// ❌ INCORRECT - Risk of partial failures/race conditions
await db.insert('transactions', transactionData);
await db.update('accounts', updatedAccountData);

//  CORRECT - Bound in transaction blocks
await db.transaction((txn) async {
  await txn.insert('transactions', transactionData);
  await txn.update('accounts', updatedAccountData);
});
```

---

## 4. Server Migration Strategy (Future-Proofing)

To facilitate a seamless transition from a local-only SQFlite architecture to a centralized remote server (REST or GraphQL API), enforce structural abstraction layers now.

### Abstraction Pattern: Repository Pattern
Do not allow UI screens or providers to call `DatabaseHelper` directly. Instead, wrap operations behind Repository contracts:

```
[ UI Screens / Providers ]
          │
          ▼
[ Repository Interface ] (e.g., TransactionRepository)
          │
      ┌───┴──────────────┐
      ▼                  ▼
[ SQFlite Repo ]   [ REST API Repo ] (Future implementation)
 (Local Implementation)
```

1.  **Repository Contract**:
    ```dart
    abstract class TransactionRepository {
      Future<List<Transaction>> getTransactions(String userId);
      Future<void> saveTransaction(Transaction tx);
    }
    ```
2.  **SQFlite Implementation**:
    ```dart
    class SqfliteTransactionRepository implements TransactionRepository {
      @override
      Future<List<Transaction>> getTransactions(String userId) async {
        // Query local SQLite db...
      }
      ...
    }
    ```
3.  **Future Server Migration**:
    When the server is ready, implement `NetworkTransactionRepository` using `http`/`dio` and swap the bindings in `MultiProvider` in `lib/main.dart` without rewriting UI logic.

### First-Time Sync Workflow
When migrating a local user online for the first time:
1.  **Authenticate**: Authenticate via HTTPS tokenization.
2.  **Upload Payload**: Read all local SQFlite records, package them into a structured JSON payload, and POST it to a `/sync/first-time` endpoint.
3.  **Confirm & Clear**: Once the server responds with success, write a `sync_completed: true` flag to `flutter_secure_storage`.
4.  **Online Operation**: From that point forward, prioritize online REST transactions with dynamic offline local caching.
