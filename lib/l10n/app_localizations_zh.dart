// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'CashFlow';

  @override
  String get dashboard => '仪表板';

  @override
  String get transactions => '交易';

  @override
  String get accounts => '账户';

  @override
  String get more => '更多';

  @override
  String get selectLanguage => '选择语言';

  @override
  String get searchLanguage => '搜索语言...';

  @override
  String get save => '保存';

  @override
  String get cancel => '取消';

  @override
  String get profile => '个人资料';

  @override
  String get settings => '设置';

  @override
  String get logout => '登出';

  @override
  String get login => '登录';

  @override
  String get signup => '注册';

  @override
  String get firstName => '名';

  @override
  String get lastName => '姓';

  @override
  String get username => '用户名';

  @override
  String get password => '密码';

  @override
  String get confirmPassword => '确认密码';

  @override
  String get email => '电子邮件';

  @override
  String get phoneNumber => '电话号码';

  @override
  String get currency => '货币';

  @override
  String get language => '语言';

  @override
  String get theme => '主题';

  @override
  String get notifications => '通知';

  @override
  String get helpAndSupport => '帮助与支持';

  @override
  String get privacyPolicy => '隐私政策';

  @override
  String get termsAndConditions => '条款和条件';

  @override
  String get about => '关于';

  @override
  String get version => '版本';

  @override
  String get createAccount => '创建账户';

  @override
  String get alreadyHaveAccount => '已有账户？ ';

  @override
  String get whyNeedSignup => '为什么需要注册？';

  @override
  String get hello => '你好';

  @override
  String get welcomeBack => '欢迎回来';

  @override
  String get netWorth => '净资产';

  @override
  String get financialPlanning => '财务规划';

  @override
  String get budgets => '预算';

  @override
  String get goals => '目标';

  @override
  String get categories => '类别';

  @override
  String get recurring => '定期';

  @override
  String get calendar => '日历';

  @override
  String get insights => '洞察';

  @override
  String get tags => '标签';

  @override
  String get myAccounts => '我的账户';

  @override
  String get noAccountsYet => '暂无账户';

  @override
  String get overview => '概览';

  @override
  String get topExpenses => '最高支出';

  @override
  String get noExpensesYet => '暂无支出';

  @override
  String get recentTransactions => '最近交易';

  @override
  String get viewAll => '查看全部';

  @override
  String get noRecentTransactions => '无最近交易';

  @override
  String get filterByTags => '按标签筛选';

  @override
  String get clear => '清除';

  @override
  String get noTagsAvailable => '无可用标签';

  @override
  String get done => '完成';

  @override
  String get allTransactions => '所有交易';

  @override
  String get all => '全部';

  @override
  String get income => '收入';

  @override
  String get expense => '支出';

  @override
  String get noTransactionsFound => '未找到交易';

  @override
  String get deleteTransaction => '删除交易';

  @override
  String deleteTransactionConfirmation(Object title) {
    return '确定要删除“$title”吗？';
  }

  @override
  String get transactionDeleted => '交易已删除';

  @override
  String get statistics => '统计';

  @override
  String get allAccounts => '所有账户';

  @override
  String get incomeVsExpense => '收入与支出';

  @override
  String get financialTrend => '财务趋势（过去6个月）';

  @override
  String get totalIncome => '总收入';

  @override
  String get totalExpense => '总支出';

  @override
  String get totalBalance => '总余额';

  @override
  String get spendingByTags => '按标签支出';

  @override
  String get accountBreakdown => '账户明细';

  @override
  String get noAccountsFound => '未找到账户';

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
  String get privacyContactContent => '如果您对本隐私政策有任何疑问，请通过应用程序的支持部分联系我们。';

  @override
  String get addTransactionTitle => '添加交易';

  @override
  String get editTransactionTitle => '编辑交易';

  @override
  String get amountLabel => '金额';

  @override
  String get amountHint => '0.00';

  @override
  String get titleLabel => '标题';

  @override
  String get categoryLabel => '类别';

  @override
  String get dateLabel => '日期';

  @override
  String get chooseDate => '选择日期';

  @override
  String get saveTransaction => '保存交易';

  @override
  String get noAccountsMessage => '您需要先添加至少一个账户才能创建交易。';

  @override
  String get addAccountAction => '添加账户';

  @override
  String get incomeMessage1 => '🎉 钱到账了！';

  @override
  String get incomeMessage2 => '💰 叮当！让钱继续来！';

  @override
  String get incomeMessage3 => '✨ 您的钱包很开心！';

  @override
  String get incomeMessage4 => '🚀 飞向月球！';

  @override
  String get incomeMessage5 => '💸 堆积起来！';

  @override
  String get incomeMessage6 => '🔥 您真是太棒了！';

  @override
  String get incomeMessage7 => '⭐ 下钱雨了！';

  @override
  String get incomeMessage8 => '💎 钻石手！';

  @override
  String get addAccountTitle => '添加账户';

  @override
  String get editAccountTitle => '编辑账户';

  @override
  String get accountDetails => '账户详情';

  @override
  String get accountNameLabel => '账户名称';

  @override
  String get accountNameHint => '例如：主钱包';

  @override
  String get accountNameError => '请输入名称';

  @override
  String get accountTypeLabel => '账户类型';

  @override
  String get initialBalanceLabel => '初始余额';

  @override
  String get currentBalanceLabel => '当前余额';

  @override
  String get creditLimitLabel => '信用额度';

  @override
  String get balanceHint => '0.00';

  @override
  String get balanceError => '请输入余额';

  @override
  String get validNumberError => '请输入有效的数字';

  @override
  String get bankDetails => '银行详情';

  @override
  String get cardDetails => '卡片详情';

  @override
  String get bankNameLabel => '银行名称';

  @override
  String get cardIssuerLabel => '发卡机构 / 银行';

  @override
  String get bankNameHint => '例如：中国银行';

  @override
  String get bankNameError => '请输入银行名称';

  @override
  String get cardIssuerError => '请输入发卡机构';

  @override
  String get accountNumberLabel => '账号';

  @override
  String get cardNumberLabel => '卡号（最后4位）';

  @override
  String get accountNumberHint => 'XXXX1234';

  @override
  String get cardNumberHint => '1234';

  @override
  String get cardNumberError => '请输入最后4位数字';

  @override
  String get cardNumberLengthError => '请输入确切的4位数字';

  @override
  String get loanDetails => '贷款详情';

  @override
  String get loanPrincipalLabel => '贷款本金';

  @override
  String get loanPrincipalError => '请输入本金';

  @override
  String get interestRateLabel => '利率（年利率 %）';

  @override
  String get interestRateError => '请输入利率';

  @override
  String get loanTenureLabel => '贷款期限（月）';

  @override
  String get loanTenureError => '请输入期限';

  @override
  String get emiAmountLabel => 'EMI 金额';

  @override
  String get emiAmountError => '请输入 EMI 金额';

  @override
  String get loanStartDateLabel => '贷款开始日期';

  @override
  String get emiPaymentDayLabel => 'EMI 支付日';

  @override
  String get emisPaidLabel => '已付 EMI';

  @override
  String get emisPaidError => '请输入已付 EMI';

  @override
  String get emisPendingLabel => '待付 EMI（计算得出）';

  @override
  String get appearanceLabel => '外观';

  @override
  String get colorLabel => '颜色';

  @override
  String get iconLabel => '图标';

  @override
  String get createAccountButton => '创建账户';

  @override
  String get saveChangesButton => '保存更改';

  @override
  String get cancelButton => '取消';

  @override
  String get deleteAccountTitle => '删除账户';

  @override
  String deleteAccountMessage(String accountName) {
    return '您确定要删除“$accountName”吗？此操作无法撤销。';
  }

  @override
  String deleteAccountWarning(String accountName, int count) {
    return '您确定要删除“$accountName”吗？这也将删除与其关联的 $count 笔交易。';
  }

  @override
  String get deleteButton => '删除';

  @override
  String get accountUpdatedSuccess => '账户更新成功';

  @override
  String accountUpdateError(String error) {
    return '更新账户时出错：$error';
  }

  @override
  String get accountTypeCash => '现金';

  @override
  String get accountTypeSavings => '储蓄';

  @override
  String get accountTypeSalary => '工资';

  @override
  String get accountTypeCurrent => '往来';

  @override
  String get accountTypeCreditCard => '信用卡';

  @override
  String get accountTypeBank => '银行';

  @override
  String get accountTypeInvestment => '投资';

  @override
  String get accountTypeLoan => '贷款';

  @override
  String get accountTypeOther => '其他';

  @override
  String get selectLabel => '选择';

  @override
  String get changeLabel => '更改';

  @override
  String get notSelected => '未选择';

  @override
  String dayLabel(int day) {
    return '$day日';
  }

  @override
  String get step1Title => '步骤 1 / 2';

  @override
  String get step1Subtitle => '基本详情';

  @override
  String get step2Title => '步骤 2 / 2';

  @override
  String get step2Subtitle => '更多详情';

  @override
  String get titleOptionalLabel => '标题（可选）';

  @override
  String get titleHint => '例如：杂货购物';

  @override
  String get nextButton => '下一步';

  @override
  String get selectAccountLabel => '选择账户';

  @override
  String get noAccountsAvailable => '无可用账户';

  @override
  String get selectedLabel => '已选择';

  @override
  String get tagsLabel => '标签';

  @override
  String get addTagLabel => '添加标签';

  @override
  String get notesLabel => '备注';

  @override
  String get notesHint => '为此交易添加备注';

  @override
  String get enterAmountError => '请输入金额';

  @override
  String get validAmountError => '请输入有效的金额';

  @override
  String get selectAccountError => '请选择账户';

  @override
  String get transactionAddedSuccess => '交易添加成功！';

  @override
  String get termsTitle => '条款和条件';

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

