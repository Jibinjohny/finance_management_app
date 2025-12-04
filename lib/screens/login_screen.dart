import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../screens/signup_screen.dart';
import '../utils/app_colors.dart';
import '../utils/glass_snackbar.dart';
import '../utils/validators.dart';
import '../utils/page_transitions.dart';
import '../widgets/glass_container.dart';
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
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    final success = await Provider.of<AuthProvider>(
      context,
      listen: false,
    ).login(username, password);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
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
          ..._buildAnimatedBlobs(),

          // Main Content
          SafeArea(child: _buildLoginForm()),
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
            top: -50 + _floatingAnimation.value,
            left: -50,
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
            right: -50,
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
    ];
  }

  Widget _buildLoginForm() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 60),

          // App Logo/Icon
          Container(
            width: 80,
            height: 80,
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
              child: Image.asset('assets/icon/app_icon.png', fit: BoxFit.cover),
            ),
          ),
          SizedBox(height: 24),

          Text(
            AppLocalizations.of(context)!.loginWelcome,
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            AppLocalizations.of(context)!.loginSubtitle,
            style: TextStyle(color: Colors.white60, fontSize: 14),
          ),
          SizedBox(height: 10),
          GestureDetector(
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
                  AppLocalizations.of(context)!.whyLoginLink,
                  style: TextStyle(
                    color: Colors.white38,
                    fontSize: 12,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30),

          // Login Form
          GlassContainer(
            padding: EdgeInsets.all(28),
            borderRadius: BorderRadius.circular(24),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // Username Field
                  Container(
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
                      controller: _usernameController,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                      validator: Validators.validateUsername,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.usernameHint,
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
                          child: Icon(
                            Icons.person_outline,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 18,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),

                  // Password Field
                  Container(
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
                      controller: _passwordController,
                      obscureText: true,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                      validator: Validators.validatePassword,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.passwordHint,
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
                          child: Icon(
                            Icons.lock_outline,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 18,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 32),

                  // Login Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: Consumer<AuthProvider>(
                      builder: (context, auth, child) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            gradient: LinearGradient(
                              colors: [
                                AppColors.primary,
                                AppColors.primary.withValues(alpha: 0.8),
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withValues(alpha: 0.4),
                                blurRadius: 20,
                                offset: Offset(0, 10),
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            onPressed: auth.isLoading ? null : _login,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: auth.isLoading
                                ? SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2.5,
                                    ),
                                  )
                                : Text(
                                    AppLocalizations.of(context)!.loginButton,
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

          // Sign Up Link
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.noAccount,
                style: TextStyle(color: Colors.white60, fontSize: 14),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(
                    context,
                  ).push(SlidePageRoute(page: const SignupScreen()));
                },
                child: Text(
                  AppLocalizations.of(context)!.signUpLink,
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),

          // Reset Button - Only visible in debug mode
          if (kDebugMode) SizedBox(height: 20),
          if (kDebugMode)
            TextButton(
              onPressed: () async {
                final resetMessage = AppLocalizations.of(
                  context,
                )!.resetDataMessage;
                await Provider.of<AuthProvider>(
                  context,
                  listen: false,
                ).resetData();
                if (context.mounted) {
                  GlassSnackBar.showInfo(context, message: resetMessage);
                }
              },
              child: Text(
                'Reset App Data (Debug)',
                style: TextStyle(color: AppColors.error, fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }
}
