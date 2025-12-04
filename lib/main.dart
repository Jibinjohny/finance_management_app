import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:home_widget/home_widget.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:cashflow_app/l10n/app_localizations.dart';
import 'providers/auth_provider.dart';
import 'providers/transaction_provider.dart';
import 'providers/notification_provider.dart';
import 'providers/account_provider.dart';
import 'providers/budget_provider.dart';
import 'providers/recurring_transaction_provider.dart';
import 'providers/goal_provider.dart';
import 'providers/tag_provider.dart';
import 'providers/category_provider.dart';
import 'providers/insights_provider.dart';
import 'providers/language_provider.dart';
import 'providers/security_provider.dart';
import 'services/notification_service.dart';
import 'screens/splash_screen.dart';
import 'screens/add_transaction_screen.dart';
import 'screens/app_lock_screen.dart';
import 'utils/app_colors.dart';
import 'l10n/l10n.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set status bar icons to white
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light, // For Android: white icons
      statusBarBrightness: Brightness.dark, // For iOS: white icons
    ),
  );

  await HomeWidget.setAppGroupId('group.com.example.cashflow_app');

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _initNotifications();
    _checkForWidgetLaunch();
  }

  void _checkForWidgetLaunch() {
    HomeWidget.initiallyLaunchedFromHomeWidget().then(_handleWidgetLaunch);
    HomeWidget.widgetClicked.listen(_handleWidgetLaunch);
  }

  void _handleWidgetLaunch(Uri? uri) {
    if (uri?.host == 'add_transaction') {
      navigatorKey.currentState?.push(
        MaterialPageRoute(builder: (_) => AddTransactionScreen()),
      );
    }
  }

  Future<void> _initNotifications() async {
    await NotificationService().initialize();
    await NotificationService().requestPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
        ChangeNotifierProvider(create: (_) => AccountProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(
          create: (_) => CategoryProvider(),
        ), // Registered CategoryProvider
        ChangeNotifierProxyProvider3<
          AuthProvider,
          AccountProvider,
          NotificationProvider,
          TransactionProvider
        >(
          create: (_) => TransactionProvider(),
          update: (context, auth, account, notification, previous) {
            previous!.setUserId(auth.currentUser?.id);
            previous.setAccountProvider(account);
            previous.setNotificationProvider(notification);
            return previous;
          },
        ),
        ChangeNotifierProxyProvider<AuthProvider, BudgetProvider>(
          create: (_) => BudgetProvider(),
          update: (context, auth, previous) {
            previous!.setUserId(auth.currentUser?.id);
            return previous;
          },
        ),
        ChangeNotifierProxyProvider2<
          AuthProvider,
          TransactionProvider,
          RecurringTransactionProvider
        >(
          create: (_) => RecurringTransactionProvider(),
          update: (context, auth, transaction, previous) {
            previous!.setUserId(auth.currentUser?.id);
            previous.setTransactionProvider(transaction);
            return previous;
          },
        ),
        ChangeNotifierProxyProvider<AuthProvider, GoalProvider>(
          create: (_) => GoalProvider(),
          update: (context, auth, previous) {
            previous!.setUserId(auth.currentUser?.id);
            return previous;
          },
        ),
        ChangeNotifierProxyProvider<AuthProvider, TagProvider>(
          create: (_) => TagProvider(),
          update: (context, auth, previous) {
            previous!.setUserId(auth.currentUser?.id);
            return previous;
          },
        ),
        ChangeNotifierProxyProvider<TransactionProvider, InsightsProvider>(
          create: (_) => InsightsProvider(),
          update: (context, transaction, previous) {
            previous!.setTransactionProvider(transaction);
            return previous;
          },
        ),
        ChangeNotifierProvider(create: (_) => SecurityProvider()),
      ],
      child: Consumer<LanguageProvider>(
        builder: (context, languageProvider, child) {
          return AppLifecycleManager(languageProvider: languageProvider);
        },
      ),
    );
  }
}

class AppLifecycleManager extends StatefulWidget {
  final LanguageProvider languageProvider;
  const AppLifecycleManager({super.key, required this.languageProvider});

  @override
  State<AppLifecycleManager> createState() => _AppLifecycleManagerState();
}

class _AppLifecycleManagerState extends State<AppLifecycleManager>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    Future.microtask(
      () => Provider.of<SecurityProvider>(context, listen: false).initialize(),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final securityProvider = Provider.of<SecurityProvider>(
      context,
      listen: false,
    );
    if (state == AppLifecycleState.paused) {
      securityProvider.setLastPausedTime(DateTime.now());
    } else if (state == AppLifecycleState.resumed) {
      securityProvider.checkAutoLock();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cashflow Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.background,
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme.apply(
            bodyColor: AppColors.onBackground,
            displayColor: AppColors.onBackground,
          ),
        ),
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness:
                Brightness.light, // For Android: white icons
            statusBarBrightness: Brightness.dark, // For iOS: white icons
          ),
        ),
      ),
      locale: widget.languageProvider.locale,
      supportedLocales: L10n.all,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      builder: (context, child) {
        return Stack(
          children: [
            if (child != null)
              ScrollConfiguration(
                behavior: const ScrollBehavior().copyWith(overscroll: false),
                child: child,
              ),
            Consumer<SecurityProvider>(
              builder: (context, security, _) {
                if (security.isAppLockEnabled && !security.isAuthenticated) {
                  return const AppLockScreen();
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        );
      },
      home: SplashScreen(),
    );
  }
}
