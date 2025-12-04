// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'CashFlow';

  @override
  String get dashboard => 'ダッシュボード';

  @override
  String get transactions => '取引';

  @override
  String get accounts => '口座';

  @override
  String get more => 'その他';

  @override
  String get selectLanguage => '言語を選択';

  @override
  String get searchLanguage => '言語を検索...';

  @override
  String get save => '保存';

  @override
  String get cancel => 'キャンセル';

  @override
  String get profile => 'プロフィール';

  @override
  String get settings => '設定';

  @override
  String get logout => 'ログアウト';

  @override
  String get login => 'ログイン';

  @override
  String get signup => 'サインアップ';

  @override
  String get firstName => '名';

  @override
  String get lastName => '姓';

  @override
  String get username => 'ユーザー名';

  @override
  String get password => 'パスワード';

  @override
  String get confirmPassword => 'パスワードを確認';

  @override
  String get email => 'メール';

  @override
  String get phoneNumber => '電話番号';

  @override
  String get currency => '通貨';

  @override
  String get language => '言語';

  @override
  String get theme => 'テーマ';

  @override
  String get notifications => '通知';

  @override
  String get helpAndSupport => 'ヘルプとサポート';

  @override
  String get privacyPolicy => 'プライバシーポリシー';

  @override
  String get termsAndConditions => '利用規約';

  @override
  String get about => 'アプリについて';

  @override
  String get version => 'バージョン';

  @override
  String get createAccount => 'アカウントを作成';

  @override
  String get alreadyHaveAccount => 'すでにアカウントをお持ちですか？ ';

  @override
  String get whyNeedSignup => 'なぜサインアップが必要なのですか？';

  @override
  String get hello => 'こんにちは';

  @override
  String get welcomeBack => 'お帰りなさい';

  @override
  String get netWorth => '純資産';

  @override
  String get financialPlanning => 'ファイナンシャルプランニング';

  @override
  String get budgets => '予算';

  @override
  String get goals => '目標';

  @override
  String get categories => 'カテゴリ';

  @override
  String get recurring => '定期的な取引';

  @override
  String get calendar => 'カレンダー';

  @override
  String get insights => '分析';

  @override
  String get tags => 'タグ';

  @override
  String get myAccounts => '私の口座';

  @override
  String get noAccountsYet => '口座はまだありません';

  @override
  String get overview => '概要';

  @override
  String get topExpenses => '主な支出';

  @override
  String get noExpensesYet => '支出はまだありません';

  @override
  String get recentTransactions => '最近の取引';

  @override
  String get viewAll => 'すべて表示';

  @override
  String get noRecentTransactions => '最近の取引はありません';

  @override
  String get filterByTags => 'タグでフィルタ';

  @override
  String get clear => 'クリア';

  @override
  String get noTagsAvailable => '利用可能なタグはありません';

  @override
  String get done => '完了';

  @override
  String get allTransactions => 'すべての取引';

  @override
  String get all => 'すべて';

  @override
  String get income => '収入';

  @override
  String get expense => '支出';

  @override
  String get noTransactionsFound => '取引が見つかりません';

  @override
  String get deleteTransaction => '取引を削除';

  @override
  String deleteTransactionConfirmation(Object title) {
    return '「$title」を削除してもよろしいですか？';
  }

  @override
  String get transactionDeleted => '取引が削除されました';

  @override
  String get statistics => '統計';

  @override
  String get allAccounts => 'すべての口座';

  @override
  String get incomeVsExpense => '収入と支出';

  @override
  String get financialTrend => '財務トレンド（過去6ヶ月）';

  @override
  String get totalIncome => '総収入';

  @override
  String get totalExpense => '総支出';

  @override
  String get totalBalance => '総残高';

  @override
  String get spendingByTags => 'タグ別の支出';

  @override
  String get accountBreakdown => '口座の内訳';

  @override
  String get noAccountsFound => '口座が見つかりません';

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
      'このプライバシーポリシーについてご質問がある場合は、アプリのサポートセクションからお問い合わせください。';

  @override
  String get addTransactionTitle => '取引を追加';

  @override
  String get editTransactionTitle => '取引を編集';

  @override
  String get amountLabel => '金額';

  @override
  String get amountHint => '0.00';

  @override
  String get titleLabel => 'タイトル';

  @override
  String get categoryLabel => 'カテゴリ';

  @override
  String get dateLabel => '日付';

  @override
  String get chooseDate => '日付を選択';

  @override
  String get saveTransaction => '取引を保存';

  @override
  String get noAccountsMessage => '取引を作成する前に、少なくとも1つの口座を追加する必要があります。';

  @override
  String get addAccountAction => '口座を追加';

  @override
  String get incomeMessage1 => '🎉 銀行にお金が入りました！';

  @override
  String get incomeMessage2 => '💰 チャリーン！どんどん入ってきます！';

  @override
  String get incomeMessage3 => '✨ お財布が喜んでいます！';

  @override
  String get incomeMessage4 => '🚀 月まで届け！';

  @override
  String get incomeMessage5 => '💸 積み上げましょう！';

  @override
  String get incomeMessage6 => '🔥 絶好調ですね！';

  @override
  String get incomeMessage7 => '⭐ お金の雨が降っています！';

  @override
  String get incomeMessage8 => '💎 ダイヤモンドハンド！';

  @override
  String get addAccountTitle => '口座を追加';

  @override
  String get editAccountTitle => '口座を編集';

  @override
  String get accountDetails => '口座の詳細';

  @override
  String get accountNameLabel => '口座名';

  @override
  String get accountNameHint => '例：メインウォレット';

  @override
  String get accountNameError => '名前を入力してください';

  @override
  String get accountTypeLabel => '口座の種類';

  @override
  String get initialBalanceLabel => '開始残高';

  @override
  String get currentBalanceLabel => '現在の残高';

  @override
  String get creditLimitLabel => '利用限度額';

  @override
  String get balanceHint => '0.00';

  @override
  String get balanceError => '残高を入力してください';

  @override
  String get validNumberError => '有効な数値を入力してください';

  @override
  String get bankDetails => '銀行の詳細';

  @override
  String get cardDetails => 'カードの詳細';

  @override
  String get bankNameLabel => '銀行名';

  @override
  String get cardIssuerLabel => 'カード発行会社 / 銀行';

  @override
  String get bankNameHint => '例：三菱UFJ銀行';

  @override
  String get bankNameError => '銀行名を入力してください';

  @override
  String get cardIssuerError => 'カード発行会社を入力してください';

  @override
  String get accountNumberLabel => '口座番号';

  @override
  String get cardNumberLabel => 'カード番号（下4桁）';

  @override
  String get accountNumberHint => 'XXXX1234';

  @override
  String get cardNumberHint => '1234';

  @override
  String get cardNumberError => '下4桁を入力してください';

  @override
  String get cardNumberLengthError => '正確に4桁入力してください';

  @override
  String get loanDetails => 'ローンの詳細';

  @override
  String get loanPrincipalLabel => 'ローン元金';

  @override
  String get loanPrincipalError => '元金を入力してください';

  @override
  String get interestRateLabel => '金利（年率％）';

  @override
  String get interestRateError => '金利を入力してください';

  @override
  String get loanTenureLabel => 'ローン期間（月）';

  @override
  String get loanTenureError => '期間を入力してください';

  @override
  String get emiAmountLabel => 'EMI金額';

  @override
  String get emiAmountError => 'EMI金額を入力してください';

  @override
  String get loanStartDateLabel => 'ローン開始日';

  @override
  String get emiPaymentDayLabel => 'EMI支払日';

  @override
  String get emisPaidLabel => '支払い済みEMI';

  @override
  String get emisPaidError => '支払い済みEMIを入力してください';

  @override
  String get emisPendingLabel => '保留中のEMI（計算済み）';

  @override
  String get appearanceLabel => '外観';

  @override
  String get colorLabel => '色';

  @override
  String get iconLabel => 'アイコン';

  @override
  String get createAccountButton => '口座を作成';

  @override
  String get saveChangesButton => '変更を保存';

  @override
  String get cancelButton => 'キャンセル';

  @override
  String get deleteAccountTitle => '口座を削除';

  @override
  String deleteAccountMessage(String accountName) {
    return '本当に「$accountName」を削除しますか？この操作は元に戻せません。';
  }

  @override
  String deleteAccountWarning(String accountName, int count) {
    return '本当に「$accountName」を削除しますか？これにより、関連する$count件の取引も削除されます。';
  }

  @override
  String get deleteButton => '削除';

  @override
  String get accountUpdatedSuccess => '口座が正常に更新されました';

  @override
  String accountUpdateError(String error) {
    return '口座の更新中にエラーが発生しました：$error';
  }

  @override
  String get accountTypeCash => '現金';

  @override
  String get accountTypeSavings => '普通預金';

  @override
  String get accountTypeSalary => '給与';

  @override
  String get accountTypeCurrent => '当座預金';

  @override
  String get accountTypeCreditCard => 'クレジットカード';

  @override
  String get accountTypeBank => '銀行';

  @override
  String get accountTypeInvestment => '投資';

  @override
  String get accountTypeLoan => 'ローン';

  @override
  String get accountTypeOther => 'その他';

  @override
  String get selectLabel => '選択';

  @override
  String get changeLabel => '変更';

  @override
  String get notSelected => '未選択';

  @override
  String dayLabel(int day) {
    return '$day日';
  }

  @override
  String get step1Title => 'ステップ 1 / 2';

  @override
  String get step1Subtitle => '基本詳細';

  @override
  String get step2Title => 'ステップ 2 / 2';

  @override
  String get step2Subtitle => '追加詳細';

  @override
  String get titleOptionalLabel => 'タイトル（オプション）';

  @override
  String get titleHint => '例：食料品の買い物';

  @override
  String get nextButton => '次へ';

  @override
  String get selectAccountLabel => '口座を選択';

  @override
  String get noAccountsAvailable => '利用可能な口座がありません';

  @override
  String get selectedLabel => '選択済み';

  @override
  String get tagsLabel => 'タグ';

  @override
  String get addTagLabel => 'タグを追加';

  @override
  String get notesLabel => 'メモ';

  @override
  String get notesHint => 'この取引に関するメモを追加';

  @override
  String get enterAmountError => '金額を入力してください';

  @override
  String get validAmountError => '有効な金額を入力してください';

  @override
  String get selectAccountError => '口座を選択してください';

  @override
  String get transactionAddedSuccess => '取引が正常に追加されました！';

  @override
  String get termsTitle => '利用規約';

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
