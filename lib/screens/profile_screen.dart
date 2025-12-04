import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../providers/auth_provider.dart';
import '../providers/transaction_provider.dart';
import '../providers/language_provider.dart';
import '../utils/app_colors.dart';
import '../utils/glass_snackbar.dart';
import '../widgets/glass_container.dart';
import 'faq_screen.dart';
import 'privacy_policy_screen.dart';
import 'terms_conditions_screen.dart';
import 'login_screen.dart';
import '../utils/currency_helper.dart';
import '../utils/language_helper.dart';
import '../widgets/currency_selection_sheet.dart';
import '../widgets/language_selection_sheet.dart';
import 'package:cashflow_app/l10n/app_localizations.dart';
import 'security_settings_screen.dart';
import '../services/backup_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _passwordController;
  String _selectedCurrency = '₹';
  bool _isEditing = false;
  String _appVersion = '';

  @override
  void initState() {
    super.initState();
    final user = Provider.of<AuthProvider>(context, listen: false).currentUser;
    _firstNameController = TextEditingController(text: user?.firstName);
    _lastNameController = TextEditingController(text: user?.lastName);
    _passwordController = TextEditingController(text: user?.password);
    _selectedCurrency = user?.currency ?? '₹';
    _loadAppVersion();
  }

  Future<void> _loadAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _appVersion = 'v${packageInfo.version} (${packageInfo.buildNumber})';
    });
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _toggleEdit() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _saveProfile() async {
    final firstName = _firstNameController.text.trim();
    final lastName = _lastNameController.text.trim();
    final password = _passwordController.text.trim();

    if (firstName.isEmpty || lastName.isEmpty || password.isEmpty) {
      GlassSnackBar.showWarning(context, message: 'Please fill in all fields');
      return;
    }

    final success = await Provider.of<AuthProvider>(
      context,
      listen: false,
    ).updateUser(firstName, lastName, password, _selectedCurrency);

    if (success) {
      if (mounted) {
        // Update currency in TransactionProvider
        Provider.of<TransactionProvider>(
          context,
          listen: false,
        ).setCurrency(_selectedCurrency);

        GlassSnackBar.showSuccess(
          context,
          message: 'Profile updated successfully',
        );
        setState(() {
          _isEditing = false;
        });
      }
    } else {
      if (mounted) {
        GlassSnackBar.showError(context, message: 'Failed to update profile');
      }
    }
  }

  void _logout() {
    Provider.of<AuthProvider>(context, listen: false).logout();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).currentUser;

    return Scaffold(
      backgroundColor: AppColors.background,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          AppLocalizations.of(context)!.profile,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isEditing ? Icons.check : Icons.edit,
              color: Colors.white,
            ),
            onPressed: _isEditing ? _saveProfile : _toggleEdit,
          ),
        ],
      ),
      body: Stack(
        children: [
          // Gradient Background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF1A1A2E),
                  Color(0xFF16213E),
                  Color(0xFF0F3460),
                  Color(0xFF1A1A2E),
                  Color(0xFF16213E),
                ],
              ),
            ),
          ),
          // Background Blobs
          Positioned(
            top: -100,
            left: -50,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withValues(alpha: 0.2),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.2),
                    blurRadius: 100,
                    spreadRadius: 50,
                  ),
                ],
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        // Profile Avatar
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [AppColors.primary, AppColors.secondary],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withValues(alpha: 0.4),
                                blurRadius: 20,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              user?.firstName.substring(0, 1).toUpperCase() ??
                                  'U',
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          '@${user?.username}',
                          style: TextStyle(color: Colors.white54, fontSize: 16),
                        ),
                        SizedBox(height: 40),

                        // Form Fields
                        GlassContainer(
                          padding: EdgeInsets.all(20),
                          borderRadius: BorderRadius.circular(20),
                          child: Column(
                            children: [
                              _buildTextField(
                                controller: _firstNameController,
                                label: AppLocalizations.of(context)!.firstName,
                                icon: Icons.person_outline,
                                enabled: _isEditing,
                              ),
                              SizedBox(height: 20),
                              _buildTextField(
                                controller: _lastNameController,
                                label: AppLocalizations.of(context)!.lastName,
                                icon: Icons.person_outline,
                                enabled: _isEditing,
                              ),
                              SizedBox(height: 20),
                              _buildTextField(
                                controller: _passwordController,
                                label: AppLocalizations.of(context)!.password,
                                icon: Icons.lock_outline,
                                enabled: _isEditing,
                                obscureText: true,
                                showBorder: _isEditing,
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 20),

                        // App Settings Section (Language)
                        GlassContainer(
                          padding: EdgeInsets.all(16),
                          borderRadius: BorderRadius.circular(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.settings,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 12),
                              Consumer<LanguageProvider>(
                                builder: (context, languageProvider, child) {
                                  final currentLocale =
                                      languageProvider.locale ?? Locale('en');
                                  return Column(
                                    children: [
                                      _buildMenuTile(
                                        icon: Icons.security,
                                        title: 'Security',
                                        subtitle: 'App Lock, PIN, Biometrics',
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (_) =>
                                                  const SecuritySettingsScreen(),
                                            ),
                                          );
                                        },
                                      ),
                                      const Divider(color: Colors.white10),
                                      _buildMenuTile(
                                        icon: Icons.language,
                                        title: AppLocalizations.of(
                                          context,
                                        )!.language,
                                        subtitle: LanguageHelper.getName(
                                          currentLocale.languageCode,
                                        ),
                                        onTap: () async {
                                          final result =
                                              await showModalBottomSheet<
                                                String
                                              >(
                                                context: context,
                                                isScrollControlled: true,
                                                backgroundColor:
                                                    Colors.transparent,
                                                builder: (context) =>
                                                    LanguageSelectionSheet(
                                                      selectedLanguageCode:
                                                          currentLocale
                                                              .languageCode,
                                                    ),
                                              );

                                          if (result != null) {
                                            languageProvider.setLocale(
                                              Locale(result),
                                            );
                                          }
                                        },
                                      ),
                                    ],
                                  );
                                },
                              ),
                              Divider(color: Colors.white10),
                              _buildMenuTile(
                                icon: Icons.currency_exchange,
                                title: AppLocalizations.of(context)!.currency,
                                subtitle:
                                    '$_selectedCurrency ${CurrencyHelper.getName(_selectedCurrency)}',
                                onTap: () async {
                                  final result =
                                      await showModalBottomSheet<String>(
                                        context: context,
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                        builder: (context) =>
                                            CurrencySelectionSheet(
                                              selectedCurrencySymbol:
                                                  _selectedCurrency,
                                            ),
                                      );

                                  if (result != null) {
                                    setState(() {
                                      _selectedCurrency = result;
                                    });
                                    // Update currency in TransactionProvider immediately
                                    Provider.of<TransactionProvider>(
                                      context,
                                      listen: false,
                                    ).setCurrency(_selectedCurrency);

                                    // Also update user profile to persist it
                                    final user = Provider.of<AuthProvider>(
                                      context,
                                      listen: false,
                                    ).currentUser;
                                    if (user != null) {
                                      Provider.of<AuthProvider>(
                                        context,
                                        listen: false,
                                      ).updateUser(
                                        user.firstName,
                                        user.lastName,
                                        user.password,
                                        _selectedCurrency,
                                      );
                                    }
                                  }
                                },
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 20),

                        SizedBox(height: 20),

                        // Data Management Section
                        GlassContainer(
                          padding: EdgeInsets.all(16),
                          borderRadius: BorderRadius.circular(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.dataManagement,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 12),
                              _buildMenuTile(
                                icon: Icons.backup_outlined,
                                title: AppLocalizations.of(context)!.backupData,
                                onTap: () async {
                                  await BackupService().exportDatabase(context);
                                },
                              ),
                              Divider(color: Colors.white10),
                              _buildMenuTile(
                                icon: Icons.restore_outlined,
                                title: AppLocalizations.of(
                                  context,
                                )!.restoreData,
                                onTap: () async {
                                  await BackupService().importDatabase(context);
                                },
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 20),

                        // Help & Support Section
                        GlassContainer(
                          padding: EdgeInsets.all(16),
                          borderRadius: BorderRadius.circular(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.helpAndSupport,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 12),
                              _buildMenuTile(
                                icon: Icons.help_outline,
                                title: 'FAQ',
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => FAQScreen(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 16),

                        // Legal Section
                        GlassContainer(
                          padding: EdgeInsets.all(16),
                          borderRadius: BorderRadius.circular(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Legal',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 12),
                              _buildMenuTile(
                                icon: Icons.privacy_tip_outlined,
                                title: AppLocalizations.of(
                                  context,
                                )!.privacyPolicy,
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => PrivacyPolicyScreen(),
                                    ),
                                  );
                                },
                              ),
                              Divider(color: Colors.white10),
                              _buildMenuTile(
                                icon: Icons.description_outlined,
                                title: AppLocalizations.of(
                                  context,
                                )!.termsAndConditions,
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => TermsConditionsScreen(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 16),

                        // App Version
                        Center(
                          child: Text(
                            'CashFlow $_appVersion',
                            style: TextStyle(
                              color: Colors.white38,
                              fontSize: 12,
                            ),
                          ),
                        ),

                        SizedBox(height: 30),

                        // Logout Button
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: _logout,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.error.withValues(
                                alpha: 0.8,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.logout, color: Colors.white),
                                SizedBox(width: 10),
                                Text(
                                  AppLocalizations.of(context)!.logout,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool enabled = true,
    bool obscureText = false,
    bool showBorder = true,
  }) {
    return TextField(
      controller: controller,
      enabled: enabled,
      obscureText: obscureText,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white70),
        prefixIcon: Icon(icon, color: Colors.white70),
        enabledBorder: showBorder
            ? UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white30),
              )
            : InputBorder.none,
        focusedBorder: showBorder
            ? UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.primary),
              )
            : InputBorder.none,
        disabledBorder: showBorder
            ? UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white10),
              )
            : InputBorder.none,
      ),
    );
  }

  Widget _buildMenuTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    String? subtitle,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Row(
          children: [
            Icon(icon, color: Colors.white70, size: 22),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  if (subtitle != null) ...[
                    SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(color: Colors.white54, fontSize: 13),
                    ),
                  ],
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.white38, size: 20),
          ],
        ),
      ),
    );
  }
}