/// The translations for Chinese, using the Han script (`zh_Hant`).
class AppLocalizationsZhHant extends AppLocalizationsZh {
  AppLocalizationsZhHant() : super('zh_Hant');

  @override
  String get appTitle => 'CashFlow';

  @override
  String get dashboard => '儀表板';

  @override
  String get transactions => '交易';

  @override
  String get accounts => '帳戶';

  @override
  String get more => '更多';

  @override
  String get selectLanguage => '選擇語言';

  @override
  String get searchLanguage => '搜尋語言...';

  @override
  String get save => '儲存';

  @override
  String get cancel => '取消';

  @override
  String get profile => '個人資料';

  @override
  String get settings => '設定';

  @override
  String get logout => '登出';

  @override
  String get login => '登入';

  @override
  String get signup => '註冊';

  @override
  String get firstName => '名';

  @override
  String get lastName => '姓';

  @override
  String get username => '使用者名稱';

  @override
  String get password => '密碼';

  @override
  String get confirmPassword => '確認密碼';

  @override
  String get email => '電子郵件';

  @override
  String get phoneNumber => '電話號碼';

  @override
  String get currency => '貨幣';

  @override
  String get language => '語言';

  @override
  String get theme => '主題';

  @override
  String get notifications => '通知';

  @override
  String get helpAndSupport => '幫助與支援';

