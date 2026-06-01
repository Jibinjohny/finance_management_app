import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
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
import '../widgets/apple_liquid_glass_button.dart';
import 'main_screen.dart';
import 'package:cashflow_app/l10n/app_localizations.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String _selectedCurrency = '₹';
  int _currentStep = 0;

  late AnimationController _floatingController;
  late Animation<double> _floatingAnimation;
  late AnimationController _buttonScaleController;

  bool _isPasswordObscured = true;

  @override
  void initState() {
    super.initState();
    
    _floatingController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat(reverse: true);

    _floatingAnimation = Tween<double>(begin: -8, end: 8).animate(
      CurvedAnimation(parent: _floatingController, curve: Curves.easeInOut),
    );

    _buttonScaleController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
      lowerBound: 0.95,
      upperBound: 1.0,
      value: 1.0,
    );
  }

  @override
  void dispose() {
    _floatingController.dispose();
    _buttonScaleController.dispose();
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
    _buttonScaleController.reverse();

    final firstName = _firstNameController.text.trim();
    final lastName = _lastNameController.text.trim();
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    final success = await Provider.of<AuthProvider>(
      context,
      listen: false,
    ).signup(firstName, lastName, username, password, _selectedCurrency);

    _buttonScaleController.forward();

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
      backgroundColor: AppColors.background,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: [
            // Rich Ambient Gradient Background
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
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
            ),

            // Pulsing Glowing Ambient Backdrops
            ..._buildAnimatedBlobs(),

            // Main Content
            SafeArea(
              child: Column(
                children: [
                  // App bar and navigation
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Row(
                      children: [
                        _currentStep > 0
                            ? IconButton(
                                icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
                                onPressed: _prevStep,
                              )
                            : IconButton(
                                icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                _currentStep == 0
                                    ? AppLocalizations.of(context)!.step1Title.toUpperCase()
                                    : AppLocalizations.of(context)!.step2Title.toUpperCase(),
                                style: GoogleFonts.outfit(
                                  color: AppColors.secondary,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _currentStep == 0
                                    ? AppLocalizations.of(context)!.step1Subtitle
                                    : AppLocalizations.of(context)!.step2Subtitle,
                                style: GoogleFonts.outfit(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 48), // Balancing spacer
                      ],
                    ),
                  ),

                  // Cozy Step Progress bar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 4,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(2),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primary.withOpacity(0.3),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            height: 4,
                            decoration: BoxDecoration(
                              color: _currentStep >= 1
                                  ? AppColors.primary
                                  : Colors.white.withOpacity(0.08),
                              borderRadius: BorderRadius.circular(2),
                              boxShadow: _currentStep >= 1
                                  ? [
                                      BoxShadow(
                                        color: AppColors.primary.withOpacity(0.3),
                                        blurRadius: 4,
                                      ),
                                    ]
                                  : null,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: Center(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          children: [
                            // Glowing App Logo
                            Container(
                              width: 70,
                              height: 70,
                              padding: const EdgeInsets.all(2.5),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.primary,
                                    AppColors.secondary,
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primary.withOpacity(0.25),
                                    blurRadius: 25,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                              child: Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF0F1016),
                                ),
                                child: ClipOval(
                                  child: Image.asset(
                                    'assets/icon/app_icon.png',
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Icon(
                                        Icons.account_balance_wallet_outlined,
                                        size: 30,
                                        color: AppColors.primary,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                            
                            const SizedBox(height: 32),

                            // Frosted Glass Register Wizard Card
                            GlassContainer(
                              padding: const EdgeInsets.all(28),
                              borderRadius: BorderRadius.circular(28),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (_currentStep == 0) ...[
                                      // First Name Field
                                      Text(
                                        "FIRST NAME",
                                        style: GoogleFonts.outfit(
                                          color: AppColors.secondary.withOpacity(0.8),
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.5,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      _buildTextField(
                                        controller: _firstNameController,
                                        hint: AppLocalizations.of(context)!.firstName,
                                        icon: Icons.person_outline_rounded,
                                        validator: Validators.validateName,
                                        textInputAction: TextInputAction.next,
                                      ),
                                      const SizedBox(height: 18),

                                      // Last Name Field
                                      Text(
                                        "LAST NAME",
                                        style: GoogleFonts.outfit(
                                          color: AppColors.secondary.withOpacity(0.8),
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.5,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      _buildTextField(
                                        controller: _lastNameController,
                                        hint: AppLocalizations.of(context)!.lastName,
                                        icon: Icons.person_outline_rounded,
                                        validator: Validators.validateName,
                                        textInputAction: TextInputAction.next,
                                      ),
                                      const SizedBox(height: 18),

                                      // Username Field
                                      Text(
                                        "USERNAME",
                                        style: GoogleFonts.outfit(
                                          color: AppColors.secondary.withOpacity(0.8),
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.5,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      _buildTextField(
                                        controller: _usernameController,
                                        hint: AppLocalizations.of(context)!.username,
                                        icon: Icons.alternate_email_rounded,
                                        validator: Validators.validateUsername,
                                        textInputAction: TextInputAction.next,
                                      ),
                                      const SizedBox(height: 18),

                                      // Password Field
                                      Text(
                                        "PASSWORD",
                                        style: GoogleFonts.outfit(
                                          color: AppColors.secondary.withOpacity(0.8),
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.5,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      _buildTextField(
                                        controller: _passwordController,
                                        hint: AppLocalizations.of(context)!.password,
                                        icon: Icons.lock_outline_rounded,
                                        isPassword: true,
                                        validator: Validators.validatePassword,
                                        textInputAction: TextInputAction.done,
                                      ),
                                    ] else ...[
                                      // Step 2: Preferences
                                      Text(
                                        "PRIMARY LEDGER CURRENCY",
                                        style: GoogleFonts.outfit(
                                          color: AppColors.secondary.withOpacity(0.8),
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.5,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      _buildCurrencySelector(),
                                      const SizedBox(height: 20),

                                      Text(
                                        "APPLICATION LANGUAGE",
                                        style: GoogleFonts.outfit(
                                          color: AppColors.secondary.withOpacity(0.8),
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.5,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      _buildLanguageSelector(),
                                      const SizedBox(height: 32),
                                      
                                      _buildWhySignupInfo(),
                                    ],

                                    const SizedBox(height: 32),

                                    // Primary Action button
                                    Consumer<AuthProvider>(
                                      builder: (context, auth, child) {
                                        return AppleLiquidGlassButton(
                                          onPressed: _currentStep == 0 ? _nextStep : _signup,
                                          isLoading: auth.isLoading,
                                          label: _currentStep == 0
                                              ? AppLocalizations.of(context)!.nextButton
                                              : AppLocalizations.of(context)!.signup,
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            
                            const SizedBox(height: 32),

                            // Already have account redirect
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.alreadyHaveAccount,
                                  style: GoogleFonts.inter(
                                    color: Colors.white.withOpacity(0.6),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    AppLocalizations.of(context)!.login,
                                    style: GoogleFonts.outfit(
                                      color: AppColors.secondary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      letterSpacing: 0.3,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool isPassword = false,
    String? Function(String?)? validator,
    TextInputAction textInputAction = TextInputAction.next,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword && _isPasswordObscured,
      style: GoogleFonts.inter(
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
      validator: validator,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white.withOpacity(0.03),
        hintText: hint,
        hintStyle: GoogleFonts.inter(
          color: Colors.white.withOpacity(0.3),
          fontSize: 14,
        ),
        prefixIcon: Icon(
          icon,
          color: AppColors.primary.withOpacity(0.7),
          size: 18,
        ),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  _isPasswordObscured
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: Colors.white.withOpacity(0.4),
                  size: 18,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordObscured = !_isPasswordObscured;
                  });
                },
              )
            : null,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: Colors.white.withOpacity(0.08),
            width: 1.2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: AppColors.error.withOpacity(0.4),
            width: 1.2,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: AppColors.error,
            width: 1.5,
          ),
        ),
      ),
    );
  }

  Widget _buildCurrencySelector() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white.withOpacity(0.03),
        border: Border.all(
          color: Colors.white.withOpacity(0.08),
          width: 1.2,
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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _selectedCurrency,
                        style: GoogleFonts.outfit(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        CurrencyHelper.getName(_selectedCurrency),
                        style: GoogleFonts.inter(
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
              Icon(Icons.unfold_more_rounded, color: Colors.white.withOpacity(0.6), size: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageSelector() {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        final currentLocale = languageProvider.locale ?? const Locale('en');
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white.withOpacity(0.03),
            border: Border.all(
              color: Colors.white.withOpacity(0.08),
              width: 1.2,
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            currentLocale.languageCode.toUpperCase(),
                            style: GoogleFonts.outfit(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            LanguageHelper.getName(currentLocale.languageCode),
                            style: GoogleFonts.inter(
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
                  Icon(Icons.unfold_more_rounded, color: Colors.white.withOpacity(0.6), size: 20),
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
            backgroundColor: const Color(0xFF0F1016),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
              side: BorderSide(color: Colors.white.withOpacity(0.08)),
            ),
            title: Text(
              AppLocalizations.of(context)!.whyLoginTitle,
              style: GoogleFonts.outfit(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: SingleChildScrollView(
              child: Text(
                AppLocalizations.of(context)!.whyLoginContent,
                style: GoogleFonts.inter(
                  color: Colors.white.withOpacity(0.7),
                  height: 1.5,
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  AppLocalizations.of(context)!.whyLoginAction,
                  style: GoogleFonts.outfit(
                    color: AppColors.secondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.info_outline, color: AppColors.secondary.withOpacity(0.8), size: 14),
          const SizedBox(width: 6),
          Text(
            AppLocalizations.of(context)!.whyNeedSignup,
            style: GoogleFonts.inter(
              color: Colors.white.withOpacity(0.5),
              fontSize: 12,
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildAnimatedBlobs() {
    return [
      AnimatedBuilder(
        animation: _floatingAnimation,
        builder: (context, child) {
          return Positioned(
            top: -60 + _floatingAnimation.value * 1.5,
            right: -60,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.primary.withOpacity(0.35),
                    AppColors.primary.withOpacity(0.0),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      AnimatedBuilder(
        animation: _floatingAnimation,
        builder: (context, child) {
          return Positioned(
            bottom: 60 - _floatingAnimation.value * 1.5,
            left: -60,
            child: Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.secondary.withOpacity(0.35),
                    AppColors.secondary.withOpacity(0.0),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    ];
  }
}
