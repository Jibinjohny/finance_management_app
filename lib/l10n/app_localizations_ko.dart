// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => 'CashFlow';

  @override
  String get dashboard => '대시보드';

  @override
  String get transactions => '거래';

  @override
  String get accounts => '계좌';

  @override
  String get more => '더보기';

  @override
  String get selectLanguage => '언어 선택';

  @override
  String get searchLanguage => '언어 검색...';

  @override
  String get save => '저장';

  @override
  String get cancel => '취소';

  @override
  String get profile => '프로필';

  @override
  String get settings => '설정';

  @override
  String get logout => '로그아웃';

  @override
  String get login => '로그인';

  @override
  String get signup => '가입하기';

  @override
  String get firstName => '이름';

  @override
  String get lastName => '성';

  @override
  String get username => '사용자 이름';

  @override
  String get password => '비밀번호';

  @override
  String get confirmPassword => '비밀번호 확인';

  @override
  String get email => '이메일';

  @override
  String get phoneNumber => '전화번호';

  @override
  String get currency => '통화';

  @override
  String get language => '언어';

  @override
  String get theme => '테마';

  @override
  String get notifications => '알림';

  @override
  String get helpAndSupport => '도움말 및 지원';

  @override
  String get privacyPolicy => '개인정보 처리방침';

  @override
  String get termsAndConditions => '이용 약관';

  @override
  String get about => '정보';

  @override
  String get version => '버전';

  @override
  String get createAccount => '계정 만들기';

  @override
  String get alreadyHaveAccount => '이미 계정이 있으신가요? ';

  @override
  String get whyNeedSignup => '왜 가입해야 하나요?';

  @override
  String get hello => '안녕하세요';

  @override
  String get welcomeBack => '환영합니다';

  @override
  String get netWorth => '순자산';

  @override
  String get financialPlanning => '재무 계획';

  @override
  String get budgets => '예산';

  @override
  String get goals => '목표';

  @override
  String get categories => '카테고리';

  @override
  String get recurring => '반복';

  @override
  String get calendar => '달력';

  @override
  String get insights => '인사이트';

  @override
  String get tags => '태그';

  @override
  String get myAccounts => '내 계좌';

  @override
  String get noAccountsYet => '계좌가 없습니다';

  @override
  String get overview => '개요';

  @override
  String get topExpenses => '주요 지출';

  @override
  String get noExpensesYet => '지출이 없습니다';

  @override
  String get recentTransactions => '최근 거래';

  @override
  String get viewAll => '모두 보기';

  @override
  String get noRecentTransactions => '최근 거래 없음';

  @override
  String get filterByTags => '태그로 필터링';

  @override
  String get clear => '지우기';

  @override
  String get noTagsAvailable => '사용 가능한 태그 없음';

  @override
  String get done => '완료';

  @override
  String get allTransactions => '모든 거래';

  @override
  String get all => '전체';

  @override
  String get income => '수입';

  @override
  String get expense => '지출';

  @override
  String get noTransactionsFound => '거래를 찾을 수 없습니다';

  @override
  String get deleteTransaction => '거래 삭제';

  @override
  String deleteTransactionConfirmation(Object title) {
    return '\"$title\"을(를) 삭제하시겠습니까?';
  }

  @override
  String get transactionDeleted => '거래가 삭제되었습니다';

  @override
  String get statistics => '통계';

  @override
  String get allAccounts => '모든 계좌';

  @override
  String get incomeVsExpense => '수입 대 지출';

  @override
  String get financialTrend => '재무 추세 (최근 6개월)';

  @override
  String get totalIncome => '총 수입';

  @override
  String get totalExpense => '총 지출';

  @override
  String get totalBalance => '총 잔액';

  @override
  String get spendingByTags => '태그별 지출';

  @override
  String get accountBreakdown => '계좌 내역';

  @override
  String get noAccountsFound => '계좌를 찾을 수 없습니다';

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
      '이 개인정보 보호정책에 대해 질문이 있으시면 앱의 지원 섹션을 통해 문의하십시오.';

  @override
  String get addTransactionTitle => '거래 추가';

  @override
  String get editTransactionTitle => '거래 수정';

  @override
  String get amountLabel => '금액';

  @override
  String get amountHint => '0.00';

  @override
  String get titleLabel => '제목';

  @override
  String get categoryLabel => '카테고리';

  @override
  String get dateLabel => '날짜';

  @override
  String get chooseDate => '날짜 선택';

  @override
  String get saveTransaction => '거래 저장';

  @override
  String get noAccountsMessage => '거래를 생성하기 전에 최소 하나의 계좌를 추가해야 합니다.';

  @override
  String get addAccountAction => '계좌 추가';

  @override
  String get incomeMessage1 => '🎉 은행에 돈이 들어왔어요!';

  @override
  String get incomeMessage2 => '💰 짤랑! 계속 들어오게 하세요!';

  @override
  String get incomeMessage3 => '✨ 지갑이 행복해합니다!';

  @override
  String get incomeMessage4 => '🚀 달까지 가자!';

  @override
  String get incomeMessage5 => '💸 쌓아두세요!';

  @override
  String get incomeMessage6 => '🔥 당신은 불타오르고 있어요!';

  @override
  String get incomeMessage7 => '⭐ 돈벼락이 내리네요!';

  @override
  String get incomeMessage8 => '💎 다이아몬드 손!';

  @override
  String get addAccountTitle => '계좌 추가';

  @override
  String get editAccountTitle => '계좌 수정';

  @override
  String get accountDetails => '계좌 세부 정보';

  @override
  String get accountNameLabel => '계좌 이름';

  @override
  String get accountNameHint => '예: 주 지갑';

  @override
  String get accountNameError => '이름을 입력하십시오';

  @override
  String get accountTypeLabel => '계좌 유형';

  @override
  String get initialBalanceLabel => '초기 잔액';

  @override
  String get currentBalanceLabel => '현재 잔액';

  @override
  String get creditLimitLabel => '신용 한도';

  @override
  String get balanceHint => '0.00';

  @override
  String get balanceError => '잔액을 입력하십시오';

  @override
  String get validNumberError => '유효한 숫자를 입력하십시오';

  @override
  String get bankDetails => '은행 세부 정보';

  @override
  String get cardDetails => '카드 세부 정보';

  @override
  String get bankNameLabel => '은행 이름';

  @override
  String get cardIssuerLabel => '카드 발급사 / 은행';

  @override
  String get bankNameHint => '예: 국민은행';

  @override
  String get bankNameError => '은행 이름을 입력하십시오';

  @override
  String get cardIssuerError => '카드 발급사를 입력하십시오';

  @override
  String get accountNumberLabel => '계좌 번호';

  @override
  String get cardNumberLabel => '카드 번호 (마지막 4자리)';

  @override
  String get accountNumberHint => 'XXXX1234';

  @override
  String get cardNumberHint => '1234';

  @override
  String get cardNumberError => '마지막 4자리를 입력하십시오';

  @override
  String get cardNumberLengthError => '정확히 4자리를 입력하십시오';

  @override
  String get loanDetails => '대출 세부 정보';

  @override
  String get loanPrincipalLabel => '대출 원금';

  @override
  String get loanPrincipalError => '원금을 입력하십시오';

  @override
  String get interestRateLabel => '이자율 (연 %)';

  @override
  String get interestRateError => '이자율을 입력하십시오';

  @override
  String get loanTenureLabel => '대출 기간 (개월)';

  @override
  String get loanTenureError => '기간을 입력하십시오';

  @override
  String get emiAmountLabel => 'EMI 금액';

  @override
  String get emiAmountError => 'EMI 금액을 입력하십시오';

  @override
  String get loanStartDateLabel => '대출 시작일';

  @override
  String get emiPaymentDayLabel => 'EMI 납부일';

  @override
  String get emisPaidLabel => '납부된 EMI';

  @override
  String get emisPaidError => '납부된 EMI를 입력하십시오';

  @override
  String get emisPendingLabel => '보류 중인 EMI (계산됨)';

  @override
  String get appearanceLabel => '외관';

  @override
  String get colorLabel => '색상';

  @override
  String get iconLabel => '아이콘';

  @override
  String get createAccountButton => '계좌 생성';

  @override
  String get saveChangesButton => '변경 사항 저장';

  @override
  String get cancelButton => '취소';

  @override
  String get deleteAccountTitle => '계좌 삭제';

  @override
  String deleteAccountMessage(String accountName) {
    return '\"$accountName\"을(를) 삭제하시겠습니까? 이 작업은 취소할 수 없습니다.';
  }

  @override
  String deleteAccountWarning(String accountName, int count) {
    return '\"$accountName\"을(를) 삭제하시겠습니까? 이와 관련된 $count개의 거래도 삭제됩니다.';
  }

  @override
  String get deleteButton => '삭제';

  @override
  String get accountUpdatedSuccess => '계좌가 성공적으로 업데이트되었습니다';

  @override
  String accountUpdateError(String error) {
    return '계좌 업데이트 오류: $error';
  }

  @override
  String get accountTypeCash => '현금';

  @override
  String get accountTypeSavings => '저축';

  @override
  String get accountTypeSalary => '급여';

  @override
  String get accountTypeCurrent => '당좌';

  @override
  String get accountTypeCreditCard => '신용카드';

  @override
  String get accountTypeBank => '은행';

  @override
  String get accountTypeInvestment => '투자';

  @override
  String get accountTypeLoan => '대출';

  @override
  String get accountTypeOther => '기타';

  @override
  String get selectLabel => '선택';

  @override
  String get changeLabel => '변경';

  @override
  String get notSelected => '선택되지 않음';

  @override
  String dayLabel(int day) {
    return '$day일';
  }

  @override
  String get step1Title => '1단계 / 2';

  @override
  String get step1Subtitle => '기본 세부 정보';

  @override
  String get step2Title => '2단계 / 2';

  @override
  String get step2Subtitle => '추가 세부 정보';

  @override
  String get titleOptionalLabel => '제목 (선택 사항)';

  @override
  String get titleHint => '예: 식료품 쇼핑';

  @override
  String get nextButton => '다음';

  @override
  String get selectAccountLabel => '계좌 선택';

  @override
  String get noAccountsAvailable => '사용 가능한 계좌 없음';

  @override
  String get selectedLabel => '선택됨';

  @override
  String get tagsLabel => '태그';

  @override
  String get addTagLabel => '태그 추가';

  @override
  String get notesLabel => '메모';

  @override
  String get notesHint => '이 거래에 대한 메모 추가';

  @override
  String get enterAmountError => '금액을 입력하십시오';

  @override
  String get validAmountError => '유효한 금액을 입력하십시오';

  @override
  String get selectAccountError => '계좌를 선택하십시오';

  @override
  String get transactionAddedSuccess => '거래가 성공적으로 추가되었습니다!';

  @override
  String get termsTitle => '이용 약관';

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