  @override
  String get privacyPolicy => '隱私權政策';

  @override
  String get termsAndConditions => '條款與條件';

  @override
  String get about => '關於';

  @override
  String get version => '版本';

  @override
  String get createAccount => '建立帳戶';

  @override
  String get alreadyHaveAccount => '已有帳戶？ ';

  @override
  String get whyNeedSignup => '為什麼需要註冊？';

  @override
  String get hello => '你好';

  @override
  String get welcomeBack => '歡迎回來';

  @override
  String get netWorth => '淨資產';

  @override
  String get financialPlanning => '財務規劃';

  @override
  String get budgets => '預算';

  @override
  String get goals => '目標';

  @override
  String get categories => '類別';

  @override
  String get recurring => '定期';

  @override
  String get calendar => '日曆';

  @override
  String get insights => '洞察';

  @override
  String get tags => '標籤';

  @override
  String get myAccounts => '我的帳戶';

  @override
  String get noAccountsYet => '尚無帳戶';

  @override
  String get overview => '概覽';

  @override
  String get topExpenses => '最高支出';

  @override
  String get noExpensesYet => '尚無支出';

  @override
  String get recentTransactions => '最近交易';

  @override
  String get viewAll => '查看全部';

  @override
  String get noRecentTransactions => '無最近交易';

