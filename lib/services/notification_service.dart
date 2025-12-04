import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import '../models/account.dart';
import '../providers/notification_provider.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return;

    // Initialize timezone
    tz.initializeTimeZones();

    // Android initialization settings
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    // iOS initialization settings
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    _initialized = true;
  }

  void _onNotificationTapped(NotificationResponse response) {
    // Handle notification tap
    // debugPrint('Notification initialized');: ${response.payload}');
  }

  Future<bool> requestPermissions() async {
    if (!_initialized) await initialize();

    // Request Android 13+ notification permission
    final androidPlugin = _notifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    if (androidPlugin != null) {
      final granted = await androidPlugin.requestNotificationsPermission();
      return granted ?? false;
    }

    // Request iOS permissions
    final iosPlugin = _notifications
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >();

    if (iosPlugin != null) {
      final granted = await iosPlugin.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
      return granted ?? false;
    }

    return true;
  }

  Future<void> scheduleEmiReminder({
    required Account account,
    required NotificationProvider notificationProvider,
    required String currencySymbol,
  }) async {
    if (!_initialized) await initialize();
    if (account.type != AccountType.loan || account.emiPaymentDay == null) {
      return;
    }

    // Calculate next EMI date
    final now = DateTime.now();
    final nextEmiDate = _getNextEmiDate(now, account.emiPaymentDay!);

    // Schedule notification 2 days before
    final reminderDate = nextEmiDate.subtract(Duration(days: 2));

    // Don't schedule if reminder date is in the past
    if (reminderDate.isBefore(now)) {
      return;
    }

    final notificationId = account.id.hashCode;

    // Schedule local notification
    await _scheduleNotification(
      id: notificationId,
      title: 'EMI Payment Reminder',
      body:
          'EMI of $currencySymbol${account.emiAmount?.toStringAsFixed(2)} for ${account.name} is due on ${_formatDate(nextEmiDate)}',
      scheduledDate: reminderDate,
      payload: 'emi_${account.id}',
    );

    // Note: In-app notification creation requires userId from AuthProvider
    // This should be called from the UI layer where context is available
    // Example integration in AddAccountScreen after creating loan account:
    //
    // final authProvider = Provider.of<AuthProvider>(context, listen: false);
    // final notifProvider = Provider.of<NotificationProvider>(context, listen: false);
    // final notification = AppNotification(
    //   id: DateTime.now().millisecondsSinceEpoch.toString(),
    //   userId: authProvider.currentUser!.id,
    //   title: 'EMI Payment Reminder',
    //   message: 'EMI of ₹X for Account is due on Date',
    //   timestamp: reminderDate,
    //   isRead: false,
    // );
    // await notifProvider.addNotification(notification);
  }

  Future<void> _scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
    String? payload,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'emi_reminders',
      'EMI Reminders',
      channelDescription: 'Notifications for upcoming EMI payments',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: true,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notifications.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: payload,
    );
  }

  Future<void> cancelEmiReminder(String accountId) async {
    final notificationId = accountId.hashCode;
    await _notifications.cancel(notificationId);
  }

  Future<void> cancelAllNotifications() async {
    await _notifications.cancelAll();
  }

  DateTime _getNextEmiDate(DateTime now, int dayOfMonth) {
    // Get the next occurrence of the EMI day
    var nextDate = DateTime(now.year, now.month, dayOfMonth);

    // If the date has passed this month, move to next month
    if (nextDate.isBefore(now) || nextDate.isAtSameMomentAs(now)) {
      nextDate = DateTime(now.year, now.month + 1, dayOfMonth);
    }

    // Handle months with fewer days (e.g., Feb 30 -> Feb 28/29)
    while (nextDate.month !=
        (now.month + (nextDate.isBefore(now) ? 2 : 1)) % 12) {
      nextDate = nextDate.subtract(Duration(days: 1));
    }

    return nextDate;
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  Future<void> showInstantNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    if (!_initialized) await initialize();

    const androidDetails = AndroidNotificationDetails(
      'general',
      'General Notifications',
      channelDescription: 'General app notifications',
      importance: Importance.high,
      priority: Priority.high,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notifications.show(
      DateTime.now().millisecondsSinceEpoch % 100000,
      title,
      body,
      details,
      payload: payload,
    );
  }

  Future<void> rescheduleAllEmiReminders({
    required List<Account> loanAccounts,
    required NotificationProvider notificationProvider,
    required String currencySymbol,
  }) async {
    // Cancel all existing EMI notifications
    for (final account in loanAccounts) {
      await cancelEmiReminder(account.id);
    }

    // Reschedule for all loan accounts
    for (final account in loanAccounts) {
      if (account.emiPaymentDay != null) {
        await scheduleEmiReminder(
          account: account,
          notificationProvider: notificationProvider,
          currencySymbol: currencySymbol,
        );
      }
    }
  }
}
