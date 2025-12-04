// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get appTitle => 'CashFlow';

  @override
  String get dashboard => 'Pulpit';

  @override
  String get transactions => 'Transakcje';

  @override
  String get accounts => 'Konta';

  @override
  String get more => 'Więcej';

  @override
  String get selectLanguage => 'Wybierz język';

  @override
  String get searchLanguage => 'Szukaj języka...';

  @override
  String get save => 'Zapisz';

  @override
  String get cancel => 'Anuluj';

  @override
  String get profile => 'Profil';

  @override
  String get settings => 'Ustawienia';

  @override
  String get logout => 'Wyloguj';

  @override
  String get login => 'Zaloguj';

  @override
  String get signup => 'Zarejestruj się';

  @override
  String get firstName => 'Imię';

  @override
  String get lastName => 'Nazwisko';

  @override
  String get username => 'Nazwa użytkownika';

  @override
  String get password => 'Hasło';

  @override
  String get confirmPassword => 'Potwierdź hasło';

  @override
  String get email => 'Email';

  @override
  String get phoneNumber => 'Numer telefonu';

  @override
  String get currency => 'Waluta';

  @override
  String get language => 'Język';

  @override
  String get theme => 'Motyw';

  @override
  String get notifications => 'Powiadomienia';

  @override
  String get helpAndSupport => 'Help & Support';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get termsAndConditions => 'Terms & Conditions';

  @override
  String get about => 'About';

  @override
  String get version => 'Wersja';

  @override
  String get createAccount => 'Utwórz konto';

  @override
  String get alreadyHaveAccount => 'Masz już konto? ';

  @override
  String get whyNeedSignup => 'Dlaczego muszę się zarejestrować?';

  @override
  String get hello => 'Cześć';

  @override
  String get welcomeBack => 'Witaj ponownie';

  @override
  String get netWorth => 'Wartość netto';

  @override
  String get financialPlanning => 'Planowanie finansowe';

  @override
  String get budgets => 'Budżety';

  @override
  String get goals => 'Cele';

  @override
  String get categories => 'Kategorie';

  @override
  String get recurring => 'Cykliczne';

  @override
  String get calendar => 'Kalendarz';

  @override
  String get insights => 'Spostrzeżenia';

  @override
  String get tags => 'Tagi';

  @override
  String get myAccounts => 'Moje konta';

  @override
  String get noAccountsYet => 'Brak kont';

  @override
  String get overview => 'Przegląd';

  @override
  String get topExpenses => 'Największe wydatki';

  @override
  String get noExpensesYet => 'Brak wydatków';

  @override
  String get recentTransactions => 'Ostatnie transakcje';

  @override
  String get viewAll => 'Zobacz wszystko';

  @override
  String get noRecentTransactions => 'Brak ostatnich transakcji';

  @override
  String get filterByTags => 'Filtruj według tagów';

  @override
  String get clear => 'Wyczyść';

  @override
  String get noTagsAvailable => 'Brak dostępnych tagów';

  @override
  String get done => 'Gotowe';

  @override
  String get allTransactions => 'Wszystkie transakcje';

  @override
  String get all => 'Wszystkie';

  @override
  String get income => 'Dochód';

  @override
  String get expense => 'Wydatek';

  @override
  String get noTransactionsFound => 'Nie znaleziono transakcji';

  @override
  String get deleteTransaction => 'Usuń transakcję';

  @override
  String deleteTransactionConfirmation(Object title) {
    return 'Czy na pewno chcesz usunąć \"$title\"?';
  }

  @override
  String get transactionDeleted => 'Transakcja usunięta';

  @override
  String get statistics => 'Statystyki';

  @override
  String get allAccounts => 'Wszystkie konta';

  @override
  String get incomeVsExpense => 'Dochód vs Wydatek';

  @override
  String get financialTrend => 'Trend finansowy (Ostatnie 6 miesięcy)';

  @override
  String get totalIncome => 'Całkowity dochód';

  @override
  String get totalExpense => 'Całkowity wydatek';

  @override
  String get totalBalance => 'Całkowite saldo';

  @override
  String get spendingByTags => 'Wydatki według tagów';

  @override
  String get accountBreakdown => 'Podział konta';

  @override
  String get noAccountsFound => 'Nie znaleziono kont';

  @override
  String get monthlyReport => 'Monthly Report';

  @override
  String get loginWelcome => 'Welcome to CashFlow';

  @override
  String get loginSubtitle => 'Sign in to continue';

  @override
  String get whyLoginTitle => 'Why Login?';

  @override
  String get whyLoginContent =>
      'Even though your data is stored locally on your device, we use a login system to secure your financial information from unauthorized access by others who might use your phone.';

  @override
  String get whyLoginAction => 'Got it';

  @override
  String get whyLoginLink => 'Why do I need to login?';

  @override
  String get usernameHint => 'Username';

  @override
  String get passwordHint => 'Password';

  @override
  String get loginButton => 'Login';

  @override
  String get noAccount => 'Don\'t have an account? ';

  @override
  String get signUpLink => 'Sign Up';

  @override
  String get invalidCredentials => 'Invalid credentials';

  @override
  String get resetDataMessage => 'App data reset. You can now sign up.';

  @override
  String get faqTitle => 'FAQ';

  @override
  String get faqSearchHint => 'Search FAQ...';

  @override
  String get faqNoResults => 'No results found';

  @override
  String get faqQ1 => 'How do I create a new account?';

  @override
  String get faqA1 =>
      'Go to the Accounts tab and tap the \"+\" button. Enter your account name, select an icon and color, then set the initial balance. You can create multiple accounts for different purposes like bank accounts, cash, credit cards, etc.';

  @override
  String get faqQ2 => 'How do I add a transaction?';

  @override
  String get faqA2 =>
      'Tap the \"+\" floating action button on the home screen. Select whether it\'s income or expense, enter the amount, title, category, and date. Make sure you have at least one account created before adding transactions.';

  @override
  String get faqQ3 => 'Can I edit or delete transactions?';

  @override
  String get faqA3 =>
      'Yes! Go to the Transactions screen, find the transaction you want to modify, and tap on it. You can either edit the details or delete it using the delete button.';

  @override
  String get faqQ4 => 'What are categories and how do I use them?';

  @override
  String get faqA4 =>
      'Categories help you organize your transactions. For expenses, you can use categories like Food, Transport, Shopping, Bills, etc. For income, categories include Salary, Freelance, Business, etc. Select the appropriate category when adding a transaction.';

  @override
  String get faqQ5 => 'How do I create and manage budgets?';

  @override
  String get faqA5 =>
      'Go to the Budgets screen from the dashboard. Tap \"+\" to create a new budget. You can set a limit for a specific category and time period (weekly, monthly, etc.). To edit or delete, tap on an existing budget.';

  @override
  String get faqQ6 => 'How do I set financial goals?';

  @override
  String get faqA6 =>
      'Navigate to the Goals screen. Tap \"+\" to add a goal (e.g., \"New Car\"). Set a target amount and target date. You can then \"Add Funds\" to the goal from your accounts to track your progress.';

  @override
  String get faqQ7 => 'How do I set up recurring transactions?';

  @override
  String get faqA7 =>
      'Go to the Recurring Transactions screen. Tap \"+\" to create a new recurring income or expense. Set the amount, frequency (e.g., monthly), and next due date. You can also enable \"Auto-add\" to have them added automatically.';

  @override
  String get faqQ8 => 'How does the Calendar view work?';

  @override
  String get faqA8 =>
      'The Calendar screen shows your transactions on a monthly calendar. Dates with transactions are marked. Tapping a date shows the transactions for that specific day.';

  @override
  String get faqQ9 => 'How do I view my spending reports?';

  @override
  String get faqA9 =>
      'Navigate to the Monthly Report screen from the bottom navigation. You\'ll see charts showing your income vs expenses, category-wise breakdown, and transaction history for the selected month.';

  @override
  String get faqQ10 => 'What is Net Worth and how is it calculated?';

  @override
  String get faqA10 =>
      'Net Worth is the total of all your account balances. It\'s calculated by adding up the current balance of all your accounts. You can view the Net Worth chart on the home screen to see trends over time.';

  @override
  String get faqQ11 => 'How do I export my data?';

  @override
  String get faqA11 =>
      'Go to the Monthly Report screen and tap the export button. You can generate a PDF report of your transactions for the selected month, which can be saved or shared.';

  @override
  String get faqQ12 => 'How do I enable notifications?';

  @override
  String get faqA12 =>
      'Go to the Notifications screen from the bottom navigation. You can create custom reminders for bills, savings goals, or any other financial tasks. Set the title, time, and frequency.';

  @override
  String get faqQ13 => 'Is my data secure?';

  @override
  String get faqA13 =>
      'Yes! All your data is stored locally on your device using encrypted SQLite database. Your financial information never leaves your device unless you explicitly export it.';

  @override
  String get faqQ14 => 'Can I use the app on multiple devices?';

  @override
  String get faqA14 =>
      'Currently, the app stores data locally on your device. Cloud sync is not available yet, so data won\'t automatically transfer between devices.';

  @override
  String get faqQ15 => 'How do I backup my data?';

  @override
  String get faqA15 =>
      'You can export your monthly reports as PDF files. For complete data backup, use your device\'s backup features (iCloud for iOS, Google Drive for Android) which will include the app\'s local database.';

  @override
  String get faqQ16 => 'What should I do if I see an error?';

  @override
  String get faqA16 =>
      'Try restarting the app first. If the issue persists, check that you have the latest version installed. For persistent problems, you can reset the database from the login screen (this will delete all data, so export reports first).';

  @override
  String get faqQ17 => 'How do I update the app?';

  @override
  String get faqA17 =>
      'You can update the app from the App Store or Google Play Store.';

  @override
  String get privacyPolicyTitle => 'Privacy Policy';

  @override
  String get lastUpdated => 'Last Updated';

  @override
  String get privacyIntroTitle => '1. Introduction';

  @override
  String get privacyIntroContent =>
      'Welcome to CashFlow. We respect your privacy and are committed to protecting your personal data. This privacy policy explains how we handle your information when you use our app.';

  @override
  String get privacyDataCollectionTitle => '2. Data Collection';

  @override
  String get privacyDataCollectionContent =>
      'CashFlow stores all your financial data locally on your device. We do not collect, transmit, or store any of your personal information on external servers. The data you enter, including:\n\n• Account information\n• Transaction details\n• Personal profile information\n• Notification preferences\n\nAll remain exclusively on your device.';

  @override
  String get privacyDataStorageTitle => '3. Data Storage';

  @override
  String get privacyDataStorageContent =>
      'Your data is stored in a local SQLite database on your device. This database is encrypted and protected by your device\'s security features. We do not have access to this data.';

  @override
  String get privacyDataSharingTitle => '4. Data Sharing';

  @override
  String get privacyDataSharingContent =>
      'We do not share, sell, or transmit your data to any third parties. Your financial information remains private and under your control. The only way data leaves your device is when you explicitly export reports.';

  @override
  String get privacyPermissionsTitle => '5. Permissions';

  @override
  String get privacyPermissionsContent =>
      'The app may request the following permissions:\n\n• Storage: To save exported PDF reports\n• Notifications: To send you reminders (if enabled)\n\nThese permissions are used solely for the stated purposes and do not involve data collection.';

  @override
  String get privacyDataSecurityTitle => '6. Data Security';

  @override
  String get privacyDataSecurityContent =>
      'We implement appropriate security measures to protect your data:\n\n• Local encryption\n• Secure database storage\n• No external data transmission\n• Regular security updates';

  @override
  String get privacyYourRightsTitle => '7. Your Rights';

  @override
  String get privacyYourRightsContent =>
      'You have complete control over your data:\n\n• Access: View all your data within the app\n• Modify: Edit or delete any information\n• Export: Generate PDF reports\n• Delete: Remove all data using the reset option';

  @override
  String get privacyChildrenTitle => '8. Children\'s Privacy';

  @override
  String get privacyChildrenContent =>
      'Our app is not directed to children under 13. We do not knowingly collect data from children.';

  @override
  String get privacyChangesTitle => '9. Changes to Privacy Policy';

  @override
  String get privacyChangesContent =>
      'We may update this privacy policy from time to time. We will notify you of any changes by updating the \"Last Updated\" date.';

  @override
  String get privacyContactTitle => '10. Contact Us';

  @override
  String get privacyContactContent =>
      'Jeśli masz jakiekolwiek pytania dotyczące niniejszej polityki prywatności, skontaktuj się z nami za pośrednictwem sekcji pomocy w aplikacji.';

  @override
  String get addTransactionTitle => 'Dodaj transakcję';

  @override
  String get editTransactionTitle => 'Edytuj transakcję';

  @override
  String get amountLabel => 'Kwota';

  @override
  String get amountHint => '0.00';

  @override
  String get titleLabel => 'Tytuł';

  @override
  String get categoryLabel => 'Kategoria';

  @override
  String get dateLabel => 'Data';

  @override
  String get chooseDate => 'Wybierz datę';

  @override
  String get saveTransaction => 'Zapisz transakcję';

  @override
  String get noAccountsMessage =>
      'Musisz dodać co najmniej jedno konto przed utworzeniem transakcji.';

  @override
  String get addAccountAction => 'Dodaj konto';

  @override
  String get incomeMessage1 => '🎉 Pieniądze w banku!';

  @override
  String get incomeMessage2 => '💰 Brzęk! Niech pieniądze płyną!';

  @override
  String get incomeMessage3 => '✨ Twój portfel jest szczęśliwy!';

  @override
  String get incomeMessage4 => '🚀 Na księżyc!';

  @override
  String get incomeMessage5 => '💸 Układaj je!';

  @override
  String get incomeMessage6 => '🔥 Jesteś w ogniu!';

  @override
  String get incomeMessage7 => '⭐ Pada pieniędzmi!';

  @override
  String get incomeMessage8 => '💎 Diamentowe ręce!';

  @override
  String get addAccountTitle => 'Dodaj konto';

  @override
  String get editAccountTitle => 'Edytuj konto';

  @override
  String get accountDetails => 'Szczegóły konta';

  @override
  String get accountNameLabel => 'Nazwa konta';

  @override
  String get accountNameHint => 'Np. Główny portfel';

  @override
  String get accountNameError => 'Proszę podać nazwę';

  @override
  String get accountTypeLabel => 'Typ konta';

  @override
  String get initialBalanceLabel => 'Saldo początkowe';

  @override
  String get currentBalanceLabel => 'Obecne saldo';

  @override
  String get creditLimitLabel => 'Limit kredytowy';

  @override
  String get balanceHint => '0.00';

  @override
  String get balanceError => 'Proszę podać saldo';

  @override
  String get validNumberError => 'Proszę podać poprawną liczbę';

  @override
  String get bankDetails => 'Szczegóły banku';

  @override
  String get cardDetails => 'Szczegóły karty';

  @override
  String get bankNameLabel => 'Nazwa banku';

  @override
  String get cardIssuerLabel => 'Wydawca karty / Bank';

  @override
  String get bankNameHint => 'Np. PKO BP';

  @override
  String get bankNameError => 'Proszę podać nazwę banku';

  @override
  String get cardIssuerError => 'Proszę podać wydawcę karty';

  @override
  String get accountNumberLabel => 'Numer konta';

  @override
  String get cardNumberLabel => 'Numer karty (ostatnie 4 cyfry)';

  @override
  String get accountNumberHint => 'XXXX1234';

  @override
  String get cardNumberHint => '1234';

  @override
  String get cardNumberError => 'Proszę podać ostatnie 4 cyfry';

  @override
  String get cardNumberLengthError => 'Proszę podać dokładnie 4 cyfry';

  @override
  String get loanDetails => 'Szczegóły pożyczki';

  @override
  String get loanPrincipalLabel => 'Kwota główna pożyczki';

  @override
  String get loanPrincipalError => 'Proszę podać kwotę główną';

  @override
  String get interestRateLabel => 'Stopa procentowa (roczna %)';

  @override
  String get interestRateError => 'Proszę podać stopę procentową';

  @override
  String get loanTenureLabel => 'Okres pożyczki (miesiące)';

  @override
  String get loanTenureError => 'Proszę podać okres';

  @override
  String get emiAmountLabel => 'Kwota EMI';

  @override
  String get emiAmountError => 'Proszę podać kwotę EMI';

  @override
  String get loanStartDateLabel => 'Data rozpoczęcia pożyczki';

  @override
  String get emiPaymentDayLabel => 'Dzień płatności EMI';

  @override
  String get emisPaidLabel => 'Zapłacone EMI';

  @override
  String get emisPaidError => 'Proszę podać zapłacone EMI';

  @override
  String get emisPendingLabel => 'Oczekujące EMI (obliczone)';

  @override
  String get appearanceLabel => 'Wygląd';

  @override
  String get colorLabel => 'Kolor';

  @override
  String get iconLabel => 'Ikona';

  @override
  String get createAccountButton => 'Utwórz konto';

  @override
  String get saveChangesButton => 'Zapisz zmiany';

  @override
  String get cancelButton => 'Anuluj';

  @override
  String get deleteAccountTitle => 'Usuń konto';

  @override
  String deleteAccountMessage(String accountName) {
    return 'Czy na pewno chcesz usunąć \"$accountName\"? Tej operacji nie można cofnąć.';
  }

  @override
  String deleteAccountWarning(String accountName, int count) {
    return 'Czy na pewno chcesz usunąć \"$accountName\"? Spowoduje to również usunięcie $count transakcji z nim związanych.';
  }

  @override
  String get deleteButton => 'Usuń';

  @override
  String get accountUpdatedSuccess => 'Konto zaktualizowane pomyślnie';

  @override
  String accountUpdateError(String error) {
    return 'Błąd aktualizacji konta: $error';
  }

  @override
  String get accountTypeCash => 'Gotówka';

  @override
  String get accountTypeSavings => 'Oszczędności';

  @override
  String get accountTypeSalary => 'Wynagrodzenie';

  @override
  String get accountTypeCurrent => 'Bieżące';

  @override
  String get accountTypeCreditCard => 'Karta kredytowa';

  @override
  String get accountTypeBank => 'Bank';

  @override
  String get accountTypeInvestment => 'Inwestycje';

  @override
  String get accountTypeLoan => 'Pożyczka';

  @override
  String get accountTypeOther => 'Inne';

  @override
  String get selectLabel => 'Wybierz';

  @override
  String get changeLabel => 'Zmień';

  @override
  String get notSelected => 'Nie wybrano';

  @override
  String dayLabel(int day) {
    return '$day dzień';
  }

  @override
  String get step1Title => 'Krok 1 / 2';

  @override
  String get step1Subtitle => 'Podstawowe szczegóły';

  @override
  String get step2Title => 'Krok 2 / 2';

  @override
  String get step2Subtitle => 'Więcej szczegółów';

  @override
  String get titleOptionalLabel => 'Tytuł (opcjonalnie)';

  @override
  String get titleHint => 'Np. Zakupy spożywcze';

  @override
  String get nextButton => 'Dalej';

  @override
  String get selectAccountLabel => 'Wybierz konto';

  @override
  String get noAccountsAvailable => 'Brak dostępnych kont';

  @override
  String get selectedLabel => 'Wybrano';

  @override
  String get tagsLabel => 'Tagi';

  @override
  String get addTagLabel => 'Dodaj tag';

  @override
  String get notesLabel => 'Notatki';

  @override
  String get notesHint => 'Dodaj notatki do tej transakcji';

  @override
  String get enterAmountError => 'Proszę podać kwotę';

  @override
  String get validAmountError => 'Proszę podać poprawną kwotę';

  @override
  String get selectAccountError => 'Proszę wybrać konto';

  @override
  String get transactionAddedSuccess => 'Transakcja dodana pomyślnie!';

  @override
  String get termsTitle => 'Warunki użytkowania';

  @override
  String get termsAcceptanceTitle => '1. Acceptance of Terms';

  @override
  String get termsAcceptanceContent =>
      'By downloading, installing, or using CashFlow, you agree to be bound by these Terms and Conditions. If you do not agree to these terms, please do not use the app.';

  @override
  String get termsLicenseTitle => '2. License';

  @override
  String get termsLicenseContent =>
      'We grant you a limited, non-exclusive, non-transferable license to use CashFlow for personal, non-commercial purposes. You may not:\n\n• Modify or reverse engineer the app\n• Distribute or sell copies of the app\n• Remove any copyright or proprietary notices\n• Use the app for illegal purposes';

  @override
  String get termsUserRespTitle => '3. User Responsibilities';

  @override
  String get termsUserRespContent =>
      'You are responsible for:\n\n• Maintaining the accuracy of your financial data\n• Keeping your device secure\n• Backing up your data regularly\n• Complying with applicable laws and regulations';

  @override
  String get termsDisclaimerTitle => '4. Disclaimer of Warranties';

  @override
  String get termsDisclaimerContent =>
      'CashFlow is provided \"as is\" without warranties of any kind. We do not guarantee that:\n\n• The app will be error-free or uninterrupted\n• All features will work on all devices\n• The app will meet your specific requirements\n• Data will never be lost (please backup regularly)';

  @override
  String get termsLiabilityTitle => '5. Limitation of Liability';

  @override
  String get termsLiabilityContent =>
      'To the maximum extent permitted by law, we shall not be liable for:\n\n• Any loss of data or financial information\n• Indirect, incidental, or consequential damages\n• Any damages arising from use or inability to use the app\n• Financial decisions made based on app data';

  @override
  String get termsAdviceTitle => '6. Financial Advice Disclaimer';

  @override
  String get termsAdviceContent =>
      'CashFlow is a tool for tracking and organizing your finances. It does not provide financial, investment, or tax advice. Always consult with qualified professionals for financial decisions.';

  @override
  String get termsAccuracyTitle => '7. Data Accuracy';

  @override
  String get termsAccuracyContent =>
      'While we strive to provide accurate calculations and reports, you are responsible for verifying all financial data. We are not liable for any errors in calculations or reports.';

  @override
  String get termsUpdatesTitle => '8. Updates and Modifications';

  @override
  String get termsUpdatesContent =>
      'We reserve the right to:\n\n• Update or modify the app at any time\n• Add or remove features\n• Change these terms and conditions\n• Discontinue the app (with reasonable notice)';

  @override
  String get termsIPTitle => '9. Intellectual Property';

  @override
  String get termsIPContent =>
      'All content, features, and functionality of CashFlow are owned by us and protected by copyright, trademark, and other intellectual property laws.';

  @override
  String get termsTerminationTitle => '10. Termination';

  @override
  String get termsTerminationContent =>
      'You may stop using the app at any time by uninstalling it. We reserve the right to terminate or restrict access to the app for violation of these terms.';

  @override
  String get termsGoverningTitle => '11. Governing Law';

  @override
  String get termsGoverningContent =>
      'These terms shall be governed by and construed in accordance with applicable local laws, without regard to conflict of law provisions.';

  @override
  String get termsContactTitle => '12. Contact Information';

  @override
  String get termsContactContent =>
      'For questions about these terms, please contact us through the app\'s support section.';

  @override
  String get termsFooter =>
      'By using CashFlow, you acknowledge that you have read, understood, and agree to be bound by these Terms and Conditions.';

  @override
  String get addFirstAccount => 'Tap + to add your first account';

  @override
  String get notificationsTitle => 'Notifications';

  @override
  String get clearAll => 'Clear All';

  @override
  String get noNotificationsYet => 'No notifications yet';

  @override
  String get justNow => 'Just now';

  @override
  String minutesAgo(int minutes) {
    return '${minutes}m ago';
  }

  @override
  String hoursAgo(int hours) {
    return '${hours}h ago';
  }

  @override
  String daysAgo(int days) {
    return '${days}d ago';
  }

  @override
  String get accountDeleted => 'Account deleted';

  @override
  String accountDeletedWithTransactions(int count, String s) {
    return 'Account deleted along with $count transaction$s';
  }

  @override
  String get noDataAvailable => 'No data available';

  @override
  String get addAccountsAndTransactions =>
      'Add accounts and transactions to see reports';

  @override
  String get expenseBreakdown => 'Expense Breakdown';

  @override
  String get noExpensesForPeriod => 'No expenses for this period';

  @override
  String get generatingPdf => 'Generating PDF to share...';

  @override
  String errorSharingPdf(String error) {
    return 'Error sharing PDF: $error';
  }

  @override
  String get backButton => 'Back';

  @override
  String get summaryLabel => 'Summary';

  @override
  String get typeLabel => 'Type';

  @override
  String get tagsOptionalLabel => 'Tags (Optional)';

  @override
  String get paymentModeLabel => 'Payment Mode';

  @override
  String get paymentModeCash => 'Cash';

  @override
  String get paymentModeCreditCard => 'Credit Card';

  @override
  String get paymentModeDebitCard => 'Debit Card';

  @override
  String get paymentModeUPI => 'UPI';

  @override
  String get paymentModeNetBanking => 'Net Banking';

  @override
  String get paymentModeOther => 'Other';

  @override
  String get categoryFood => 'Food';

  @override
  String get categoryTransport => 'Transport';

  @override
  String get categoryShopping => 'Shopping';

  @override
  String get categoryBills => 'Bills';

  @override
  String get categoryEntertainment => 'Entertainment';

  @override
  String get categoryHealth => 'Health';

  @override
  String get categoryOther => 'Other';

  @override
  String get categorySalary => 'Salary';

  @override
  String get categoryFreelance => 'Freelance';

  @override
  String get categoryBusiness => 'Business';

  @override
  String get categoryInvestment => 'Investment';

  @override
  String get categoryGift => 'Gift';

  @override
  String get addCategoryTitle => 'Add Category';

  @override
  String get editCategoryTitle => 'Edit Category';

  @override
  String get categoryNameLabel => 'Category Name';

  @override
  String get categoryNameError => 'Please enter a category name';

  @override
  String get selectIconLabel => 'Select Icon';

  @override
  String get selectColorLabel => 'Select Color';

  @override
  String get previewLabel => 'Preview';

  @override
  String get saveCategoryButton => 'Save Category';

  @override
  String get addRecurringTitle => 'New Recurring';

  @override
  String get editRecurringTitle => 'Edit Recurring';

  @override
  String get transactionDetailsLabel => 'Transaction Details';

  @override
  String get frequencyLabel => 'Frequency';

  @override
  String get frequencyDaily => 'Daily';

  @override
  String get frequencyWeekly => 'Weekly';

  @override
  String get frequencyMonthly => 'Monthly';

  @override
  String get frequencyYearly => 'Yearly';

  @override
  String get startDateLabel => 'Start Date / Next Due';

  @override
  String get autoAddLabel => 'Auto-add Transaction';

  @override
  String get autoAddSubtitle => 'Automatically create on due date';

  @override
  String get saveRecurringButton => 'Save Recurring';

  @override
  String errorSavingRecurring(String error) {
    return 'Error saving recurring transaction: $error';
  }

  @override
  String get daily => 'Daily';

  @override
  String get monthly => 'Monthly';

  @override
  String get balance => 'Balance';

  @override
  String get monthlyFinancialReport => 'Monthly Financial Report';

  @override
  String generatedOn(String date) {
    return 'Generated on $date';
  }

  @override
  String get netBalance => 'Net Balance';

  @override
  String get dateHeader => 'Date';

  @override
  String get modeHeader => 'Mode';

  @override
  String get descriptionHeader => 'Description';

  @override
  String get amountHeader => 'Amount';

  @override
  String get dataManagement => 'Data Management';

  @override
  String get backupData => 'Backup Data';

  @override
  String get restoreData => 'Restore Data';
}