  @override
  String get filterByTags => '按標籤篩選';

  @override
  String get clear => '清除';

  @override
  String get noTagsAvailable => '無可用標籤';

  @override
  String get done => '完成';

  @override
  String get allTransactions => '所有交易';

  @override
  String get all => '全部';

  @override
  String get income => '收入';

  @override
  String get expense => '支出';

  @override
  String get noTransactionsFound => '未找到交易';

  @override
  String get deleteTransaction => '刪除交易';

  @override
  String deleteTransactionConfirmation(Object title) {
    return '確定要刪除「$title」嗎？';
  }

  @override
  String get transactionDeleted => '交易已刪除';

  @override
  String get statistics => '統計';

  @override
  String get allAccounts => '所有帳戶';

  @override
  String get incomeVsExpense => '收入與支出';

  @override
  String get financialTrend => '財務趨勢（過去6個月）';

  @override
  String get totalIncome => '總收入';

  @override
  String get totalExpense => '總支出';

  @override
  String get totalBalance => '總餘額';

  @override
  String get spendingByTags => '按標籤支出';

  @override
  String get accountBreakdown => '帳戶明細';

  @override
  String get noAccountsFound => '未找到帳戶';

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
  String get privacyContactContent => '如果您對本隱私政策有任何疑問，請透過應用程式的支援部分聯繫我們。';

  @override
  String get addTransactionTitle => '新增交易';

  @override
  String get editTransactionTitle => '編輯交易';

  @override
  String get amountLabel => '金額';

  @override
  String get amountHint => '0.00';

  @override
  String get titleLabel => '標題';

  @override
  String get categoryLabel => '類別';

  @override
  String get dateLabel => '日期';

  @override
  String get chooseDate => '選擇日期';

  @override
  String get saveTransaction => '儲存交易';

  @override
  String get noAccountsMessage => '您需要先新增至少一個帳戶才能建立交易。';

  @override
  String get addAccountAction => '新增帳戶';

  @override
  String get incomeMessage1 => '🎉 錢進帳了！';

  @override
  String get incomeMessage2 => '💰 叮噹！讓錢繼續來！';

  @override
  String get incomeMessage3 => '✨ 您的錢包很開心！';

  @override
  String get incomeMessage4 => '🚀 飛向月球！';

  @override
  String get incomeMessage5 => '💸 堆積起來！';

  @override
  String get incomeMessage6 => '🔥 您真是太棒了！';

  @override
  String get incomeMessage7 => '⭐ 下錢雨了！';

  @override
  String get incomeMessage8 => '💎 鑽石手！';

  @override
  String get addAccountTitle => '新增帳戶';

  @override
  String get editAccountTitle => '編輯帳戶';

  @override
  String get accountDetails => '帳戶詳情';

  @override
  String get accountNameLabel => '帳戶名稱';

  @override
  String get accountNameHint => '例如：主錢包';

  @override
  String get accountNameError => '請輸入名稱';

  @override
  String get accountTypeLabel => '帳戶類型';

  @override
  String get initialBalanceLabel => '初始餘額';

  @override
  String get currentBalanceLabel => '當前餘額';

  @override
  String get creditLimitLabel => '信用額度';

  @override
  String get balanceHint => '0.00';

  @override
  String get balanceError => '請輸入餘額';

  @override
  String get validNumberError => '請輸入有效的數字';

  @override
  String get bankDetails => '銀行詳情';

  @override
  String get cardDetails => '卡片詳情';

  @override
  String get bankNameLabel => '銀行名稱';

  @override
  String get cardIssuerLabel => '發卡機構 / 銀行';

  @override
  String get bankNameHint => '例如：中國銀行';

  @override
  String get bankNameError => '請輸入銀行名稱';

  @override
  String get cardIssuerError => '請輸入發卡機構';

