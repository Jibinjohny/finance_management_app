import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_bn.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fa.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_gu.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_id.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_kn.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_ml.dart';
import 'app_localizations_mr.dart';
import 'app_localizations_pl.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_ta.dart';
import 'app_localizations_te.dart';
import 'app_localizations_th.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_ur.dart';
import 'app_localizations_vi.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('bn'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fa'),
    Locale('fr'),
    Locale('gu'),
    Locale('hi'),
    Locale('id'),
    Locale('it'),
    Locale('ja'),
    Locale('kn'),
    Locale('ko'),
    Locale('ml'),
    Locale('mr'),
    Locale('pl'),
    Locale('pt'),
    Locale('ru'),
    Locale('ta'),
    Locale('te'),
    Locale('th'),
    Locale('tr'),
    Locale('ur'),
    Locale('vi'),
    Locale('zh'),
    Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'CashFlow'**
  String get appTitle;

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @transactions.
  ///
  /// In en, this message translates to:
  /// **'Transactions'**
  String get transactions;

  /// No description provided for @accounts.
  ///
  /// In en, this message translates to:
  /// **'Accounts'**
  String get accounts;

  /// No description provided for @more.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get more;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @searchLanguage.
  ///
  /// In en, this message translates to:
  /// **'Search language...'**
  String get searchLanguage;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @signup.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signup;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstName;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastName;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @currency.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get currency;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @helpAndSupport.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get helpAndSupport;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @termsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get termsAndConditions;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
  String get alreadyHaveAccount;

  /// No description provided for @whyNeedSignup.
  ///
  /// In en, this message translates to:
  /// **'Why do I need to sign up?'**
  String get whyNeedSignup;

  /// No description provided for @hello.
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get hello;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get welcomeBack;

  /// No description provided for @netWorth.
  ///
  /// In en, this message translates to:
  /// **'Net Worth'**
  String get netWorth;

  /// No description provided for @financialPlanning.
  ///
  /// In en, this message translates to:
  /// **'Financial Planning'**
  String get financialPlanning;

  /// No description provided for @budgets.
  ///
  /// In en, this message translates to:
  /// **'Budgets'**
  String get budgets;

  /// No description provided for @goals.
  ///
  /// In en, this message translates to:
  /// **'Goals'**
  String get goals;

  /// No description provided for @categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// No description provided for @recurring.
  ///
  /// In en, this message translates to:
  /// **'Recurring'**
  String get recurring;

  /// No description provided for @calendar.
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get calendar;

  /// No description provided for @insights.
  ///
  /// In en, this message translates to:
  /// **'Insights'**
  String get insights;

  /// No description provided for @tags.
  ///
  /// In en, this message translates to:
  /// **'Tags'**
  String get tags;

  /// No description provided for @myAccounts.
  ///
  /// In en, this message translates to:
  /// **'My Accounts'**
  String get myAccounts;

  /// No description provided for @noAccountsYet.
  ///
  /// In en, this message translates to:
  /// **'No accounts yet'**
  String get noAccountsYet;

  /// No description provided for @overview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get overview;

  /// No description provided for @topExpenses.
  ///
  /// In en, this message translates to:
  /// **'Top Expenses'**
  String get topExpenses;

  /// No description provided for @noExpensesYet.
  ///
  /// In en, this message translates to:
  /// **'No expenses yet'**
  String get noExpensesYet;

  /// No description provided for @recentTransactions.
  ///
  /// In en, this message translates to:
  /// **'Recent Transactions'**
  String get recentTransactions;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get viewAll;

  /// No description provided for @noRecentTransactions.
  ///
  /// In en, this message translates to:
  /// **'No recent transactions'**
  String get noRecentTransactions;

  /// No description provided for @filterByTags.
  ///
  /// In en, this message translates to:
  /// **'Filter by Tags'**
  String get filterByTags;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @noTagsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No tags available'**
  String get noTagsAvailable;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @allTransactions.
  ///
  /// In en, this message translates to:
  /// **'All Transactions'**
  String get allTransactions;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @income.
  ///
  /// In en, this message translates to:
  /// **'Income'**
  String get income;

  /// No description provided for @expense.
  ///
  /// In en, this message translates to:
  /// **'Expense'**
  String get expense;

  /// No description provided for @noTransactionsFound.
  ///
  /// In en, this message translates to:
  /// **'No transactions found'**
  String get noTransactionsFound;

  /// No description provided for @deleteTransaction.
  ///
  /// In en, this message translates to:
  /// **'Delete Transaction'**
  String get deleteTransaction;

  /// No description provided for @deleteTransactionConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete \"{title}\"?'**
  String deleteTransactionConfirmation(Object title);

  /// No description provided for @transactionDeleted.
  ///
  /// In en, this message translates to:
  /// **'Transaction deleted'**
  String get transactionDeleted;

  /// No description provided for @statistics.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statistics;

  /// No description provided for @allAccounts.
  ///
  /// In en, this message translates to:
  /// **'All Accounts'**
  String get allAccounts;

  /// No description provided for @incomeVsExpense.
  ///
  /// In en, this message translates to:
  /// **'Income vs Expense'**
  String get incomeVsExpense;

  /// No description provided for @financialTrend.
  ///
  /// In en, this message translates to:
  /// **'Financial Trend (Last 6 Months)'**
  String get financialTrend;

  /// No description provided for @totalIncome.
  ///
  /// In en, this message translates to:
  /// **'Total Income'**
  String get totalIncome;

  /// No description provided for @totalExpense.
  ///
  /// In en, this message translates to:
  /// **'Total Expense'**
  String get totalExpense;

  /// No description provided for @totalBalance.
  ///
  /// In en, this message translates to:
  /// **'Total Balance'**
  String get totalBalance;

  /// No description provided for @spendingByTags.
  ///
  /// In en, this message translates to:
  /// **'Spending by Tags'**
  String get spendingByTags;

  /// No description provided for @accountBreakdown.
  ///
  /// In en, this message translates to:
  /// **'Account Breakdown'**
  String get accountBreakdown;

  /// No description provided for @noAccountsFound.
  ///
  /// In en, this message translates to:
  /// **'No Accounts Found'**
  String get noAccountsFound;

  /// No description provided for @monthlyReport.
  ///
  /// In en, this message translates to:
  /// **'Monthly Report'**
  String get monthlyReport;

  /// No description provided for @loginWelcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome to CashFlow'**
  String get loginWelcome;

  /// No description provided for @loginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue'**
  String get loginSubtitle;

  /// No description provided for @whyLoginTitle.
  ///
  /// In en, this message translates to:
  /// **'Why Login?'**
  String get whyLoginTitle;

  /// No description provided for @whyLoginContent.
  ///
  /// In en, this message translates to:
  /// **'Even though your data is stored locally on your device, we use a login system to secure your financial information from unauthorized access by others who might use your phone.'**
  String get whyLoginContent;

  /// No description provided for @whyLoginAction.
  ///
  /// In en, this message translates to:
  /// **'Got it'**
  String get whyLoginAction;

  /// No description provided for @whyLoginLink.
  ///
  /// In en, this message translates to:
  /// **'Why do I need to login?'**
  String get whyLoginLink;

  /// No description provided for @usernameHint.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get usernameHint;

  /// No description provided for @passwordHint.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordHint;

  /// No description provided for @loginButton.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginButton;

  /// No description provided for @noAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? '**
  String get noAccount;

  /// No description provided for @signUpLink.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUpLink;

  /// No description provided for @invalidCredentials.
  ///
  /// In en, this message translates to:
  /// **'Invalid credentials'**
  String get invalidCredentials;

  /// No description provided for @resetDataMessage.
  ///
  /// In en, this message translates to:
  /// **'App data reset. You can now sign up.'**
  String get resetDataMessage;

  /// No description provided for @faqTitle.
  ///
  /// In en, this message translates to:
  /// **'FAQ'**
  String get faqTitle;

  /// No description provided for @faqSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search FAQ...'**
  String get faqSearchHint;

  /// No description provided for @faqNoResults.
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get faqNoResults;

  /// No description provided for @faqQ1.
  ///
  /// In en, this message translates to:
  /// **'How do I create a new account?'**
  String get faqQ1;

  /// No description provided for @faqA1.
  ///
  /// In en, this message translates to:
  /// **'Go to the Accounts tab and tap the \"+\" button. Enter your account name, select an icon and color, then set the initial balance. You can create multiple accounts for different purposes like bank accounts, cash, credit cards, etc.'**
  String get faqA1;

  /// No description provided for @faqQ2.
  ///
  /// In en, this message translates to:
  /// **'How do I add a transaction?'**
  String get faqQ2;

  /// No description provided for @faqA2.
  ///
  /// In en, this message translates to:
  /// **'Tap the \"+\" floating action button on the home screen. Select whether it\'s income or expense, enter the amount, title, category, and date. Make sure you have at least one account created before adding transactions.'**
  String get faqA2;

  /// No description provided for @faqQ3.
  ///
  /// In en, this message translates to:
  /// **'Can I edit or delete transactions?'**
  String get faqQ3;

  /// No description provided for @faqA3.
  ///
  /// In en, this message translates to:
  /// **'Yes! Go to the Transactions screen, find the transaction you want to modify, and tap on it. You can either edit the details or delete it using the delete button.'**
  String get faqA3;

  /// No description provided for @faqQ4.
  ///
  /// In en, this message translates to:
  /// **'What are categories and how do I use them?'**
  String get faqQ4;

  /// No description provided for @faqA4.
  ///
  /// In en, this message translates to:
  /// **'Categories help you organize your transactions. For expenses, you can use categories like Food, Transport, Shopping, Bills, etc. For income, categories include Salary, Freelance, Business, etc. Select the appropriate category when adding a transaction.'**
  String get faqA4;

  /// No description provided for @faqQ5.
  ///
  /// In en, this message translates to:
  /// **'How do I create and manage budgets?'**
  String get faqQ5;

  /// No description provided for @faqA5.
  ///
  /// In en, this message translates to:
  /// **'Go to the Budgets screen from the dashboard. Tap \"+\" to create a new budget. You can set a limit for a specific category and time period (weekly, monthly, etc.). To edit or delete, tap on an existing budget.'**
  String get faqA5;

  /// No description provided for @faqQ6.
  ///
  /// In en, this message translates to:
  /// **'How do I set financial goals?'**
  String get faqQ6;

  /// No description provided for @faqA6.
  ///
  /// In en, this message translates to:
  /// **'Navigate to the Goals screen. Tap \"+\" to add a goal (e.g., \"New Car\"). Set a target amount and target date. You can then \"Add Funds\" to the goal from your accounts to track your progress.'**
  String get faqA6;

  /// No description provided for @faqQ7.
  ///
  /// In en, this message translates to:
  /// **'How do I set up recurring transactions?'**
  String get faqQ7;

  /// No description provided for @faqA7.
  ///
  /// In en, this message translates to:
  /// **'Go to the Recurring Transactions screen. Tap \"+\" to create a new recurring income or expense. Set the amount, frequency (e.g., monthly), and next due date. You can also enable \"Auto-add\" to have them added automatically.'**
  String get faqA7;

  /// No description provided for @faqQ8.
  ///
  /// In en, this message translates to:
  /// **'How does the Calendar view work?'**
  String get faqQ8;

  /// No description provided for @faqA8.
  ///
  /// In en, this message translates to:
  /// **'The Calendar screen shows your transactions on a monthly calendar. Dates with transactions are marked. Tapping a date shows the transactions for that specific day.'**
  String get faqA8;

  /// No description provided for @faqQ9.
  ///
  /// In en, this message translates to:
  /// **'How do I view my spending reports?'**
  String get faqQ9;

  /// No description provided for @faqA9.
  ///
  /// In en, this message translates to:
  /// **'Navigate to the Monthly Report screen from the bottom navigation. You\'ll see charts showing your income vs expenses, category-wise breakdown, and transaction history for the selected month.'**
  String get faqA9;

  /// No description provided for @faqQ10.
  ///
  /// In en, this message translates to:
  /// **'What is Net Worth and how is it calculated?'**
  String get faqQ10;

  /// No description provided for @faqA10.
  ///
  /// In en, this message translates to:
  /// **'Net Worth is the total of all your account balances. It\'s calculated by adding up the current balance of all your accounts. You can view the Net Worth chart on the home screen to see trends over time.'**
  String get faqA10;

  /// No description provided for @faqQ11.
  ///
  /// In en, this message translates to:
  /// **'How do I export my data?'**
  String get faqQ11;

  /// No description provided for @faqA11.
  ///
  /// In en, this message translates to:
  /// **'Go to the Monthly Report screen and tap the export button. You can generate a PDF report of your transactions for the selected month, which can be saved or shared.'**
  String get faqA11;

  /// No description provided for @faqQ12.
  ///
  /// In en, this message translates to:
  /// **'How do I enable notifications?'**
  String get faqQ12;

  /// No description provided for @faqA12.
  ///
  /// In en, this message translates to:
  /// **'Go to the Notifications screen from the bottom navigation. You can create custom reminders for bills, savings goals, or any other financial tasks. Set the title, time, and frequency.'**
  String get faqA12;

  /// No description provided for @faqQ13.
  ///
  /// In en, this message translates to:
  /// **'Is my data secure?'**
  String get faqQ13;

  /// No description provided for @faqA13.
  ///
  /// In en, this message translates to:
  /// **'Yes! All your data is stored locally on your device using encrypted SQLite database. Your financial information never leaves your device unless you explicitly export it.'**
  String get faqA13;

  /// No description provided for @faqQ14.
  ///
  /// In en, this message translates to:
  /// **'Can I use the app on multiple devices?'**
  String get faqQ14;

  /// No description provided for @faqA14.
  ///
  /// In en, this message translates to:
  /// **'Currently, the app stores data locally on your device. Cloud sync is not available yet, so data won\'t automatically transfer between devices.'**
  String get faqA14;

  /// No description provided for @faqQ15.
  ///
  /// In en, this message translates to:
  /// **'How do I backup my data?'**
  String get faqQ15;

  /// No description provided for @faqA15.
  ///
  /// In en, this message translates to:
  /// **'You can export your monthly reports as PDF files. For complete data backup, use your device\'s backup features (iCloud for iOS, Google Drive for Android) which will include the app\'s local database.'**
  String get faqA15;

  /// No description provided for @faqQ16.
  ///
  /// In en, this message translates to:
  /// **'What should I do if I see an error?'**
  String get faqQ16;

  /// No description provided for @faqA16.
  ///
  /// In en, this message translates to:
  /// **'Try restarting the app first. If the issue persists, check that you have the latest version installed. For persistent problems, you can reset the database from the login screen (this will delete all data, so export reports first).'**
  String get faqA16;

  /// No description provided for @faqQ17.
  ///
  /// In en, this message translates to:
  /// **'How do I update the app?'**
  String get faqQ17;

  /// No description provided for @faqA17.
  ///
  /// In en, this message translates to:
  /// **'You can update the app from the App Store or Google Play Store.'**
  String get faqA17;

  /// No description provided for @privacyPolicyTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicyTitle;

  /// No description provided for @lastUpdated.
  ///
  /// In en, this message translates to:
  /// **'Last Updated'**
  String get lastUpdated;

  /// No description provided for @privacyIntroTitle.
  ///
  /// In en, this message translates to:
  /// **'1. Introduction'**
  String get privacyIntroTitle;

  /// No description provided for @privacyIntroContent.
  ///
  /// In en, this message translates to:
  /// **'Welcome to CashFlow. We respect your privacy and are committed to protecting your personal data. This privacy policy explains how we handle your information when you use our app.'**
  String get privacyIntroContent;

  /// No description provided for @privacyDataCollectionTitle.
  ///
  /// In en, this message translates to:
  /// **'2. Data Collection'**
  String get privacyDataCollectionTitle;

  /// No description provided for @privacyDataCollectionContent.
  ///
  /// In en, this message translates to:
  /// **'CashFlow stores all your financial data locally on your device. We do not collect, transmit, or store any of your personal information on external servers. The data you enter, including:\n\n• Account information\n• Transaction details\n• Personal profile information\n• Notification preferences\n\nAll remain exclusively on your device.'**
  String get privacyDataCollectionContent;

  /// No description provided for @privacyDataStorageTitle.
  ///
  /// In en, this message translates to:
  /// **'3. Data Storage'**
  String get privacyDataStorageTitle;

  /// No description provided for @privacyDataStorageContent.
  ///
  /// In en, this message translates to:
  /// **'Your data is stored in a local SQLite database on your device. This database is encrypted and protected by your device\'s security features. We do not have access to this data.'**
  String get privacyDataStorageContent;

  /// No description provided for @privacyDataSharingTitle.
  ///
  /// In en, this message translates to:
  /// **'4. Data Sharing'**
  String get privacyDataSharingTitle;

  /// No description provided for @privacyDataSharingContent.
  ///
  /// In en, this message translates to:
  /// **'We do not share, sell, or transmit your data to any third parties. Your financial information remains private and under your control. The only way data leaves your device is when you explicitly export reports.'**
  String get privacyDataSharingContent;

  /// No description provided for @privacyPermissionsTitle.
  ///
  /// In en, this message translates to:
  /// **'5. Permissions'**
  String get privacyPermissionsTitle;

  /// No description provided for @privacyPermissionsContent.
  ///
  /// In en, this message translates to:
  /// **'The app may request the following permissions:\n\n• Storage: To save exported PDF reports\n• Notifications: To send you reminders (if enabled)\n\nThese permissions are used solely for the stated purposes and do not involve data collection.'**
  String get privacyPermissionsContent;

  /// No description provided for @privacyDataSecurityTitle.
  ///
  /// In en, this message translates to:
  /// **'6. Data Security'**
  String get privacyDataSecurityTitle;

  /// No description provided for @privacyDataSecurityContent.
  ///
  /// In en, this message translates to:
  /// **'We implement appropriate security measures to protect your data:\n\n• Local encryption\n• Secure database storage\n• No external data transmission\n• Regular security updates'**
  String get privacyDataSecurityContent;

  /// No description provided for @privacyYourRightsTitle.
  ///
  /// In en, this message translates to:
  /// **'7. Your Rights'**
  String get privacyYourRightsTitle;

  /// No description provided for @privacyYourRightsContent.
  ///
  /// In en, this message translates to:
  /// **'You have complete control over your data:\n\n• Access: View all your data within the app\n• Modify: Edit or delete any information\n• Export: Generate PDF reports\n• Delete: Remove all data using the reset option'**
  String get privacyYourRightsContent;

  /// No description provided for @privacyChildrenTitle.
  ///
  /// In en, this message translates to:
  /// **'8. Children\'s Privacy'**
  String get privacyChildrenTitle;

  /// No description provided for @privacyChildrenContent.
  ///
  /// In en, this message translates to:
  /// **'Our app is not directed to children under 13. We do not knowingly collect data from children.'**
  String get privacyChildrenContent;

  /// No description provided for @privacyChangesTitle.
  ///
  /// In en, this message translates to:
  /// **'9. Changes to Privacy Policy'**
  String get privacyChangesTitle;

  /// No description provided for @privacyChangesContent.
  ///
  /// In en, this message translates to:
  /// **'We may update this privacy policy from time to time. We will notify you of any changes by updating the \"Last Updated\" date.'**
  String get privacyChangesContent;

  /// No description provided for @privacyContactTitle.
  ///
  /// In en, this message translates to:
  /// **'10. Contact Us'**
  String get privacyContactTitle;

  /// No description provided for @privacyContactContent.
  ///
  /// In en, this message translates to:
  /// **'If you have any questions about this privacy policy, please contact us through the app\'s support section.'**
  String get privacyContactContent;

  /// No description provided for @addTransactionTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Transaction'**
  String get addTransactionTitle;

  /// No description provided for @editTransactionTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Transaction'**
  String get editTransactionTitle;

  /// No description provided for @amountLabel.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amountLabel;

  /// No description provided for @amountHint.
  ///
  /// In en, this message translates to:
  /// **'0.00'**
  String get amountHint;

  /// No description provided for @titleLabel.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get titleLabel;

  /// No description provided for @categoryLabel.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get categoryLabel;

  /// No description provided for @dateLabel.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get dateLabel;

  /// No description provided for @chooseDate.
  ///
  /// In en, this message translates to:
  /// **'Choose Date'**
  String get chooseDate;

  /// No description provided for @saveTransaction.
  ///
  /// In en, this message translates to:
  /// **'Save Transaction'**
  String get saveTransaction;

  /// No description provided for @noAccountsMessage.
  ///
  /// In en, this message translates to:
  /// **'You need to add at least one account before you can create transactions.'**
  String get noAccountsMessage;

  /// No description provided for @addAccountAction.
  ///
  /// In en, this message translates to:
  /// **'Add Account'**
  String get addAccountAction;

  /// No description provided for @incomeMessage1.
  ///
  /// In en, this message translates to:
  /// **'🎉 Money in the bank!'**
  String get incomeMessage1;

  /// No description provided for @incomeMessage2.
  ///
  /// In en, this message translates to:
  /// **'💰 Cha-ching! Keep it coming!'**
  String get incomeMessage2;

  /// No description provided for @incomeMessage3.
  ///
  /// In en, this message translates to:
  /// **'✨ Your wallet is happy!'**
  String get incomeMessage3;

  /// No description provided for @incomeMessage4.
  ///
  /// In en, this message translates to:
  /// **'🚀 To the moon!'**
  String get incomeMessage4;

  /// No description provided for @incomeMessage5.
  ///
  /// In en, this message translates to:
  /// **'💸 Stack it up!'**
  String get incomeMessage5;

  /// No description provided for @incomeMessage6.
  ///
  /// In en, this message translates to:
  /// **'🔥 You\'re on fire!'**
  String get incomeMessage6;

  /// No description provided for @incomeMessage7.
  ///
  /// In en, this message translates to:
  /// **'⭐ Making it rain!'**
  String get incomeMessage7;

  /// No description provided for @incomeMessage8.
  ///
  /// In en, this message translates to:
  /// **'💎 Diamond hands!'**
  String get incomeMessage8;

  /// No description provided for @addAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Account'**
  String get addAccountTitle;

  /// No description provided for @editAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Account'**
  String get editAccountTitle;

  /// No description provided for @accountDetails.
  ///
  /// In en, this message translates to:
  /// **'Account Details'**
  String get accountDetails;

  /// No description provided for @accountNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Account Name'**
  String get accountNameLabel;

  /// No description provided for @accountNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., Main Wallet'**
  String get accountNameHint;

  /// No description provided for @accountNameError.
  ///
  /// In en, this message translates to:
  /// **'Please enter a name'**
  String get accountNameError;

  /// No description provided for @accountTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Account Type'**
  String get accountTypeLabel;

  /// No description provided for @initialBalanceLabel.
  ///
  /// In en, this message translates to:
  /// **'Initial Balance'**
  String get initialBalanceLabel;

  /// No description provided for @currentBalanceLabel.
  ///
  /// In en, this message translates to:
  /// **'Current Balance'**
  String get currentBalanceLabel;

  /// No description provided for @creditLimitLabel.
  ///
  /// In en, this message translates to:
  /// **'Credit Limit'**
  String get creditLimitLabel;

  /// No description provided for @balanceHint.
  ///
  /// In en, this message translates to:
  /// **'0.00'**
  String get balanceHint;

  /// No description provided for @balanceError.
  ///
  /// In en, this message translates to:
  /// **'Please enter balance'**
  String get balanceError;

  /// No description provided for @validNumberError.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid number'**
  String get validNumberError;

  /// No description provided for @bankDetails.
  ///
  /// In en, this message translates to:
  /// **'Bank Details'**
  String get bankDetails;

  /// No description provided for @cardDetails.
  ///
  /// In en, this message translates to:
  /// **'Card Details'**
  String get cardDetails;

  /// No description provided for @bankNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Bank Name'**
  String get bankNameLabel;

  /// No description provided for @cardIssuerLabel.
  ///
  /// In en, this message translates to:
  /// **'Card Issuer / Bank'**
  String get cardIssuerLabel;

  /// No description provided for @bankNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., HDFC Bank'**
  String get bankNameHint;

  /// No description provided for @bankNameError.
  ///
  /// In en, this message translates to:
  /// **'Please enter bank name'**
  String get bankNameError;

  /// No description provided for @cardIssuerError.
  ///
  /// In en, this message translates to:
  /// **'Please enter card issuer'**
  String get cardIssuerError;

  /// No description provided for @accountNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Account Number'**
  String get accountNumberLabel;

  /// No description provided for @cardNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Card Number (Last 4 digits)'**
  String get cardNumberLabel;

  /// No description provided for @accountNumberHint.
  ///
  /// In en, this message translates to:
  /// **'XXXX1234'**
  String get accountNumberHint;

  /// No description provided for @cardNumberHint.
  ///
  /// In en, this message translates to:
  /// **'1234'**
  String get cardNumberHint;

  /// No description provided for @cardNumberError.
  ///
  /// In en, this message translates to:
  /// **'Please enter last 4 digits'**
  String get cardNumberError;

  /// No description provided for @cardNumberLengthError.
  ///
  /// In en, this message translates to:
  /// **'Please enter exactly 4 digits'**
  String get cardNumberLengthError;

  /// No description provided for @loanDetails.
  ///
  /// In en, this message translates to:
  /// **'Loan Details'**
  String get loanDetails;

  /// No description provided for @loanPrincipalLabel.
  ///
  /// In en, this message translates to:
  /// **'Loan Principal Amount'**
  String get loanPrincipalLabel;

  /// No description provided for @loanPrincipalError.
  ///
  /// In en, this message translates to:
  /// **'Please enter principal amount'**
  String get loanPrincipalError;

  /// No description provided for @interestRateLabel.
  ///
  /// In en, this message translates to:
  /// **'Interest Rate (% per annum)'**
  String get interestRateLabel;

  /// No description provided for @interestRateError.
  ///
  /// In en, this message translates to:
  /// **'Please enter interest rate'**
  String get interestRateError;

  /// No description provided for @loanTenureLabel.
  ///
  /// In en, this message translates to:
  /// **'Loan Tenure (months)'**
  String get loanTenureLabel;

  /// No description provided for @loanTenureError.
  ///
  /// In en, this message translates to:
  /// **'Please enter tenure'**
  String get loanTenureError;

  /// No description provided for @emiAmountLabel.
  ///
  /// In en, this message translates to:
  /// **'EMI Amount'**
  String get emiAmountLabel;

  /// No description provided for @emiAmountError.
  ///
  /// In en, this message translates to:
  /// **'Please enter EMI amount'**
  String get emiAmountError;

  /// No description provided for @loanStartDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Loan Start Date'**
  String get loanStartDateLabel;

  /// No description provided for @emiPaymentDayLabel.
  ///
  /// In en, this message translates to:
  /// **'EMI Payment Day'**
  String get emiPaymentDayLabel;

  /// No description provided for @emisPaidLabel.
  ///
  /// In en, this message translates to:
  /// **'EMIs Paid'**
  String get emisPaidLabel;

  /// No description provided for @emisPaidError.
  ///
  /// In en, this message translates to:
  /// **'Please enter EMIs paid'**
  String get emisPaidError;

  /// No description provided for @emisPendingLabel.
  ///
  /// In en, this message translates to:
  /// **'EMIs Pending (Calculated)'**
  String get emisPendingLabel;

  /// No description provided for @appearanceLabel.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearanceLabel;

  /// No description provided for @colorLabel.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get colorLabel;

  /// No description provided for @iconLabel.
  ///
  /// In en, this message translates to:
  /// **'Icon'**
  String get iconLabel;

  /// No description provided for @createAccountButton.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccountButton;

  /// No description provided for @saveChangesButton.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get saveChangesButton;

  /// No description provided for @cancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelButton;

  /// No description provided for @deleteAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccountTitle;

  /// No description provided for @deleteAccountMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete \"{accountName}\"? This action cannot be undone.'**
  String deleteAccountMessage(String accountName);

  /// No description provided for @deleteAccountWarning.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete \"{accountName}\"? This account has {count} transactions. Deleting it will also delete all associated transactions.'**
  String deleteAccountWarning(String accountName, int count);

  /// No description provided for @deleteButton.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteButton;

  /// No description provided for @accountUpdatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Account updated successfully'**
  String get accountUpdatedSuccess;

  /// No description provided for @accountUpdateError.
  ///
  /// In en, this message translates to:
  /// **'Error updating account: {error}'**
  String accountUpdateError(String error);

  /// No description provided for @accountTypeCash.
  ///
  /// In en, this message translates to:
  /// **'Cash'**
  String get accountTypeCash;

  /// No description provided for @accountTypeSavings.
  ///
  /// In en, this message translates to:
  /// **'Savings'**
  String get accountTypeSavings;

  /// No description provided for @accountTypeSalary.
  ///
  /// In en, this message translates to:
  /// **'Salary'**
  String get accountTypeSalary;

  /// No description provided for @accountTypeCurrent.
  ///
  /// In en, this message translates to:
  /// **'Current'**
  String get accountTypeCurrent;

  /// No description provided for @accountTypeCreditCard.
  ///
  /// In en, this message translates to:
  /// **'Credit Card'**
  String get accountTypeCreditCard;

  /// No description provided for @accountTypeBank.
  ///
  /// In en, this message translates to:
  /// **'Bank'**
  String get accountTypeBank;

  /// No description provided for @accountTypeInvestment.
  ///
  /// In en, this message translates to:
  /// **'Investment'**
  String get accountTypeInvestment;

  /// No description provided for @accountTypeLoan.
  ///
  /// In en, this message translates to:
  /// **'Loan'**
  String get accountTypeLoan;

  /// No description provided for @accountTypeOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get accountTypeOther;

  /// No description provided for @selectLabel.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get selectLabel;

  /// No description provided for @changeLabel.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get changeLabel;

  /// No description provided for @notSelected.
  ///
  /// In en, this message translates to:
  /// **'Not selected'**
  String get notSelected;

  /// No description provided for @dayLabel.
  ///
  /// In en, this message translates to:
  /// **'Day {day}'**
  String dayLabel(int day);

  /// No description provided for @step1Title.
  ///
  /// In en, this message translates to:
  /// **'Step 1 of 2'**
  String get step1Title;

  /// No description provided for @step1Subtitle.
  ///
  /// In en, this message translates to:
  /// **'Basic Details'**
  String get step1Subtitle;

  /// No description provided for @step2Title.
  ///
  /// In en, this message translates to:
  /// **'Step 2 of 2'**
  String get step2Title;

  /// No description provided for @step2Subtitle.
  ///
  /// In en, this message translates to:
  /// **'Additional Details'**
  String get step2Subtitle;

  /// No description provided for @titleOptionalLabel.
  ///
  /// In en, this message translates to:
  /// **'Title (Optional)'**
  String get titleOptionalLabel;

  /// No description provided for @titleHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., Grocery shopping'**
  String get titleHint;

  /// No description provided for @nextButton.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get nextButton;

  /// No description provided for @selectAccountLabel.
  ///
  /// In en, this message translates to:
  /// **'Select Account'**
  String get selectAccountLabel;

  /// No description provided for @noAccountsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No accounts available'**
  String get noAccountsAvailable;

  /// No description provided for @selectedLabel.
  ///
  /// In en, this message translates to:
  /// **'Selected'**
  String get selectedLabel;

  /// No description provided for @tagsLabel.
  ///
  /// In en, this message translates to:
  /// **'Tags'**
  String get tagsLabel;

  /// No description provided for @addTagLabel.
  ///
  /// In en, this message translates to:
  /// **'Add Tag'**
  String get addTagLabel;

  /// No description provided for @notesLabel.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notesLabel;

  /// No description provided for @notesHint.
  ///
  /// In en, this message translates to:
  /// **'Add notes about this transaction'**
  String get notesHint;

  /// No description provided for @enterAmountError.
  ///
  /// In en, this message translates to:
  /// **'Please enter an amount'**
  String get enterAmountError;

  /// No description provided for @validAmountError.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid amount'**
  String get validAmountError;

  /// No description provided for @selectAccountError.
  ///
  /// In en, this message translates to:
  /// **'Please select an account'**
  String get selectAccountError;

  /// No description provided for @transactionAddedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Transaction added successfully!'**
  String get transactionAddedSuccess;

  /// No description provided for @termsTitle.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get termsTitle;

  /// No description provided for @termsAcceptanceTitle.
  ///
  /// In en, this message translates to:
  /// **'1. Acceptance of Terms'**
  String get termsAcceptanceTitle;

  /// No description provided for @termsAcceptanceContent.
  ///
  /// In en, this message translates to:
  /// **'By downloading, installing, or using CashFlow, you agree to be bound by these Terms and Conditions. If you do not agree to these terms, please do not use the app.'**
  String get termsAcceptanceContent;

  /// No description provided for @termsLicenseTitle.
  ///
  /// In en, this message translates to:
  /// **'2. License'**
  String get termsLicenseTitle;

  /// No description provided for @termsLicenseContent.
  ///
  /// In en, this message translates to:
  /// **'We grant you a limited, non-exclusive, non-transferable license to use CashFlow for personal, non-commercial purposes. You may not:\n\n• Modify or reverse engineer the app\n• Distribute or sell copies of the app\n• Remove any copyright or proprietary notices\n• Use the app for illegal purposes'**
  String get termsLicenseContent;

  /// No description provided for @termsUserRespTitle.
  ///
  /// In en, this message translates to:
  /// **'3. User Responsibilities'**
  String get termsUserRespTitle;

  /// No description provided for @termsUserRespContent.
  ///
  /// In en, this message translates to:
  /// **'You are responsible for:\n\n• Maintaining the accuracy of your financial data\n• Keeping your device secure\n• Backing up your data regularly\n• Complying with applicable laws and regulations'**
  String get termsUserRespContent;

  /// No description provided for @termsDisclaimerTitle.
  ///
  /// In en, this message translates to:
  /// **'4. Disclaimer of Warranties'**
  String get termsDisclaimerTitle;

  /// No description provided for @termsDisclaimerContent.
  ///
  /// In en, this message translates to:
  /// **'CashFlow is provided \"as is\" without warranties of any kind. We do not guarantee that:\n\n• The app will be error-free or uninterrupted\n• All features will work on all devices\n• The app will meet your specific requirements\n• Data will never be lost (please backup regularly)'**
  String get termsDisclaimerContent;

  /// No description provided for @termsLiabilityTitle.
  ///
  /// In en, this message translates to:
  /// **'5. Limitation of Liability'**
  String get termsLiabilityTitle;

  /// No description provided for @termsLiabilityContent.
  ///
  /// In en, this message translates to:
  /// **'To the maximum extent permitted by law, we shall not be liable for:\n\n• Any loss of data or financial information\n• Indirect, incidental, or consequential damages\n• Any damages arising from use or inability to use the app\n• Financial decisions made based on app data'**
  String get termsLiabilityContent;

  /// No description provided for @termsAdviceTitle.
  ///
  /// In en, this message translates to:
  /// **'6. Financial Advice Disclaimer'**
  String get termsAdviceTitle;

  /// No description provided for @termsAdviceContent.
  ///
  /// In en, this message translates to:
  /// **'CashFlow is a tool for tracking and organizing your finances. It does not provide financial, investment, or tax advice. Always consult with qualified professionals for financial decisions.'**
  String get termsAdviceContent;

  /// No description provided for @termsAccuracyTitle.
  ///
  /// In en, this message translates to:
  /// **'7. Data Accuracy'**
  String get termsAccuracyTitle;

  /// No description provided for @termsAccuracyContent.
  ///
  /// In en, this message translates to:
  /// **'While we strive to provide accurate calculations and reports, you are responsible for verifying all financial data. We are not liable for any errors in calculations or reports.'**
  String get termsAccuracyContent;

  /// No description provided for @termsUpdatesTitle.
  ///
  /// In en, this message translates to:
  /// **'8. Updates and Modifications'**
  String get termsUpdatesTitle;

  /// No description provided for @termsUpdatesContent.
  ///
  /// In en, this message translates to:
  /// **'We reserve the right to:\n\n• Update or modify the app at any time\n• Add or remove features\n• Change these terms and conditions\n• Discontinue the app (with reasonable notice)'**
  String get termsUpdatesContent;

  /// No description provided for @termsIPTitle.
  ///
  /// In en, this message translates to:
  /// **'9. Intellectual Property'**
  String get termsIPTitle;

  /// No description provided for @termsIPContent.
  ///
  /// In en, this message translates to:
  /// **'All content, features, and functionality of CashFlow are owned by us and protected by copyright, trademark, and other intellectual property laws.'**
  String get termsIPContent;

  /// No description provided for @termsTerminationTitle.
  ///
  /// In en, this message translates to:
  /// **'10. Termination'**
  String get termsTerminationTitle;

  /// No description provided for @termsTerminationContent.
  ///
  /// In en, this message translates to:
  /// **'You may stop using the app at any time by uninstalling it. We reserve the right to terminate or restrict access to the app for violation of these terms.'**
  String get termsTerminationContent;

  /// No description provided for @termsGoverningTitle.
  ///
  /// In en, this message translates to:
  /// **'11. Governing Law'**
  String get termsGoverningTitle;

  /// No description provided for @termsGoverningContent.
  ///
  /// In en, this message translates to:
  /// **'These terms shall be governed by and construed in accordance with applicable local laws, without regard to conflict of law provisions.'**
  String get termsGoverningContent;

  /// No description provided for @termsContactTitle.
  ///
  /// In en, this message translates to:
  /// **'12. Contact Information'**
  String get termsContactTitle;

  /// No description provided for @termsContactContent.
  ///
  /// In en, this message translates to:
  /// **'For questions about these terms, please contact us through the app\'s support section.'**
  String get termsContactContent;

  /// No description provided for @termsFooter.
  ///
  /// In en, this message translates to:
  /// **'By using CashFlow, you acknowledge that you have read, understood, and agree to be bound by these Terms and Conditions.'**
  String get termsFooter;

  /// No description provided for @addFirstAccount.
  ///
  /// In en, this message translates to:
  /// **'Tap + to add your first account'**
  String get addFirstAccount;

  /// No description provided for @notificationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsTitle;

  /// No description provided for @clearAll.
  ///
  /// In en, this message translates to:
  /// **'Clear All'**
  String get clearAll;

  /// No description provided for @noNotificationsYet.
  ///
  /// In en, this message translates to:
  /// **'No notifications yet'**
  String get noNotificationsYet;

  /// No description provided for @justNow.
  ///
  /// In en, this message translates to:
  /// **'Just now'**
  String get justNow;

  /// No description provided for @minutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{minutes}m ago'**
  String minutesAgo(int minutes);

  /// No description provided for @hoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{hours}h ago'**
  String hoursAgo(int hours);

  /// No description provided for @daysAgo.
  ///
  /// In en, this message translates to:
  /// **'{days}d ago'**
  String daysAgo(int days);

  /// No description provided for @accountDeleted.
  ///
  /// In en, this message translates to:
  /// **'Account deleted'**
  String get accountDeleted;

  /// No description provided for @accountDeletedWithTransactions.
  ///
  /// In en, this message translates to:
  /// **'Account deleted along with {count} transaction{s}'**
  String accountDeletedWithTransactions(int count, String s);

  /// No description provided for @noDataAvailable.
  ///
  /// In en, this message translates to:
  /// **'No data available'**
  String get noDataAvailable;

  /// No description provided for @addAccountsAndTransactions.
  ///
  /// In en, this message translates to:
  /// **'Add accounts and transactions to see reports'**
  String get addAccountsAndTransactions;

  /// No description provided for @expenseBreakdown.
  ///
  /// In en, this message translates to:
  /// **'Expense Breakdown'**
  String get expenseBreakdown;

  /// No description provided for @noExpensesForPeriod.
  ///
  /// In en, this message translates to:
  /// **'No expenses for this period'**
  String get noExpensesForPeriod;

  /// No description provided for @generatingPdf.
  ///
  /// In en, this message translates to:
  /// **'Generating PDF to share...'**
  String get generatingPdf;

  /// No description provided for @errorSharingPdf.
  ///
  /// In en, this message translates to:
  /// **'Error sharing PDF: {error}'**
  String errorSharingPdf(String error);

  /// No description provided for @backButton.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get backButton;

  /// No description provided for @summaryLabel.
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get summaryLabel;

  /// No description provided for @typeLabel.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get typeLabel;

  /// No description provided for @tagsOptionalLabel.
  ///
  /// In en, this message translates to:
  /// **'Tags (Optional)'**
  String get tagsOptionalLabel;

  /// No description provided for @paymentModeLabel.
  ///
  /// In en, this message translates to:
  /// **'Payment Mode'**
  String get paymentModeLabel;

  /// No description provided for @paymentModeCash.
  ///
  /// In en, this message translates to:
  /// **'Cash'**
  String get paymentModeCash;

  /// No description provided for @paymentModeCreditCard.
  ///
  /// In en, this message translates to:
  /// **'Credit Card'**
  String get paymentModeCreditCard;

  /// No description provided for @paymentModeDebitCard.
  ///
  /// In en, this message translates to:
  /// **'Debit Card'**
  String get paymentModeDebitCard;

  /// No description provided for @paymentModeUPI.
  ///
  /// In en, this message translates to:
  /// **'UPI'**
  String get paymentModeUPI;

  /// No description provided for @paymentModeNetBanking.
  ///
  /// In en, this message translates to:
  /// **'Net Banking'**
  String get paymentModeNetBanking;

  /// No description provided for @paymentModeOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get paymentModeOther;

  /// No description provided for @categoryFood.
  ///
  /// In en, this message translates to:
  /// **'Food'**
  String get categoryFood;

  /// No description provided for @categoryTransport.
  ///
  /// In en, this message translates to:
  /// **'Transport'**
  String get categoryTransport;

  /// No description provided for @categoryShopping.
  ///
  /// In en, this message translates to:
  /// **'Shopping'**
  String get categoryShopping;

  /// No description provided for @categoryBills.
  ///
  /// In en, this message translates to:
  /// **'Bills'**
  String get categoryBills;

  /// No description provided for @categoryEntertainment.
  ///
  /// In en, this message translates to:
  /// **'Entertainment'**
  String get categoryEntertainment;

  /// No description provided for @categoryHealth.
  ///
  /// In en, this message translates to:
  /// **'Health'**
  String get categoryHealth;

  /// No description provided for @categoryOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get categoryOther;

  /// No description provided for @categorySalary.
  ///
  /// In en, this message translates to:
  /// **'Salary'**
  String get categorySalary;

  /// No description provided for @categoryFreelance.
  ///
  /// In en, this message translates to:
  /// **'Freelance'**
  String get categoryFreelance;

  /// No description provided for @categoryBusiness.
  ///
  /// In en, this message translates to:
  /// **'Business'**
  String get categoryBusiness;

  /// No description provided for @categoryInvestment.
  ///
  /// In en, this message translates to:
  /// **'Investment'**
  String get categoryInvestment;

  /// No description provided for @categoryGift.
  ///
  /// In en, this message translates to:
  /// **'Gift'**
  String get categoryGift;

  /// No description provided for @addCategoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Category'**
  String get addCategoryTitle;

  /// No description provided for @editCategoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Category'**
  String get editCategoryTitle;

  /// No description provided for @categoryNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Category Name'**
  String get categoryNameLabel;

  /// No description provided for @categoryNameError.
  ///
  /// In en, this message translates to:
  /// **'Please enter a category name'**
  String get categoryNameError;

  /// No description provided for @selectIconLabel.
  ///
  /// In en, this message translates to:
  /// **'Select Icon'**
  String get selectIconLabel;

  /// No description provided for @selectColorLabel.
  ///
  /// In en, this message translates to:
  /// **'Select Color'**
  String get selectColorLabel;

  /// No description provided for @previewLabel.
  ///
  /// In en, this message translates to:
  /// **'Preview'**
  String get previewLabel;

  /// No description provided for @saveCategoryButton.
  ///
  /// In en, this message translates to:
  /// **'Save Category'**
  String get saveCategoryButton;

  /// No description provided for @addRecurringTitle.
  ///
  /// In en, this message translates to:
  /// **'New Recurring'**
  String get addRecurringTitle;

  /// No description provided for @editRecurringTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Recurring'**
  String get editRecurringTitle;

  /// No description provided for @transactionDetailsLabel.
  ///
  /// In en, this message translates to:
  /// **'Transaction Details'**
  String get transactionDetailsLabel;

  /// No description provided for @frequencyLabel.
  ///
  /// In en, this message translates to:
  /// **'Frequency'**
  String get frequencyLabel;

  /// No description provided for @frequencyDaily.
  ///
  /// In en, this message translates to:
  /// **'Daily'**
  String get frequencyDaily;

  /// No description provided for @frequencyWeekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get frequencyWeekly;

  /// No description provided for @frequencyMonthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get frequencyMonthly;

  /// No description provided for @frequencyYearly.
  ///
  /// In en, this message translates to:
  /// **'Yearly'**
  String get frequencyYearly;

  /// No description provided for @startDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Start Date / Next Due'**
  String get startDateLabel;

  /// No description provided for @autoAddLabel.
  ///
  /// In en, this message translates to:
  /// **'Auto-add Transaction'**
  String get autoAddLabel;

  /// No description provided for @autoAddSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Automatically create on due date'**
  String get autoAddSubtitle;

  /// No description provided for @saveRecurringButton.
  ///
  /// In en, this message translates to:
  /// **'Save Recurring'**
  String get saveRecurringButton;

  /// No description provided for @errorSavingRecurring.
  ///
  /// In en, this message translates to:
  /// **'Error saving recurring transaction: {error}'**
  String errorSavingRecurring(String error);

  /// No description provided for @daily.
  ///
  /// In en, this message translates to:
  /// **'Daily'**
  String get daily;

  /// No description provided for @monthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get monthly;

  /// No description provided for @balance.
  ///
  /// In en, this message translates to:
  /// **'Balance'**
  String get balance;

  /// No description provided for @monthlyFinancialReport.
  ///
  /// In en, this message translates to:
  /// **'Monthly Financial Report'**
  String get monthlyFinancialReport;

  /// No description provided for @generatedOn.
  ///
  /// In en, this message translates to:
  /// **'Generated on {date}'**
  String generatedOn(String date);

  /// No description provided for @netBalance.
  ///
  /// In en, this message translates to:
  /// **'Net Balance'**
  String get netBalance;

  /// No description provided for @dateHeader.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get dateHeader;

  /// No description provided for @modeHeader.
  ///
  /// In en, this message translates to:
  /// **'Mode'**
  String get modeHeader;

  /// No description provided for @descriptionHeader.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get descriptionHeader;

  /// No description provided for @amountHeader.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amountHeader;

  /// No description provided for @dataManagement.
  ///
  /// In en, this message translates to:
  /// **'Data Management'**
  String get dataManagement;

  /// No description provided for @backupData.
  ///
  /// In en, this message translates to:
  /// **'Backup Data'**
  String get backupData;

  /// No description provided for @restoreData.
  ///
  /// In en, this message translates to:
  /// **'Restore Data'**
  String get restoreData;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'bn',
    'de',
    'en',
    'es',
    'fa',
    'fr',
    'gu',
    'hi',
    'id',
    'it',
    'ja',
    'kn',
    'ko',
    'ml',
    'mr',
    'pl',
    'pt',
    'ru',
    'ta',
    'te',
    'th',
    'tr',
    'ur',
    'vi',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+script codes are specified.
  switch (locale.languageCode) {
    case 'zh':
      {
        switch (locale.scriptCode) {
          case 'Hant':
            return AppLocalizationsZhHant();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'bn':
      return AppLocalizationsBn();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fa':
      return AppLocalizationsFa();
    case 'fr':
      return AppLocalizationsFr();
    case 'gu':
      return AppLocalizationsGu();
    case 'hi':
      return AppLocalizationsHi();
    case 'id':
      return AppLocalizationsId();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'kn':
      return AppLocalizationsKn();
    case 'ko':
      return AppLocalizationsKo();
    case 'ml':
      return AppLocalizationsMl();
    case 'mr':
      return AppLocalizationsMr();
    case 'pl':
      return AppLocalizationsPl();
    case 'pt':
      return AppLocalizationsPt();
    case 'ru':
      return AppLocalizationsRu();
    case 'ta':
      return AppLocalizationsTa();
    case 'te':
      return AppLocalizationsTe();
    case 'th':
      return AppLocalizationsTh();
    case 'tr':
      return AppLocalizationsTr();
    case 'ur':
      return AppLocalizationsUr();
    case 'vi':
      return AppLocalizationsVi();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
