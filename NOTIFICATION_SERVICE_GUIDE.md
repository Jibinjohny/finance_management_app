# EMI Notification Service - Usage Guide

## Overview
The `NotificationService` automatically schedules EMI payment reminders 2 days before the due date for all loan accounts.

## Features
- ✅ Schedules local notifications 2 days before EMI due date
- ✅ Creates in-app notifications for tracking
- ✅ Handles Android & iOS permissions
- ✅ Timezone-aware scheduling
- ✅ Automatic next EMI date calculation
- ✅ Notification cancellation support

## How to Use

### 1. Schedule EMI Reminder (After Creating Loan Account)

```dart
import '../services/notification_service.dart';
import '../providers/notification_provider.dart';

// After creating a loan account
final notificationService = NotificationService();
final notificationProvider = Provider.of<NotificationProvider>(context, listen: false);

await notificationService.scheduleEmiReminder(
  account: loanAccount,
  notificationProvider: notificationProvider,
);
```

### 2. Cancel EMI Reminder (When Deleting Account)

```dart
await NotificationService().cancelEmiReminder(accountId);
```

### 3. Reschedule After EMI Payment

```dart
// After recording EMI payment
await NotificationService().rescheduleAllEmiReminders(
  loanAccounts: accountProvider.getLoanAccounts(),
  notificationProvider: notificationProvider,
);
```

## Integration Points

### AddAccountScreen
After saving a loan account, schedule the notification:

```dart
if (account.type == AccountType.loan && account.emiPaymentDay != null) {
  final notifProvider = Provider.of<NotificationProvider>(context, listen: false);
  await NotificationService().scheduleEmiReminder(
    account: account,
    notificationProvider: notifProvider,
  );
}
```

### AccountProvider.recordEmiPayment()
After recording payment, reschedule:

```dart
Future<void> recordEmiPayment(String accountId) async {
  // ... existing code ...
  
  // Reschedule notification for next month
  final notifProvider = /* get from context */;
  await NotificationService().rescheduleAllEmiReminders(
    loanAccounts: getLoanAccounts(),
    notificationProvider: notifProvider,
  );
}
```

### EditAccountScreen (Delete)
Before deleting account, cancel notification:

```dart
await NotificationService().cancelEmiReminder(widget.account.id);
await accountProvider.deleteAccount(widget.account.id);
```

## How It Works

### EMI Date Calculation
- Takes current date and EMI payment day (1-31)
- Finds next occurrence of that day
- Handles edge cases (e.g., Feb 30 → Feb 28/29)
- If date has passed this month, moves to next month

### Reminder Scheduling
- Calculates next EMI date
- Subtracts 2 days to get reminder date
- Schedules local notification at that time
- Creates in-app notification entry

### Notification Content
- **Title:** "EMI Payment Reminder"
- **Body:** "EMI of ₹X for [Account Name] is due on [Date]"
- **Payload:** "emi_[accountId]" for handling taps

## Permissions

### Android
- Automatically requests notification permission on Android 13+
- Uses `AndroidScheduleMode.exactAllowWhileIdle` for precise timing

### iOS
- Requests alert, badge, and sound permissions
- Uses `DarwinNotificationDetails` for iOS-specific settings

## Testing

### Test Notification Immediately
```dart
await NotificationService().showInstantNotification(
  title: 'Test Notification',
  body: 'This is a test',
);
```

### Check Scheduled Notifications
Notifications are scheduled using `zonedSchedule` with timezone support.

## Troubleshooting

### Notifications Not Showing
1. Check permissions are granted
2. Verify EMI payment day is set
3. Ensure reminder date is in future
4. Check device notification settings

### Wrong Timing
1. Verify timezone initialization
2. Check EMI payment day value (1-31)
3. Test with `showInstantNotification` first

## Example: Complete Flow

```dart
// 1. Create loan account with EMI day = 15
final account = Account(
  // ... other fields ...
  type: AccountType.loan,
  emiPaymentDay: 15,
  emiAmount: 5000,
);

// 2. Save account
await accountProvider.addAccount(account);

// 3. Schedule notification
final notifProvider = Provider.of<NotificationProvider>(context, listen: false);
await NotificationService().scheduleEmiReminder(
  account: account,
  notificationProvider: notifProvider,
);

// Result: Notification scheduled for 13th of next month
// (2 days before 15th)
```

## Notes
- Service is a singleton (`NotificationService()` returns same instance)
- Automatically initialized in `main.dart`
- Permissions requested on app start
- In-app notifications stored in database for history