  @override
  String get accountNumberLabel => '帳號';

  @override
  String get cardNumberLabel => '卡號（最後4位）';

  @override
  String get accountNumberHint => 'XXXX1234';

  @override
  String get cardNumberHint => '1234';

  @override
  String get cardNumberError => '請輸入最後4位數字';

  @override
  String get cardNumberLengthError => '請輸入確切的4位數字';

  @override
  String get loanDetails => '貸款詳情';

  @override
  String get loanPrincipalLabel => '貸款本金';

  @override
  String get loanPrincipalError => '請輸入本金';

  @override
  String get interestRateLabel => '利率（年利率 %）';

  @override
  String get interestRateError => '請輸入利率';

  @override
  String get loanTenureLabel => '貸款期限（月）';

  @override
  String get loanTenureError => '請輸入期限';

  @override
  String get emiAmountLabel => 'EMI 金額';

  @override
  String get emiAmountError => '請輸入 EMI 金額';

  @override
  String get loanStartDateLabel => '貸款開始日期';

  @override
  String get emiPaymentDayLabel => 'EMI 支付日';

  @override
  String get emisPaidLabel => '已付 EMI';

  @override
  String get emisPaidError => '請輸入已付 EMI';

  @override
  String get emisPendingLabel => '待付 EMI（計算得出）';

  @override
  String get appearanceLabel => '外觀';

  @override
  String get colorLabel => '顏色';

  @override
  String get iconLabel => '圖標';

  @override
  String get createAccountButton => '建立帳戶';

  @override
  String get saveChangesButton => '儲存更改';

  @override
  String get cancelButton => '取消';

  @override
  String get deleteAccountTitle => '刪除帳戶';

  @override
  String deleteAccountMessage(String accountName) {
    return '您確定要刪除「$accountName」嗎？此操作無法撤銷。';
  }

  @override
  String deleteAccountWarning(String accountName, int count) {
    return '您確定要刪除「$accountName」嗎？這也將刪除與其關聯的 $count 筆交易。';
  }

  @override
  String get deleteButton => '刪除';

  @override
  String get accountUpdatedSuccess => '帳戶更新成功';

  @override
  String accountUpdateError(String error) {
    return '更新帳戶時出錯：$error';
  }

  @override
  String get accountTypeCash => '現金';

  @override
  String get accountTypeSavings => '儲蓄';

  @override
  String get accountTypeSalary => '工資';

  @override
  String get accountTypeCurrent => '往來';

  @override
  String get accountTypeCreditCard => '信用卡';

  @override
  String get accountTypeBank => '銀行';

  @override
  String get accountTypeInvestment => '投資';

  @override
  String get accountTypeLoan => '貸款';

  @override
  String get accountTypeOther => '其他';

  @override
  String get selectLabel => '選擇';

  @override
  String get changeLabel => '更改';

  @override
  String get notSelected => '未選擇';

  @override
  String dayLabel(int day) {
    return '$day日';
  }

  @override
  String get step1Title => '步驟 1 / 2';

  @override
  String get step1Subtitle => '基本詳情';

  @override
  String get step2Title => '步驟 2 / 2';

  @override
  String get step2Subtitle => '更多詳情';

  @override
  String get titleOptionalLabel => '標題（可選）';

  @override
  String get titleHint => '例如：雜貨購物';

  @override
  String get nextButton => '下一步';

  @override
  String get selectAccountLabel => '選擇帳戶';

  @override
  String get noAccountsAvailable => '無可用帳戶';

  @override
  String get selectedLabel => '已選擇';

  @override
  String get tagsLabel => '標籤';

  @override
  String get addTagLabel => '新增標籤';

  @override
  String get notesLabel => '備註';

  @override
  String get notesHint => '為此交易新增備註';

  @override
  String get enterAmountError => '請輸入金額';

  @override
  String get validAmountError => '請輸入有效的金額';

  @override
  String get selectAccountError => '請選擇帳戶';

  @override
  String get transactionAddedSuccess => '交易新增成功！';

  @override
  String get termsTitle => '條款和條件';

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
}
