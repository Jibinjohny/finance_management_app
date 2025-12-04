// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'CashFlow';

  @override
  String get dashboard => 'Tableau de bord';

  @override
  String get transactions => 'Transactions';

  @override
  String get accounts => 'Comptes';

  @override
  String get more => 'Plus';

  @override
  String get selectLanguage => 'Choisir la langue';

  @override
  String get searchLanguage => 'Rechercher une langue...';

  @override
  String get save => 'Enregistrer';

  @override
  String get cancel => 'Annuler';

  @override
  String get profile => 'Profil';

  @override
  String get settings => 'Paramètres';

  @override
  String get logout => 'Se déconnecter';

  @override
  String get login => 'Connexion';

  @override
  String get signup => 'S\'inscrire';

  @override
  String get firstName => 'Prénom';

  @override
  String get lastName => 'Nom';

  @override
  String get username => 'Nom d\'utilisateur';

  @override
  String get password => 'Mot de passe';

  @override
  String get confirmPassword => 'Confirmer le mot de passe';

  @override
  String get email => 'Email';

  @override
  String get phoneNumber => 'Numéro de téléphone';

  @override
  String get currency => 'Devise';

  @override
  String get language => 'Langue';

  @override
  String get theme => 'Thème';

  @override
  String get notifications => 'Notifications';

  @override
  String get helpAndSupport => 'Help & Support';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get termsAndConditions => 'Terms & Conditions';

  @override
  String get about => 'À propos';

  @override
  String get version => 'Version';

  @override
  String get createAccount => 'Créer un compte';

  @override
  String get alreadyHaveAccount => 'Vous avez déjà un compte ? ';

  @override
  String get whyNeedSignup => 'Pourquoi dois-je m\'inscrire ?';

  @override
  String get hello => 'Bonjour';

  @override
  String get welcomeBack => 'Bon retour';

  @override
  String get netWorth => 'Valeur nette';

  @override
  String get financialPlanning => 'Planification financière';

  @override
  String get budgets => 'Budgets';

  @override
  String get goals => 'Objectifs';

  @override
  String get categories => 'Catégories';

  @override
  String get recurring => 'Récurrent';

  @override
  String get calendar => 'Calendrier';

  @override
  String get insights => 'Aperçus';

  @override
  String get tags => 'Tags';

  @override
  String get myAccounts => 'Mes comptes';

  @override
  String get noAccountsYet => 'Pas encore de comptes';

  @override
  String get overview => 'Vue d\'ensemble';

  @override
  String get topExpenses => 'Dépenses principales';

  @override
  String get noExpensesYet => 'Pas encore de dépenses';

  @override
  String get recentTransactions => 'Transactions récentes';

  @override
  String get viewAll => 'Voir tout';

  @override
  String get noRecentTransactions => 'Pas de transactions récentes';

  @override
  String get filterByTags => 'Filtrer par tags';

  @override
  String get clear => 'Effacer';

  @override
  String get noTagsAvailable => 'Aucun tag disponible';

  @override
  String get done => 'Terminé';

  @override
  String get allTransactions => 'Toutes les transactions';

  @override
  String get all => 'Tout';

  @override
  String get income => 'Revenus';

  @override
  String get expense => 'Dépenses';

  @override
  String get noTransactionsFound => 'Aucune transaction trouvée';

  @override
  String get deleteTransaction => 'Supprimer la transaction';

  @override
  String deleteTransactionConfirmation(Object title) {
    return 'Êtes-vous sûr de vouloir supprimer \"$title\" ?';
  }

  @override
  String get transactionDeleted => 'Transaction supprimée';

  @override
  String get statistics => 'Statistiques';

  @override
  String get allAccounts => 'Tous les comptes';

  @override
  String get incomeVsExpense => 'Revenus vs Dépenses';

  @override
  String get financialTrend => 'Tendance financière (6 derniers mois)';

  @override
  String get totalIncome => 'Revenu total';

  @override
  String get totalExpense => 'Dépense totale';

  @override
  String get totalBalance => 'Solde total';

  @override
  String get spendingByTags => 'Dépenses par tags';

  @override
  String get accountBreakdown => 'Répartition des comptes';

  @override
  String get noAccountsFound => 'Aucun compte trouvé';

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
      'Si vous avez des questions concernant cette politique de confidentialité, veuillez nous contacter via la section support de l\'application.';

  @override
  String get addTransactionTitle => 'Ajouter une transaction';

  @override
  String get editTransactionTitle => 'Modifier la transaction';

  @override
  String get amountLabel => 'Montant';

  @override
  String get amountHint => '0,00';

  @override
  String get titleLabel => 'Titre';

  @override
  String get categoryLabel => 'Catégorie';

  @override
  String get dateLabel => 'Date';

  @override
  String get chooseDate => 'Choisir une date';

  @override
  String get saveTransaction => 'Enregistrer la transaction';

  @override
  String get noAccountsMessage =>
      'Vous devez ajouter au moins un compte avant de pouvoir créer des transactions.';

  @override
  String get addAccountAction => 'Ajouter un compte';

  @override
  String get incomeMessage1 => '🎉 De l\'argent en banque !';

  @override
  String get incomeMessage2 => '💰 Cha-ching ! Continuez comme ça !';

  @override
  String get incomeMessage3 => '✨ Votre portefeuille est content !';

  @override
  String get incomeMessage4 => '🚀 Vers la lune !';

  @override
  String get incomeMessage5 => '💸 Empilez-le !';

  @override
  String get incomeMessage6 => '🔥 Vous êtes en feu !';

  @override
  String get incomeMessage7 => '⭐ Il pleut de l\'argent !';

  @override
  String get incomeMessage8 => '💎 Mains de diamant !';

  @override
  String get addAccountTitle => 'Ajouter un compte';

  @override
  String get editAccountTitle => 'Modifier le compte';

  @override
  String get accountDetails => 'Détails du compte';

  @override
  String get accountNameLabel => 'Nom du compte';

  @override
  String get accountNameHint => 'ex : Portefeuille principal';

  @override
  String get accountNameError => 'Veuillez entrer un nom';

  @override
  String get accountTypeLabel => 'Type de compte';

  @override
  String get initialBalanceLabel => 'Solde initial';

  @override
  String get currentBalanceLabel => 'Solde actuel';

  @override
  String get creditLimitLabel => 'Limite de crédit';

  @override
  String get balanceHint => '0,00';

  @override
  String get balanceError => 'Veuillez entrer le solde';

  @override
  String get validNumberError => 'Veuillez entrer un nombre valide';

  @override
  String get bankDetails => 'Détails bancaires';

  @override
  String get cardDetails => 'Détails de la carte';

  @override
  String get bankNameLabel => 'Nom de la banque';

  @override
  String get cardIssuerLabel => 'Émetteur de la carte / Banque';

  @override
  String get bankNameHint => 'ex : BNP Paribas';

  @override
  String get bankNameError => 'Veuillez entrer le nom de la banque';

  @override
  String get cardIssuerError => 'Veuillez entrer l\'émetteur de la carte';

  @override
  String get accountNumberLabel => 'Numéro de compte';

  @override
  String get cardNumberLabel => 'Numéro de carte (4 derniers chiffres)';

  @override
  String get accountNumberHint => 'XXXX1234';

  @override
  String get cardNumberHint => '1234';

  @override
  String get cardNumberError => 'Veuillez entrer les 4 derniers chiffres';

  @override
  String get cardNumberLengthError => 'Veuillez entrer exactement 4 chiffres';

  @override
  String get loanDetails => 'Détails du prêt';

  @override
  String get loanPrincipalLabel => 'Montant principal du prêt';

  @override
  String get loanPrincipalError => 'Veuillez entrer le montant principal';

  @override
  String get interestRateLabel => 'Taux d\'intérêt (% annuel)';

  @override
  String get interestRateError => 'Veuillez entrer le taux d\'intérêt';

  @override
  String get loanTenureLabel => 'Durée du prêt (mois)';

  @override
  String get loanTenureError => 'Veuillez entrer la durée';

  @override
  String get emiAmountLabel => 'Montant de l\'échéance';

  @override
  String get emiAmountError => 'Veuillez entrer le montant de l\'échéance';

  @override
  String get loanStartDateLabel => 'Date de début du prêt';

  @override
  String get emiPaymentDayLabel => 'Jour de paiement de l\'échéance';

  @override
  String get emisPaidLabel => 'Échéances payées';

  @override
  String get emisPaidError => 'Veuillez entrer les échéances payées';

  @override
  String get emisPendingLabel => 'Échéances en attente (Calculé)';

  @override
  String get appearanceLabel => 'Apparence';

  @override
  String get colorLabel => 'Couleur';

  @override
  String get iconLabel => 'Icône';

  @override
  String get createAccountButton => 'Créer un compte';

  @override
  String get saveChangesButton => 'Enregistrer les modifications';

  @override
  String get cancelButton => 'Annuler';

  @override
  String get deleteAccountTitle => 'Supprimer le compte';

  @override
  String deleteAccountMessage(String accountName) {
    return 'Êtes-vous sûr de vouloir supprimer \"$accountName\" ? Cette action est irréversible.';
  }

  @override
  String deleteAccountWarning(String accountName, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 's',
      one: '',
    );
    String _temp1 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 's',
      one: '',
    );
    return 'Êtes-vous sûr de vouloir supprimer \"$accountName\" ? Cela supprimera également $count transaction$_temp0 associée$_temp1.';
  }

  @override
  String get deleteButton => 'Supprimer';

  @override
  String get accountUpdatedSuccess => 'Compte mis à jour avec succès';

  @override
  String accountUpdateError(String error) {
    return 'Erreur lors de la mise à jour du compte : $error';
  }

  @override
  String get accountTypeCash => 'Espèces';

  @override
  String get accountTypeSavings => 'Épargne';

  @override
  String get accountTypeSalary => 'Salaire';

  @override
  String get accountTypeCurrent => 'Courant';

  @override
  String get accountTypeCreditCard => 'Carte de crédit';

  @override
  String get accountTypeBank => 'Banque';

  @override
  String get accountTypeInvestment => 'Investissement';

  @override
  String get accountTypeLoan => 'Prêt';

  @override
  String get accountTypeOther => 'Autre';

  @override
  String get selectLabel => 'Sélectionner';

  @override
  String get changeLabel => 'Changer';

  @override
  String get notSelected => 'Non sélectionné';

  @override
  String dayLabel(int day) {
    return 'Jour $day';
  }

  @override
  String get step1Title => 'Étape 1 sur 2';

  @override
  String get step1Subtitle => 'Détails de base';

  @override
  String get step2Title => 'Étape 2 sur 2';

  @override
  String get step2Subtitle => 'Détails supplémentaires';

  @override
  String get titleOptionalLabel => 'Titre (Optionnel)';

  @override
  String get titleHint => 'ex : Courses';

  @override
  String get nextButton => 'Suivant';

  @override
  String get selectAccountLabel => 'Sélectionner un compte';

  @override
  String get noAccountsAvailable => 'Aucun compte disponible';

  @override
  String get selectedLabel => 'Sélectionné';

  @override
  String get tagsLabel => 'Tags';

  @override
  String get addTagLabel => 'Ajouter un tag';

  @override
  String get notesLabel => 'Notes';

  @override
  String get notesHint => 'Ajouter des notes sur cette transaction';

  @override
  String get enterAmountError => 'Veuillez entrer un montant';

  @override
  String get validAmountError => 'Veuillez entrer un montant valide';

  @override
  String get selectAccountError => 'Veuillez sélectionner un compte';

  @override
  String get transactionAddedSuccess => 'Transaction ajoutée avec succès !';

  @override
  String get termsTitle => 'Conditions générales';

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
