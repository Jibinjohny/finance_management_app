import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/language_provider.dart';
import '../utils/app_colors.dart';
import '../utils/glass_snackbar.dart';
import '../utils/validators.dart';
import '../utils/currency_helper.dart';
import '../utils/language_helper.dart';
import '../widgets/currency_selection_sheet.dart';
import '../widgets/language_selection_sheet.dart';
import '../widgets/glass_container.dart';
import 'main_screen.dart';
import 'package:cashflow_app/l10n/app_localizations.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String _selectedCurrency = '₹';
  int _currentStep = 0;

  late AnimationController _floatingController;
  late Animation<double> _floatingAnimation;

  @override
  void initState() {
    super.initState();
    _floatingController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _floatingAnimation = Tween<double>(begin: -10, end: 10).animate(
      CurvedAnimation(parent: _floatingController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _floatingController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep == 0) {
      if (_formKey.currentState!.validate()) {
        setState(() {
          _currentStep = 1;
        });
      }
    }
  }

  void _prevStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }

  void _signup() async {
    final firstName = _firstNameController.text.trim();
    final lastName = _lastNameController.text.trim();
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    final success = await Provider.of<AuthProvider>(
      context,
      listen: false,
    ).signup(firstName, lastName, username, password, _selectedCurrency);

    if (success) {
      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const MainScreen()),
          (route) => false,
        );
        GlassSnackBar.showSuccess(
          context,
          message: 'Account created successfully!',
        );
      }
    } else {
      if (mounted) {
        GlassSnackBar.showError(context, message: 'Username already exists');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Animated Gradient Background
          AnimatedContainer(
            duration: Duration(milliseconds: 500),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF1A1A2E),
                  Color(0xFF16213E),
                  Color(0xFF0F3460),
                ],
              ),
            ),
          ),

          // Animated Background Blobs
          AnimatedBuilder(
            animation: _floatingAnimation,
            builder: (context, child) {
              return Positioned(
                top: -50 + _floatingAnimation.value,
                right: -50,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppColors.primary.withValues(alpha: 0.4),
                        AppColors.primary.withValues(alpha: 0.1),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.3),
                        blurRadius: 100,
                        spreadRadius: 50,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          AnimatedBuilder(
            animation: _floatingAnimation,
            builder: (context, child) {
              return Positioned(
                bottom: 100 - _floatingAnimation.value,
                left: -50,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppColors.secondary.withValues(alpha: 0.4),
                        AppColors.secondary.withValues(alpha: 0.1),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.secondary.withValues(alpha: 0.3),
                        blurRadius: 100,
                        spreadRadius: 50,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          // Main Content
          SafeArea(
            child: Column(
              children: [
                // Header with Back Button (only for step 2)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Row(
                    children: [
                      if (_currentStep > 0)
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white,
                          ),
                          onPressed: _prevStep,
                        )
                      else
                        SizedBox(width: 48), // Placeholder for alignment
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              _currentStep == 0
                                  ? AppLocalizations.of(context)!.step1Title
                                  : AppLocalizations.of(context)!.step2Title,
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              _currentStep == 0
                                  ? AppLocalizations.of(context)!.step1Subtitle
                                  : AppLocalizations.of(context)!.step2Subtitle,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 48), // Balance the back button
                    ],
                  ),
                ),

                // Progress Indicator
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 4,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          height: 4,
                          decoration: BoxDecoration(
                            color: _currentStep >= 1
                                ? AppColors.primary
                                : Colors.white.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(24),
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        // App Logo/Icon (Smaller in wizard)
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withValues(alpha: 0.5),
                                blurRadius: 20,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/icon/app_icon.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 32),

                        // Form Content
                        GlassContainer(
                          padding: EdgeInsets.all(28),
                          borderRadius: BorderRadius.circular(24),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                if (_currentStep == 0) ...[
                                  // Step 1: Basic Details
                                  _buildTextField(
                                    controller: _firstNameController,
                                    hint: AppLocalizations.of(
                                      context,
                                    )!.firstName,
                                    icon: Icons.person_outline,
                                    validator: Validators.validateName,
                                  ),
                                  SizedBox(height: 16),
                                  _buildTextField(
                                    controller: _lastNameController,
                                    hint: AppLocalizations.of(
                                      context,
                                    )!.lastName,
                                    icon: Icons.person_outline,
                                    validator: Validators.validateName,
                                  ),
                                  SizedBox(height: 16),
                                  _buildTextField(
                                    controller: _usernameController,
                                    hint: AppLocalizations.of(
                                      context,
                                    )!.username,
                                    icon: Icons.alternate_email,
                                    validator: Validators.validateUsername,
                                  ),
                                  SizedBox(height: 16),
                                  _buildTextField(
                                    controller: _passwordController,
                                    hint: AppLocalizations.of(
                                      context,
                                    )!.password,
                                    icon: Icons.lock_outline,
                                    isPassword: true,
                                    validator: Validators.validatePassword,
                                  ),
                                ] else ...[
                                  // Step 2: Preferences
                                  _buildCurrencySelector(),
                                  SizedBox(height: 16),
                                  _buildLanguageSelector(),
                                  SizedBox(height: 32),
                                  _buildWhySignupInfo(),
                                ],

                                SizedBox(height: 32),

                                // Action Button
                                SizedBox(
                                  width: double.infinity,
                                  height: 56,
                                  child: Consumer<AuthProvider>(
                                    builder: (context, auth, child) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                          gradient: LinearGradient(
                                            colors: [
                                              AppColors.primary,
                                              AppColors.primary.withValues(
                                                alpha: 0.8,
                                              ),
                                            ],
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: AppColors.primary
                                                  .withValues(alpha: 0.4),
                                              blurRadius: 20,
                                              offset: Offset(0, 10),
                                            ),
                                          ],
                                        ),
                                        child: ElevatedButton(
                                          onPressed: auth.isLoading
                                              ? null
                                              : (_currentStep == 0
                                                    ? _nextStep
                                                    : _signup),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.transparent,
                                            shadowColor: Colors.transparent,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                          ),
                                          child: auth.isLoading
                                              ? SizedBox(
                                                  height: 24,
                                                  width: 24,
                                                  child:
                                                      CircularProgressIndicator(
                                                        color: Colors.white,
                                                        strokeWidth: 2.5,
                                                      ),
                                                )
                                              : Text(
                                                  _currentStep == 0
                                                      ? AppLocalizations.of(
                                                          context,
                                                        )!.nextButton
                                                      : AppLocalizations.of(
                                                          context,
                                                        )!.signup,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    letterSpacing: 0.5,
                                                  ),
                                                ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 24),

                        // Login Link
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.alreadyHaveAccount,
                              style: TextStyle(
                                color: Colors.white60,
                                fontSize: 14,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                AppLocalizations.of(context)!.login,
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
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
    required String hint,
    required IconData icon,
    bool isPassword = false,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [
            Colors.white.withValues(alpha: 0.05),
            Colors.white.withValues(alpha: 0.02),
          ],
        ),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
        validator: validator,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.white.withValues(alpha: 0.4),
            fontSize: 15,
          ),
          border: InputBorder.none,
          prefixIcon: Container(
            margin: EdgeInsets.all(12),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primary,
                  AppColors.primary.withValues(alpha: 0.7),
                ],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        ),
      ),
    );
  }

  Widget _buildCurrencySelector() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [
            Colors.white.withValues(alpha: 0.05),
            Colors.white.withValues(alpha: 0.02),
          ],
        ),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: GestureDetector(
        onTap: () async {
          final result = await showModalBottomSheet<String>(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => CurrencySelectionSheet(
              selectedCurrencySymbol: _selectedCurrency,
            ),
          );

          if (result != null) {
            setState(() {
              _selectedCurrency = result;
            });
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _selectedCurrency,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        CurrencyHelper.getName(_selectedCurrency),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_drop_down, color: Colors.white70),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageSelector() {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        final currentLocale = languageProvider.locale ?? Locale('en');
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [
                Colors.white.withValues(alpha: 0.05),
                Colors.white.withValues(alpha: 0.02),
              ],
            ),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.1),
              width: 1,
            ),
          ),
          child: GestureDetector(
            onTap: () async {
              final result = await showModalBottomSheet<String>(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => LanguageSelectionSheet(
                  selectedLanguageCode: currentLocale.languageCode,
                ),
              );

              if (result != null) {
                languageProvider.setLocale(Locale(result));
              }
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            currentLocale.languageCode.toUpperCase(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            LanguageHelper.getName(currentLocale.languageCode),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.arrow_drop_down, color: Colors.white70),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildWhySignupInfo() {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Color(0xFF1A1A2E),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(color: Colors.white10),
            ),
            title: Text(
              AppLocalizations.of(context)!.whyLoginTitle,
              style: TextStyle(color: Colors.white),
            ),
            content: SingleChildScrollView(
              child: Text(
                AppLocalizations.of(context)!.whyLoginContent,
                style: TextStyle(color: Colors.white70),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(AppLocalizations.of(context)!.whyLoginAction),
              ),
            ],
          ),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.info_outline, color: Colors.white38, size: 14),
          SizedBox(width: 4),
          Text(
            AppLocalizations.of(context)!.whyNeedSignup,
            style: TextStyle(
              color: Colors.white38,
              fontSize: 12,
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
    );
  }
}
