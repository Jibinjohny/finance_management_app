---
name: financial-domain-assistant
description: Wealth engineering and personal finance guidelines for CashFlow, covering dynamic budget alerts, multi-wallet structures, loan interest calculations, and transaction cascading.
---

# Financial Domain & Logic Guidelines

This skill provides expert financial specifications, accounting rules, and math directives required to build robust wallet, payment tracker, and fund management capabilities within CashFlow.

---

## 1. Precise Financial Math

To prevent representation errors associated with floating-point math (e.g., `0.1 + 0.2 = 0.30000000000000004`), follow strict scale-rounding constraints.

### Mathematics Principles
1.  **Rounding Rule**: All financial results shown to the user must be rounded using half-up arithmetic to exactly 2 decimal places.
2.  **Formulas**: Use clean rounding utility structures:
    ```dart
    double roundToTwoDecimals(double value) {
      return (value * 100).round() / 100.0;
    }
    ```
3.  **Future Server Migration Planning**: When exchanging financial data with a remote server, store and send financial values as **integers in cents** (e.g., `$10.50` is sent as `1050`) to maintain universal backend precision.

---

## 2. Multi-Wallet & Account Paradigms

CashFlow supports multiple types of accounts (`AccountType`). Each type has specialized rules that the database and providers must honor.

### Account Type Behaviors

| Account Type | Description | State Constraints & Math |
| :--- | :--- | :--- |
| **Cash** | Standard physical wallet. | Balance decreases on Expense, increases on Income. |
| **Bank** | Checking or savings account. | Supports transfer transactions. Balance adjustments occur synchronously. |
| **Card (Credit)** | Credit card account. | Has a `creditLimit`. Balance represents **utilized credit**. Remaining credit = `creditLimit - balance`. Needs statement cycles and billing dates. |
| **Loan** | Borrowed funds tracker. | Decreases on repayment (repayment treated as expense from bank/cash and income/credit to the loan account). Tracks active `interestRate`. |

---

## 3. Dynamic Budgeting & Alert Thresholds

Budgets scope category expenditures over a calendar period (monthly/weekly).

### Alert Logic
*   **Warning Threshold**: When category spending reaches **80%** of the allocated budget limit, log a dynamic local alert or in-app notification.
*   **Breached Threshold**: When category spending reaches or exceeds **100%**, flag the budget card visually with a warning indicator and send a push notification.

### Calculations
```dart
double calculateBudgetUsagePercentage(double totalSpent, double limit) {
  if (limit <= 0) return 0.0;
  return roundToTwoDecimals((totalSpent / limit) * 100);
}
```

---

## 4. Loan Calculations & Amortization

For tracking loans and interest, follow standard financial interest formulas:

### Simple Interest
$$\text{Interest} = P \times R \times T$$
Where $P$ is principal, $R$ is annual rate, and $T$ is time in years.

### Monthly Compound Interest Amortization
To compute monthly repayment bounds for amortization:
$$M = P \frac{r(1+r)^n}{(1+r)^n - 1}$$
Where:
*   $M$ = Monthly payment
*   $P$ = Principal loan amount
*   $r$ = Monthly interest rate (annual rate / 12)
*   $n$ = Total number of monthly payments

---

## 5. Transaction & Account Cascading

All financial operations must execute within transactional integrity constraints.

*   Adding an expense of `$X` must decrease the linked account balance by `$X`.
*   Adding an income of `$Y` must increase the linked account balance by `$Y`.
*   Modifying an expense from `$X` to `$Z` must offset the account balance by the difference `$(X - Z)`.
*   Deleting a transaction must reverse the entire amount adjustment on the original account.
*   **Large Transaction Safeguard**: Any single transaction greater than or equal to `TransactionProvider.LARGE_TRANSACTION_THRESHOLD` (currently set to `$5,000` or equivalent) must trigger an automated localized high-priority security verification notification.
