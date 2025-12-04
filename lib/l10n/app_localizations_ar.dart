// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'CashFlow';

  @override
  String get dashboard => 'لوحة القيادة';

  @override
  String get transactions => 'المعاملات';

  @override
  String get accounts => 'الحسابات';

  @override
  String get more => 'المزيد';

  @override
  String get selectLanguage => 'اختر اللغة';

  @override
  String get searchLanguage => 'البحث عن لغة...';

  @override
  String get save => 'حفظ';

  @override
  String get cancel => 'إلغاء';

  @override
  String get profile => 'الملف الشخصي';

  @override
  String get settings => 'الإعدادات';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get signup => 'اشتراك';

  @override
  String get firstName => 'الاسم الأول';

  @override
  String get lastName => 'اسم العائلة';

  @override
  String get username => 'اسم المستخدم';

  @override
  String get password => 'كلمة المرور';

  @override
  String get confirmPassword => 'تأكيد كلمة المرور';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get phoneNumber => 'رقم الهاتف';

  @override
  String get currency => 'العملة';

  @override
  String get language => 'اللغة';

  @override
  String get theme => 'الموضوع';

  @override
  String get notifications => 'إشعارات';

  @override
  String get helpAndSupport => 'المساعدة والدعم';

  @override
  String get privacyPolicy => 'سياسة الخصوصية';

  @override
  String get termsAndConditions => 'الشروط والأحكام';

  @override
  String get about => 'حول';

  @override
  String get version => 'الإصدار';

  @override
  String get createAccount => 'إنشاء حساب';

  @override
  String get alreadyHaveAccount => 'هل لديك حساب بالفعل؟ ';

  @override
  String get whyNeedSignup => 'لماذا أحتاج إلى التسجيل؟';

  @override
  String get hello => 'مرحبا';

  @override
  String get welcomeBack => 'مرحبًا بعودتك';

  @override
  String get netWorth => 'صافي الثروة';

  @override
  String get financialPlanning => 'التخطيط المالي';

  @override
  String get budgets => 'الميزانيات';

  @override
  String get goals => 'الأهداف';

  @override
  String get categories => 'الفئات';

  @override
  String get recurring => 'المتكررة';

  @override
  String get calendar => 'التقويم';

  @override
  String get insights => 'رؤى';

  @override
  String get tags => 'العلامات';

  @override
  String get myAccounts => 'حساباتي';

  @override
  String get noAccountsYet => 'لا توجد حسابات بعد';

  @override
  String get overview => 'نظرة عامة';

  @override
  String get topExpenses => 'أعلى النفقات';

  @override
  String get noExpensesYet => 'لا توجد نفقات بعد';

  @override
  String get recentTransactions => 'المعاملات الأخيرة';

  @override
  String get viewAll => 'عرض الكل';

  @override
  String get noRecentTransactions => 'لا توجد معاملات حديثة';

  @override
  String get filterByTags => 'تصفية حسب العلامات';

  @override
  String get clear => 'مسح';

  @override
  String get noTagsAvailable => 'لا توجد علامات متاحة';

  @override
  String get done => 'تم';

  @override
  String get allTransactions => 'جميع المعاملات';

  @override
  String get all => 'الكل';

  @override
  String get income => 'الدخل';

  @override
  String get expense => 'المصروفات';

  @override
  String get noTransactionsFound => 'لم يتم العثور على معاملات';

  @override
  String get deleteTransaction => 'حذف المعاملة';

  @override
  String deleteTransactionConfirmation(Object title) {
    return 'هل أنت متأكد أنك تريد حذف \"$title\"؟';
  }

  @override
  String get transactionDeleted => 'تم حذف المعاملة';

  @override
  String get statistics => 'الإحصائيات';

  @override
  String get allAccounts => 'جميع الحسابات';

  @override
  String get incomeVsExpense => 'الدخل مقابل المصروفات';

  @override
  String get financialTrend => 'الاتجاه المالي (آخر 6 أشهر)';

  @override
  String get totalIncome => 'إجمالي الدخل';

  @override
  String get totalExpense => 'إجمالي المصروفات';

  @override
  String get totalBalance => 'إجمالي الرصيد';

  @override
  String get spendingByTags => 'الإنفاق حسب العلامات';

  @override
  String get accountBreakdown => 'تفاصيل الحساب';

  @override
  String get noAccountsFound => 'لم يتم العثور على حسابات';

  @override
  String get monthlyReport => 'التقرير الشهري';

  @override
  String get loginWelcome => 'مرحبًا بك في CashFlow';

  @override
  String get loginSubtitle => 'تسجيل الدخول للمتابعة';

  @override
  String get whyLoginTitle => 'لماذا تسجيل الدخول؟';

  @override
  String get whyLoginContent =>
      'على الرغم من أن بياناتك مخزنة محليًا على جهازك، فإننا نستخدم نظام تسجيل الدخول لتأمين معلوماتك المالية من الوصول غير المصرح به من قبل الآخرين الذين قد يستخدمون هاتفك.';

  @override
  String get whyLoginAction => 'فهمت';

  @override
  String get whyLoginLink => 'لماذا أحتاج إلى تسجيل الدخول؟';

  @override
  String get usernameHint => 'اسم المستخدم';

  @override
  String get passwordHint => 'كلمة المرور';

  @override
  String get loginButton => 'تسجيل الدخول';

  @override
  String get noAccount => 'ليس لديك حساب؟ ';

  @override
  String get signUpLink => 'اشتراك';

  @override
  String get invalidCredentials => 'بيانات الاعتماد غير صالحة';

  @override
  String get resetDataMessage =>
      'تم إعادة تعيين بيانات التطبيق. يمكنك الآن التسجيل.';

  @override
  String get faqTitle => 'الأسئلة الشائعة';

  @override
  String get faqSearchHint => 'البحث في الأسئلة الشائعة...';

  @override
  String get faqNoResults => 'لم يتم العثور على نتائج';

  @override
  String get faqQ1 => 'كيف يمكنني إضافة معاملة؟';

  @override
  String get faqA1 =>
      'اضغط على زر \'+\' في الشاشة الرئيسية، أدخل المبلغ، اختر الفئة، واضغط حفظ.';

  @override
  String get faqQ2 => 'هل يمكنني تعديل معاملة؟';

  @override
  String get faqA2 => 'نعم، اضغط على أي معاملة في القائمة لتعديل تفاصيلها.';

  @override
  String get faqQ3 => 'كيف يمكنني حذف حساب؟';

  @override
  String get faqA3 =>
      'اذهب إلى شاشة الحسابات، اضغط مطولاً على الحساب الذي تريد حذفه، وأكد الحذف.';

  @override
  String get faqQ4 => 'هل بياناتي آمنة؟';

  @override
  String get faqA4 =>
      'نعم، يتم تخزين بياناتك محلياً على جهازك ولا يتم مشاركتها مع أي خوادم خارجية.';

  @override
  String get faqQ5 => 'كيف يمكنني تغيير العملة؟';

  @override
  String get faqA5 => 'اذهب إلى الإعدادات > العملة واختر العملة المفضلة لديك.';

  @override
  String get faqQ6 => 'هل يمكنني تصدير بياناتي؟';

  @override
  String get faqA6 =>
      'نعم، يمكنك تصدير تقاريرك الشهرية كملف PDF من شاشة التقارير.';

  @override
  String get faqQ7 => 'كيف أضيف فئة جديدة؟';

  @override
  String get faqA7 =>
      'اذهب إلى الإعدادات > الفئات واضغط على زر الإضافة لإنشاء فئة جديدة.';

  @override
  String get faqQ8 => 'هل يدعم التطبيق الوضع المظلم؟';

  @override
  String get faqA8 => 'نعم، يمكنك تفعيل الوضع المظلم من الإعدادات > المظهر.';

  @override
  String get faqQ9 => 'كيف يمكنني تعيين ميزانية؟';

  @override
  String get faqA9 =>
      'اذهب إلى قسم الميزانيات من الشاشة الرئيسية واضغط على زر الإضافة لتعيين ميزانية جديدة.';

  @override
  String get faqQ10 => 'ما هي المعاملات المتكررة؟';

  @override
  String get faqA10 =>
      'هي المعاملات التي تتكرر بانتظام مثل الإيجار أو الاشتراكات. يمكنك إعدادها من قسم المعاملات المتكررة.';

  @override
  String get faqQ11 => 'كيف أرى تقريري الشهري؟';

  @override
  String get faqA11 =>
      'اضغط على أيقونة التقارير في شريط التنقل السفلي لعرض ملخصك الشهري.';

  @override
  String get faqQ12 => 'هل يمكنني استخدام التطبيق بدون إنترنت؟';

  @override
  String get faqA12 => 'نعم، التطبيق يعمل بشكل كامل بدون اتصال بالإنترنت.';

  @override
  String get faqQ13 => 'كيف أتواصل مع الدعم؟';

  @override
  String get faqA13 =>
      'يمكنك التواصل معنا عبر البريد الإلكتروني الموجود في قسم المساعدة والدعم.';

  @override
  String get faqQ14 => 'هل يمكنني قفل التطبيق؟';

  @override
  String get faqA14 =>
      'نعم، يمكنك تفعيل قفل التطبيق (بصمة الإصبع أو الوجه) من الإعدادات > الأمان.';

  @override
  String get faqQ15 => 'كيف أحذف جميع بياناتي؟';

  @override
  String get faqA15 =>
      'يمكنك إعادة تعيين التطبيق وحذف جميع البيانات من الإعدادات > إدارة البيانات > حذف جميع البيانات.';

  @override
  String get faqQ16 => 'هل التطبيق مجاني؟';

  @override
  String get faqA16 => 'نعم، التطبيق مجاني للاستخدام مع ميزات أساسية.';

  @override
  String get faqQ17 => 'كيف أقوم بتحديث التطبيق؟';

  @override
  String get faqA17 =>
      'يمكنك تحديث التطبيق من متجر التطبيقات (Google Play أو App Store).';

  @override
  String get privacyPolicyTitle => 'سياسة الخصوصية';

  @override
  String get lastUpdated => 'آخر تحديث';

  @override
  String get privacyIntroTitle => 'مقدمة';

  @override
  String get privacyIntroContent =>
      'نحن نأخذ خصوصيتك على محمل الجد. تشرح سياسة الخصوصية هذه كيفية جمعنا واستخدامنا وحمايتنا لمعلوماتك.';

  @override
  String get privacyDataCollectionTitle => 'جمع البيانات';

  @override
  String get privacyDataCollectionContent =>
      'نحن لا نجمع أي بيانات شخصية. يتم تخزين جميع بياناتك محلياً على جهازك.';

  @override
  String get privacyDataStorageTitle => 'تخزين البيانات';

  @override
  String get privacyDataStorageContent =>
      'يتم تخزين جميع بياناتك بشكل آمن على جهازك. نحن لا نقوم بتحميل بياناتك إلى أي خوادم سحابية.';

  @override
  String get privacyDataSharingTitle => 'مشاركة البيانات';

  @override
  String get privacyDataSharingContent =>
      'نحن لا نشارك بياناتك مع أي طرف ثالث.';

  @override
  String get privacyPermissionsTitle => 'الأذونات';

  @override
  String get privacyPermissionsContent =>
      'قد يطلب التطبيق أذونات معينة ليعمل بشكل صحيح (مثل الإشعارات).';

  @override
  String get privacyDataSecurityTitle => 'أمان البيانات';

  @override
  String get privacyDataSecurityContent =>
      'نحن نستخدم تدابير أمنية متوافقة مع معايير الصناعة لحماية بياناتك.';

  @override
  String get privacyYourRightsTitle => 'حقوقك';

  @override
  String get privacyYourRightsContent =>
      'لديك الحق في الوصول إلى بياناتك وتعديلها وحذفها في أي وقت.';

  @override
  String get privacyChildrenTitle => 'خصوصية الأطفال';

  @override
  String get privacyChildrenContent =>
      'هذا التطبيق غير موجه للأطفال دون سن 13 عاماً.';

  @override
  String get privacyChangesTitle => 'التغييرات على هذه السياسة';

  @override
  String get privacyChangesContent =>
      'قد نقوم بتحديث سياسة الخصوصية هذه من وقت لآخر. سيتم إشعارك بأي تغييرات.';

  @override
  String get privacyContactTitle => 'اتصل بنا';

  @override
  String get privacyContactContent =>
      'إذا كان لديك أي أسئلة حول سياسة الخصوصية هذه، يرجى الاتصال بنا من خلال قسم الدعم في التطبيق.';

  @override
  String get addTransactionTitle => 'إضافة معاملة';

  @override
  String get editTransactionTitle => 'تعديل المعاملة';

  @override
  String get amountLabel => 'المبلغ';

  @override
  String get amountHint => '0.00';

  @override
  String get titleLabel => 'العنوان';

  @override
  String get categoryLabel => 'الفئة';

  @override
  String get dateLabel => 'التاريخ';

  @override
  String get chooseDate => 'اختر التاريخ';

  @override
  String get saveTransaction => 'حفظ المعاملة';

  @override
  String get noAccountsMessage =>
      'تحتاج إلى إضافة حساب واحد على الأقل قبل أن تتمكن من إنشاء معاملات.';

  @override
  String get addAccountAction => 'إضافة حساب';

  @override
  String get incomeMessage1 => '🎉 المال في البنك!';

  @override
  String get incomeMessage2 => '💰 تشا-تشينغ! استمر في القدوم!';

  @override
  String get incomeMessage3 => '✨ محفظتك سعيدة!';

  @override
  String get incomeMessage4 => '🚀 إلى القمر!';

  @override
  String get incomeMessage5 => '💸 كدسها!';

  @override
  String get incomeMessage6 => '🔥 أنت مشتعل!';

  @override
  String get incomeMessage7 => '⭐ اجعلها تمطر!';

  @override
  String get incomeMessage8 => '💎 أيادي الماس!';

  @override
  String get addAccountTitle => 'إضافة حساب';

  @override
  String get editAccountTitle => 'تعديل الحساب';

  @override
  String get accountDetails => 'تفاصيل الحساب';

  @override
  String get accountNameLabel => 'اسم الحساب';

  @override
  String get accountNameHint => 'مثل، المحفظة الرئيسية';

  @override
  String get accountNameError => 'يرجى إدخال اسم';

  @override
  String get accountTypeLabel => 'نوع الحساب';

  @override
  String get initialBalanceLabel => 'الرصيد الافتتاحي';

  @override
  String get currentBalanceLabel => 'الرصيد الحالي';

  @override
  String get creditLimitLabel => 'الحد الائتماني';

  @override
  String get balanceHint => '0.00';

  @override
  String get balanceError => 'يرجى إدخال الرصيد';

  @override
  String get validNumberError => 'يرجى إدخال رقم صحيح';

  @override
  String get bankDetails => 'تفاصيل البنك';

  @override
  String get cardDetails => 'تفاصيل البطاقة';

  @override
  String get bankNameLabel => 'اسم البنك';

  @override
  String get cardIssuerLabel => 'جهة إصدار البطاقة / البنك';

  @override
  String get bankNameHint => 'مثل، البنك الأهلي';

  @override
  String get bankNameError => 'يرجى إدخال اسم البنك';

  @override
  String get cardIssuerError => 'يرجى إدخال جهة إصدار البطاقة';

  @override
  String get accountNumberLabel => 'رقم الحساب';

  @override
  String get cardNumberLabel => 'رقم البطاقة (آخر 4 أرقام)';

  @override
  String get accountNumberHint => 'XXXX1234';

  @override
  String get cardNumberHint => '1234';

  @override
  String get cardNumberError => 'يرجى إدخال آخر 4 أرقام';

  @override
  String get cardNumberLengthError => 'يرجى إدخال 4 أرقام بالضبط';

  @override
  String get loanDetails => 'تفاصيل القرض';

  @override
  String get loanPrincipalLabel => 'مبلغ القرض الأصلي';

  @override
  String get loanPrincipalError => 'يرجى إدخال المبلغ الأصلي';

  @override
  String get interestRateLabel => 'معدل الفائدة (% سنوياً)';

  @override
  String get interestRateError => 'يرجى إدخال معدل الفائدة';

  @override
  String get loanTenureLabel => 'مدة القرض (أشهر)';

  @override
  String get loanTenureError => 'يرجى إدخال المدة';

  @override
  String get emiAmountLabel => 'مبلغ القسط الشهري';

  @override
  String get emiAmountError => 'يرجى إدخال مبلغ القسط الشهري';

  @override
  String get loanStartDateLabel => 'تاريخ بدء القرض';

  @override
  String get emiPaymentDayLabel => 'يوم دفع القسط الشهري';

  @override
  String get emisPaidLabel => 'الأقساط المدفوعة';

  @override
  String get emisPaidError => 'يرجى إدخال الأقساط المدفوعة';

  @override
  String get emisPendingLabel => 'الأقساط المعلقة (محسوبة)';

  @override
  String get appearanceLabel => 'المظهر';

  @override
  String get colorLabel => 'اللون';

  @override
  String get iconLabel => 'الأيقونة';

  @override
  String get createAccountButton => 'إنشاء حساب';

  @override
  String get saveChangesButton => 'حفظ التغييرات';

  @override
  String get cancelButton => 'إلغاء';

  @override
  String get deleteAccountTitle => 'حذف الحساب';

  @override
  String deleteAccountMessage(String accountName) {
    return 'هل أنت متأكد أنك تريد حذف \"$accountName\"؟ لا يمكن التراجع عن هذا الإجراء.';
  }

  @override
  String deleteAccountWarning(String accountName, int count) {
    return 'هل أنت متأكد أنك تريد حذف \"$accountName\"؟ سيؤدي هذا أيضًا إلى حذف $count معاملة مرتبطة.';
  }

  @override
  String get deleteButton => 'حذف';

  @override
  String get accountUpdatedSuccess => 'تم تحديث الحساب بنجاح';

  @override
  String accountUpdateError(String error) {
    return 'خطأ في تحديث الحساب: $error';
  }

  @override
  String get accountTypeCash => 'نقد';

  @override
  String get accountTypeSavings => 'توفير';

  @override
  String get accountTypeSalary => 'راتب';

  @override
  String get accountTypeCurrent => 'جاري';

  @override
  String get accountTypeCreditCard => 'بطاقة ائتمان';

  @override
  String get accountTypeBank => 'بنك';

  @override
  String get accountTypeInvestment => 'استثمار';

  @override
  String get accountTypeLoan => 'قرض';

  @override
  String get accountTypeOther => 'آخر';

  @override
  String get selectLabel => 'تحديد';

  @override
  String get changeLabel => 'تغيير';

  @override
  String get notSelected => 'لم يتم التحديد';

  @override
  String dayLabel(int day) {
    return 'اليوم $day';
  }

  @override
  String get step1Title => 'الخطوة 1 من 2';

  @override
  String get step1Subtitle => 'التفاصيل الأساسية';

  @override
  String get step2Title => 'الخطوة 2 من 2';

  @override
  String get step2Subtitle => 'تفاصيل إضافية';

  @override
  String get titleOptionalLabel => 'العنوان (اختياري)';

  @override
  String get titleHint => 'مثل، تسوق البقالة';

  @override
  String get nextButton => 'التالي';

  @override
  String get selectAccountLabel => 'اختر الحساب';

  @override
  String get noAccountsAvailable => 'لا توجد حسابات متاحة';

  @override
  String get selectedLabel => 'محدد';

  @override
  String get tagsLabel => 'العلامات';

  @override
  String get addTagLabel => 'إضافة علامة';

  @override
  String get notesLabel => 'ملاحظات';

  @override
  String get notesHint => 'أضف ملاحظات حول هذه المعاملة';

  @override
  String get enterAmountError => 'يرجى إدخال مبلغ';

  @override
  String get validAmountError => 'يرجى إدخال مبلغ صحيح';

  @override
  String get selectAccountError => 'يرجى اختيار حساب';

  @override
  String get transactionAddedSuccess => 'تمت إضافة المعاملة بنجاح!';

  @override
  String get termsTitle => 'الشروط والأحكام';

  @override
  String get termsAcceptanceTitle => 'قبول الشروط';

  @override
  String get termsAcceptanceContent =>
      'باستخدام هذا التطبيق، فإنك توافق على الالتزام بهذه الشروط والأحكام.';

  @override
  String get termsLicenseTitle => 'الترخيص';

  @override
  String get termsLicenseContent =>
      'نمنحك ترخيصاً محدوداً وغير حصري لاستخدام التطبيق لأغراض شخصية.';

  @override
  String get termsUserRespTitle => 'مسؤوليات المستخدم';

  @override
  String get termsUserRespContent =>
      'أنت مسؤول عن الحفاظ على سرية معلومات حسابك.';

  @override
  String get termsDisclaimerTitle => 'إخلاء المسؤولية';

  @override
  String get termsDisclaimerContent =>
      'يتم توفير التطبيق \'كما هو\' دون أي ضمانات من أي نوع.';

  @override
  String get termsLiabilityTitle => 'تحديد المسؤولية';

  @override
  String get termsLiabilityContent =>
      'لن نكون مسؤولين عن أي أضرار تنشأ عن استخدامك للتطبيق.';

  @override
  String get termsAdviceTitle => 'لا توجد نصيحة مالية';

  @override
  String get termsAdviceContent =>
      'المعلومات المقدمة في التطبيق هي لأغراض إعلامية فقط ولا تشكل نصيحة مالية.';

  @override
  String get termsAccuracyTitle => 'دقة المعلومات';

  @override
  String get termsAccuracyContent =>
      'نحن نسعى لضمان دقة المعلومات ولكن لا نضمن خلوها من الأخطاء.';

  @override
  String get termsUpdatesTitle => 'التحديثات';

  @override
  String get termsUpdatesContent =>
      'قد نقوم بتحديث التطبيق والشروط من وقت لآخر.';

  @override
  String get termsIPTitle => 'الملكية الفكرية';

  @override
  String get termsIPContent =>
      'جميع الحقوق والملكية الفكرية للتطبيق مملوكة لنا.';

  @override
  String get termsTerminationTitle => 'الإنهاء';

  @override
  String get termsTerminationContent =>
      'يجوز لنا إنهاء وصولك إلى التطبيق في أي وقت.';

  @override
  String get termsGoverningTitle => 'القانون الحاكم';

  @override
  String get termsGoverningContent =>
      'تخضع هذه الشروط لقوانين الولاية القضائية التي نعمل فيها.';

  @override
  String get termsContactTitle => 'اتصل بنا';

  @override
  String get termsContactContent =>
      'إذا كان لديك أي أسئلة حول هذه الشروط، يرجى الاتصال بنا.';

  @override
  String get termsFooter => 'شكراً لاستخدامك CashFlow!';

  @override
  String get addFirstAccount => 'اضغط + لإضافة حسابك الأول';

  @override
  String get notificationsTitle => 'الإشعارات';

  @override
  String get clearAll => 'مسح الكل';

  @override
  String get noNotificationsYet => 'لا توجد إشعارات حتى الآن';

  @override
  String get justNow => 'الآن';

  @override
  String minutesAgo(int minutes) {
    return 'منذ $minutes دقيقة';
  }

  @override
  String hoursAgo(int hours) {
    return 'منذ $hours ساعة';
  }

  @override
  String daysAgo(int days) {
    return 'منذ $days يوم';
  }

  @override
  String get accountDeleted => 'تم حذف الحساب';

  @override
  String accountDeletedWithTransactions(int count, String s) {
    return 'تم حذف الحساب مع $count معاملة';
  }

  @override
  String get noDataAvailable => 'لا توجد بيانات متاحة';

  @override
  String get addAccountsAndTransactions => 'أضف حسابات ومعاملات لرؤية التقارير';

  @override
  String get expenseBreakdown => 'تفاصيل المصروفات';

  @override
  String get noExpensesForPeriod => 'لا توجد مصروفات لهذه الفترة';

  @override
  String get generatingPdf => 'جاري إنشاء ملف PDF للمشاركة...';

  @override
  String errorSharingPdf(String error) {
    return 'خطأ في مشاركة ملف PDF: $error';
  }

  @override
  String get backButton => 'رجوع';

  @override
  String get summaryLabel => 'ملخص';

  @override
  String get typeLabel => 'النوع';

  @override
  String get tagsOptionalLabel => 'العلامات (اختياري)';

  @override
  String get paymentModeLabel => 'طريقة الدفع';

  @override
  String get paymentModeCash => 'نقدي';

  @override
  String get paymentModeCreditCard => 'بطاقة ائتمان';

  @override
  String get paymentModeDebitCard => 'بطاقة خصم';

  @override
  String get paymentModeUPI => 'UPI';

  @override
  String get paymentModeNetBanking => 'خدمات مصرفية عبر الإنترنت';

  @override
  String get paymentModeOther => 'أخرى';

  @override
  String get categoryFood => 'طعام';

  @override
  String get categoryTransport => 'نقل';

  @override
  String get categoryShopping => 'تسوق';

  @override
  String get categoryBills => 'فواتير';

  @override
  String get categoryEntertainment => 'ترفيه';

  @override
  String get categoryHealth => 'صحة';

  @override
  String get categoryOther => 'أخرى';

  @override
  String get categorySalary => 'راتب';

  @override
  String get categoryFreelance => 'عمل حر';

  @override
  String get categoryBusiness => 'عمل تجاري';

  @override
  String get categoryInvestment => 'استثمار';

  @override
  String get categoryGift => 'هدية';

  @override
  String get addCategoryTitle => 'إضافة فئة';

  @override
  String get editCategoryTitle => 'تعديل الفئة';

  @override
  String get categoryNameLabel => 'اسم الفئة';

  @override
  String get categoryNameError => 'يرجى إدخال اسم الفئة';

  @override
  String get selectIconLabel => 'اختر أيقونة';

  @override
  String get selectColorLabel => 'اختر لون';

  @override
  String get previewLabel => 'معاينة';

  @override
  String get saveCategoryButton => 'حفظ الفئة';

  @override
  String get addRecurringTitle => 'تكرار جديد';

  @override
  String get editRecurringTitle => 'تعديل التكرار';

  @override
  String get transactionDetailsLabel => 'تفاصيل المعاملة';

  @override
  String get frequencyLabel => 'التكرار';

  @override
  String get frequencyDaily => 'يومي';

  @override
  String get frequencyWeekly => 'أسبوعي';

  @override
  String get frequencyMonthly => 'شهري';

  @override
  String get frequencyYearly => 'سنوي';

  @override
  String get startDateLabel => 'تاريخ البدء / الاستحقاق القادم';

  @override
  String get autoAddLabel => 'إضافة تلقائية';

  @override
  String get autoAddSubtitle => 'إنشاء تلقائي في تاريخ الاستحقاق';

  @override
  String get saveRecurringButton => 'حفظ التكرار';

  @override
  String errorSavingRecurring(String error) {
    return 'خطأ في حفظ المعاملة المتكررة: $error';
  }

  @override
  String get daily => 'يومي';

  @override
  String get monthly => 'شهري';

  @override
  String get balance => 'الرصيد';

  @override
  String get monthlyFinancialReport => 'التقرير المالي الشهري';

  @override
  String generatedOn(String date) {
    return 'تم الإنشاء في $date';
  }

  @override
  String get netBalance => 'صافي الرصيد';

  @override
  String get dateHeader => 'التاريخ';

  @override
  String get modeHeader => 'الطريقة';

  @override
  String get descriptionHeader => 'الوصف';

  @override
  String get amountHeader => 'المبلغ';

  @override
  String get dataManagement => 'إدارة البيانات';

  @override
  String get backupData => 'نسخ احتياطي للبيانات';

  @override
  String get restoreData => 'استعادة البيانات';
}
