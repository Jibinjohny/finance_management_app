// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'CashFlow';

  @override
  String get dashboard => 'Tablero';

  @override
  String get transactions => 'Transacciones';

  @override
  String get accounts => 'Cuentas';

  @override
  String get more => 'Más';

  @override
  String get selectLanguage => 'Seleccionar idioma';

  @override
  String get searchLanguage => 'Buscar idioma...';

  @override
  String get save => 'Guardar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get profile => 'Perfil';

  @override
  String get settings => 'Configuración';

  @override
  String get logout => 'Cerrar sesión';

  @override
  String get login => 'Iniciar sesión';

  @override
  String get signup => 'Registrarse';

  @override
  String get firstName => 'Nombre';

  @override
  String get lastName => 'Apellido';

  @override
  String get username => 'Nombre de usuario';

  @override
  String get password => 'Contraseña';

  @override
  String get confirmPassword => 'Confirmar contraseña';

  @override
  String get email => 'Correo electrónico';

  @override
  String get phoneNumber => 'Número de teléfono';

  @override
  String get currency => 'Moneda';

  @override
  String get language => 'Idioma';

  @override
  String get theme => 'Tema';

  @override
  String get notifications => 'Notificaciones';

  @override
  String get helpAndSupport => 'Ayuda y soporte';

  @override
  String get privacyPolicy => 'Política de privacidad';

  @override
  String get termsAndConditions => 'Términos y condiciones';

  @override
  String get about => 'Acerca de';

  @override
  String get version => 'Versión';

  @override
  String get createAccount => 'Crear una cuenta';

  @override
  String get alreadyHaveAccount => '¿Ya tienes una cuenta? ';

  @override
  String get whyNeedSignup => '¿Por qué necesito registrarme?';

  @override
  String get hello => 'Hola';

  @override
  String get welcomeBack => 'Bienvenido de nuevo';

  @override
  String get netWorth => 'Patrimonio neto';

  @override
  String get financialPlanning => 'Planificación financiera';

  @override
  String get budgets => 'Presupuestos';

  @override
  String get goals => 'Metas';

  @override
  String get categories => 'Categorías';

  @override
  String get recurring => 'Recurrentes';

  @override
  String get calendar => 'Calendario';

  @override
  String get insights => 'Perspectivas';

  @override
  String get tags => 'Etiquetas';

  @override
  String get myAccounts => 'Mis cuentas';

  @override
  String get noAccountsYet => 'Aún no hay cuentas';

  @override
  String get overview => 'Resumen';

  @override
  String get topExpenses => 'Gastos principales';

  @override
  String get noExpensesYet => 'Aún no hay gastos';

  @override
  String get recentTransactions => 'Transacciones recientes';

  @override
  String get viewAll => 'Ver todo';

  @override
  String get noRecentTransactions => 'No hay transacciones recientes';

  @override
  String get filterByTags => 'Filtrar por etiquetas';

  @override
  String get clear => 'Borrar';

  @override
  String get noTagsAvailable => 'No hay etiquetas disponibles';

  @override
  String get done => 'Hecho';

  @override
  String get allTransactions => 'Todas las transacciones';

  @override
  String get all => 'Todo';

  @override
  String get income => 'Ingresos';

  @override
  String get expense => 'Gastos';

  @override
  String get noTransactionsFound => 'No se encontraron transacciones';

  @override
  String get deleteTransaction => 'Eliminar transacción';

  @override
  String deleteTransactionConfirmation(Object title) {
    return '¿Estás seguro de que quieres eliminar \"$title\"?';
  }

  @override
  String get transactionDeleted => 'Transacción eliminada';

  @override
  String get statistics => 'Estadísticas';

  @override
  String get allAccounts => 'Todas las cuentas';

  @override
  String get incomeVsExpense => 'Ingresos vs Gastos';

  @override
  String get financialTrend => 'Tendencia financiera (últimos 6 meses)';

  @override
  String get totalIncome => 'Ingresos totales';

  @override
  String get totalExpense => 'Gastos totales';

  @override
  String get totalBalance => 'Saldo total';

  @override
  String get spendingByTags => 'Gasto por etiquetas';

  @override
  String get accountBreakdown => 'Desglose de cuentas';

  @override
  String get noAccountsFound => 'No se encontraron cuentas';

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
      'Si tiene alguna pregunta sobre esta política de privacidad, contáctenos a través de la sección de soporte de la aplicación.';

  @override
  String get addTransactionTitle => 'Añadir Transacción';

  @override
  String get editTransactionTitle => 'Editar Transacción';

  @override
  String get amountLabel => 'Cantidad';

  @override
  String get amountHint => '0.00';

  @override
  String get titleLabel => 'Título';

  @override
  String get categoryLabel => 'Categoría';

  @override
  String get dateLabel => 'Fecha';

  @override
  String get chooseDate => 'Elegir Fecha';

  @override
  String get saveTransaction => 'Guardar Transacción';

  @override
  String get noAccountsMessage =>
      'Necesita añadir al menos una cuenta antes de poder crear transacciones.';

  @override
  String get addAccountAction => 'Añadir Cuenta';

  @override
  String get incomeMessage1 => '🎉 ¡Dinero en el banco!';

  @override
  String get incomeMessage2 => '💰 ¡Cha-ching! ¡Que siga llegando!';

  @override
  String get incomeMessage3 => '✨ ¡Tu billetera está feliz!';

  @override
  String get incomeMessage4 => '🚀 ¡A la luna!';

  @override
  String get incomeMessage5 => '💸 ¡Apílalo!';

  @override
  String get incomeMessage6 => '🔥 ¡Estás en racha!';

  @override
  String get incomeMessage7 => '⭐ ¡Haciendo llover!';

  @override
  String get incomeMessage8 => '💎 ¡Manos de diamante!';

  @override
  String get addAccountTitle => 'Añadir Cuenta';

  @override
  String get editAccountTitle => 'Editar Cuenta';

  @override
  String get accountDetails => 'Detalles de la Cuenta';

  @override
  String get accountNameLabel => 'Nombre de la Cuenta';

  @override
  String get accountNameHint => 'ej., Billetera Principal';

  @override
  String get accountNameError => 'Por favor ingrese un nombre';

  @override
  String get accountTypeLabel => 'Tipo de Cuenta';

  @override
  String get initialBalanceLabel => 'Saldo Inicial';

  @override
  String get currentBalanceLabel => 'Saldo Actual';

  @override
  String get creditLimitLabel => 'Límite de Crédito';

  @override
  String get balanceHint => '0.00';

  @override
  String get balanceError => 'Por favor ingrese el saldo';

  @override
  String get validNumberError => 'Por favor ingrese un número válido';

  @override
  String get bankDetails => 'Detalles del Banco';

  @override
  String get cardDetails => 'Detalles de la Tarjeta';

  @override
  String get bankNameLabel => 'Nombre del Banco';

  @override
  String get cardIssuerLabel => 'Emisor de la Tarjeta / Banco';

  @override
  String get bankNameHint => 'ej., Banco Santander';

  @override
  String get bankNameError => 'Por favor ingrese el nombre del banco';

  @override
  String get cardIssuerError => 'Por favor ingrese el emisor de la tarjeta';

  @override
  String get accountNumberLabel => 'Número de Cuenta';

  @override
  String get cardNumberLabel => 'Número de Tarjeta (Últimos 4 dígitos)';

  @override
  String get accountNumberHint => 'XXXX1234';

  @override
  String get cardNumberHint => '1234';

  @override
  String get cardNumberError => 'Por favor ingrese los últimos 4 dígitos';

  @override
  String get cardNumberLengthError => 'Por favor ingrese exactamente 4 dígitos';

  @override
  String get loanDetails => 'Detalles del Préstamo';

  @override
  String get loanPrincipalLabel => 'Monto Principal del Préstamo';

  @override
  String get loanPrincipalError => 'Por favor ingrese el monto principal';

  @override
  String get interestRateLabel => 'Tasa de Interés (% anual)';

  @override
  String get interestRateError => 'Por favor ingrese la tasa de interés';

  @override
  String get loanTenureLabel => 'Plazo del Préstamo (meses)';

  @override
  String get loanTenureError => 'Por favor ingrese el plazo';

  @override
  String get emiAmountLabel => 'Monto de EMI';

  @override
  String get emiAmountError => 'Por favor ingrese el monto de EMI';

  @override
  String get loanStartDateLabel => 'Fecha de Inicio del Préstamo';

  @override
  String get emiPaymentDayLabel => 'Día de Pago de EMI';

  @override
  String get emisPaidLabel => 'EMIs Pagados';

  @override
  String get emisPaidError => 'Por favor ingrese los EMIs pagados';

  @override
  String get emisPendingLabel => 'EMIs Pendientes (Calculado)';

  @override
  String get appearanceLabel => 'Apariencia';

  @override
  String get colorLabel => 'Color';

  @override
  String get iconLabel => 'Icono';

  @override
  String get createAccountButton => 'Crear Cuenta';

  @override
  String get saveChangesButton => 'Guardar Cambios';

  @override
  String get cancelButton => 'Cancelar';

  @override
  String get deleteAccountTitle => 'Eliminar Cuenta';

  @override
  String deleteAccountMessage(String accountName) {
    return 'Are you sure you want to delete \"$accountName\"? This action cannot be undone.';
  }

  @override
  String deleteAccountWarning(String accountName, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 's',
      one: '',
    );
    return 'Are you sure you want to delete \"$accountName\"? This will also delete $count associated transaction$_temp0.';
  }

  @override
  String get deleteButton => 'Eliminar';

  @override
  String get accountUpdatedSuccess => 'Cuenta actualizada exitosamente';

  @override
  String accountUpdateError(String error) {
    return 'Error al actualizar la cuenta: $error';
  }

  @override
  String get accountTypeCash => 'Efectivo';

  @override
  String get accountTypeSavings => 'Ahorros';

  @override
  String get accountTypeSalary => 'Salario';

  @override
  String get accountTypeCurrent => 'Corriente';

  @override
  String get accountTypeCreditCard => 'Tarjeta de Crédito';

  @override
  String get accountTypeBank => 'Banco';

  @override
  String get accountTypeInvestment => 'Inversión';

  @override
  String get accountTypeLoan => 'Préstamo';

  @override
  String get accountTypeOther => 'Otro';

  @override
  String get selectLabel => 'Seleccionar';

  @override
  String get changeLabel => 'Cambiar';

  @override
  String get notSelected => 'No seleccionado';

  @override
  String dayLabel(int day) {
    return 'Día $day';
  }

  @override
  String get step1Title => 'Paso 1 de 2';

  @override
  String get step1Subtitle => 'Detalles Básicos';

  @override
  String get step2Title => 'Paso 2 de 2';

  @override
  String get step2Subtitle => 'Detalles Adicionales';

  @override
  String get titleOptionalLabel => 'Título (Opcional)';

  @override
  String get titleHint => 'ej., Compra de comestibles';

  @override
  String get nextButton => 'Siguiente';

  @override
  String get selectAccountLabel => 'Seleccionar Cuenta';

  @override
  String get noAccountsAvailable => 'No hay cuentas disponibles';

  @override
  String get selectedLabel => 'Seleccionado';

  @override
  String get tagsLabel => 'Etiquetas';

  @override
  String get addTagLabel => 'Añadir Etiqueta';

  @override
  String get notesLabel => 'Notas';

  @override
  String get notesHint => 'Añadir notas sobre esta transacción';

  @override
  String get enterAmountError => 'Por favor ingrese una cantidad';

  @override
  String get validAmountError => 'Por favor ingrese una cantidad válida';

  @override
  String get selectAccountError => 'Por favor seleccione una cuenta';

  @override
  String get transactionAddedSuccess => '¡Transacción añadida exitosamente!';

  @override
  String get termsTitle => 'Términos y Condiciones';

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
