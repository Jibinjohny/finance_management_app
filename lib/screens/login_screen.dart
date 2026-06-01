import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/auth_provider.dart';
import '../screens/signup_screen.dart';
import '../services/demo_seeder.dart';
import '../utils/app_colors.dart';
import '../utils/glass_snackbar.dart';
import '../utils/validators.dart';
import '../utils/page_transitions.dart';
import '../widgets/glass_container.dart';
import '../widgets/apple_liquid_glass_button.dart';
import 'main_screen.dart';
import 'package:cashflow_app/l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  
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
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _buttonScaleController.reverse();

    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    final success = await Provider.of<AuthProvider>(
      context,
      listen: false,
    ).login(username, password);

    _buttonScaleController.forward();

    if (success) {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const MainScreen()),
        );
      }
    } else {
      if (mounted) {
        GlassSnackBar.showError(
          context,
          message: AppLocalizations.of(context)!.invalidCredentials,
        );
      }
    }
  }

  void _seedAndLoginDemo() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    // 1. Show dynamic seeding loader
    if (mounted) {
      GlassSnackBar.showInfo(
        context,
        message: "Seeding realistic financial data ledger...",
      );
    }

    // 2. Try to sign up demo user; if username exists, simply proceed to login
    bool success = await authProvider.signup(
      "Jibin",
      "Johny",
      "demo",
      "password",
      "₹",
    );

    if (!success) {
      success = await authProvider.login("demo", "password");
    }

    if (success && authProvider.currentUser != null) {
      final demoUserId = authProvider.currentUser!.id;
      final currency = authProvider.currentUser!.currency;

      try {
        // 3. Seed 30+ highly-detailed, dynamic ledger transactions relative to today
        await DemoSeeder.seedDemoData(demoUserId, currency);

        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const MainScreen()),
          );

          GlassSnackBar.showSuccess(
            context,
            message: "App ledger successfully seeded! Welcome to CashFlow.",
          );
        }
      } catch (e) {
        if (mounted) {
          GlassSnackBar.showError(
            context,
            message: "Data seeding failed: $e",
          );
        }
      }
    } else {
      if (mounted) {
        GlassSnackBar.showError(
          context,
          message: "Failed to authenticate demo user account.",
        );
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

            // Floating Blurred Neon Blobs for Deep Glassmorphic Contrast
            ..._buildAnimatedBlobs(),

            // Main Content
            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),

                      // Gentle Floating Header & App Logo
                      AnimatedBuilder(
                        animation: _floatingAnimation,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: Offset(0, _floatingAnimation.value),
                            child: Column(
                              children: [
                                // Glowing App Logo
                                Container(
                                  width: 90,
                                  height: 90,
                                  padding: const EdgeInsets.all(3),
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
                                        color: AppColors.primary.withOpacity(0.35),
                                        blurRadius: 30,
                                        spreadRadius: 2,
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
                                            size: 40,
                                            color: AppColors.primary,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),

                                // Title and Subtitle with Custom Outfit Typography
                                Text(
                                  AppLocalizations.of(context)!.loginWelcome,
                                  style: GoogleFonts.outfit(
                                    color: Colors.white,
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  AppLocalizations.of(context)!.loginSubtitle,
                                  style: GoogleFonts.inter(
                                    color: Colors.white.withOpacity(0.5),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      
                      const SizedBox(height: 12),

                      // Why Log In Helper Dialog Trigger
                      GestureDetector(
                        onTap: () => _showWhyLoginDialog(context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.03),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.06),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.info_outline, color: AppColors.secondary.withOpacity(0.8), size: 14),
                              const SizedBox(width: 6),
                              Text(
                                AppLocalizations.of(context)!.whyLoginLink,
                                style: GoogleFonts.inter(
                                  color: Colors.white.withOpacity(0.5),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 28),

                      // Frosted Glass Form Card
                      GlassContainer(
                        padding: const EdgeInsets.all(28),
                        borderRadius: BorderRadius.circular(28),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Username Label
                              Text(
                                "USERNAME",
                                style: GoogleFonts.outfit(
                                  color: AppColors.secondary.withOpacity(0.8),
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5,
                                ),
                              ),
                              const SizedBox(height: 8),
                              
                              // Glowing Interactive Username Field
                              TextFormField(
                                controller: _usernameController,
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                                validator: Validators.validateUsername,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.03),
                                  hintText: AppLocalizations.of(context)!.usernameHint,
                                  hintStyle: GoogleFonts.inter(
                                    color: Colors.white.withOpacity(0.3),
                                    fontSize: 14,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.alternate_email_rounded,
                                    color: AppColors.primary.withOpacity(0.7),
                                    size: 18,
                                  ),
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
                              ),
                              const SizedBox(height: 20),

                              // Password Label
                              Text(
                                "PASSWORD",
                                style: GoogleFonts.outfit(
                                  color: AppColors.secondary.withOpacity(0.8),
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5,
                                ),
                              ),
                              const SizedBox(height: 8),

                              // Glowing Interactive Password Field
                              TextFormField(
                                controller: _passwordController,
                                obscureText: _isPasswordObscured,
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                                validator: Validators.validatePassword,
                                onFieldSubmitted: (_) => _login(),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.03),
                                  hintText: AppLocalizations.of(context)!.passwordHint,
                                  hintStyle: GoogleFonts.inter(
                                    color: Colors.white.withOpacity(0.3),
                                    fontSize: 14,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.lock_outline_rounded,
                                    color: AppColors.primary.withOpacity(0.7),
                                    size: 18,
                                  ),
                                  suffixIcon: IconButton(
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
                                  ),
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
                              ),
                              const SizedBox(height: 32),

                              // Tactile Interactive Premium Button
                              Consumer<AuthProvider>(
                                builder: (context, auth, child) {
                                  return AppleLiquidGlassButton(
                                    onPressed: _login,
                                    isLoading: auth.isLoading,
                                    label: AppLocalizations.of(context)!.loginButton,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),


                      if (kDebugMode) ...[
                        const SizedBox(height: 20),

                        // Explore Demo Mode Button
                        AppleLiquidGlassButton(
                          onPressed: _seedAndLoginDemo,
                          icon: Icons.explore_outlined,
                          label: "EXPLORE IN DEMO MODE",
                          glowColor: AppColors.secondary,
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              AppColors.secondary.withValues(alpha: 0.25),
                              AppColors.secondary.withValues(alpha: 0.1),
                              Colors.white.withValues(alpha: 0.02),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                      ] else ...[
                        const SizedBox(height: 32),
                      ],

                      // Premium Styled Sign Up Redirect
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.noAccount,
                            style: GoogleFonts.inter(
                              color: Colors.white.withOpacity(0.6),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(width: 6),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                SlidePageRoute(page: const SignupScreen()),
                              );
                            },
                            child: Text(
                              AppLocalizations.of(context)!.signUpLink,
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

                      // Safe Clean Database Reset Button for Debugging
                      if (kDebugMode) ...[
                        const SizedBox(height: 30),
                        TextButton(
                          onPressed: () async {
                            final resetMessage = AppLocalizations.of(context)!.resetDataMessage;
                            await Provider.of<AuthProvider>(
                              context,
                              listen: false,
                            ).resetData();
                            if (context.mounted) {
                              GlassSnackBar.showInfo(context, message: resetMessage);
                            }
                          },
                          child: Text(
                            'Reset Application Ledger (Debug)',
                            style: GoogleFonts.inter(
                              color: AppColors.error.withOpacity(0.8),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Double layer pulsing blobs to construct premium glass depth
  List<Widget> _buildAnimatedBlobs() {
    return [
      AnimatedBuilder(
        animation: _floatingAnimation,
        builder: (context, child) {
          return Positioned(
            top: -60 + _floatingAnimation.value * 1.5,
            left: -60,
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
            right: -60,
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

  void _showWhyLoginDialog(BuildContext context) {
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
  }
}
