import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/auth_provider.dart';
import '../utils/app_colors.dart';
import 'intro_screen.dart';
import 'login_screen.dart';
import 'main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _rotationController;
  late AnimationController _textController;
  late AnimationController _pulseController;
  
  late Animation<double> _logoScale;
  late Animation<double> _logoFade;
  late Animation<double> _logoRotate;
  late Animation<double> _textFade;
  late Animation<double> _textSlide;
  late Animation<double> _pulseGlow;

  @override
  void initState() {
    super.initState();

    // 1. Logo scale and fade entry
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1400),
      vsync: this,
    );

    _logoScale = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.elasticOut),
    );

    _logoFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeIn),
    );

    // 2. Slow continuous rotation for outer neon ring
    _rotationController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();

    _logoRotate = Tween<double>(begin: 0.0, end: 2 * math.pi).animate(
      CurvedAnimation(parent: _rotationController, curve: Curves.linear),
    );

    // 3. Staggered text fade and slide reveal
    _textController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _textFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _textController, curve: const Interval(0.2, 1.0, curve: Curves.easeOut)),
    );

    _textSlide = Tween<double>(begin: 30.0, end: 0.0).animate(
      CurvedAnimation(parent: _textController, curve: const Interval(0.2, 1.0, curve: Curves.easeOutCubic)),
    );

    // 4. Ambient background portal pulse
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _pulseGlow = Tween<double>(begin: 1.0, end: 1.25).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Start staggered animations
    _logoController.forward().then((_) {
      _textController.forward();
    });

    _navigateToNext();
  }

  Future<void> _navigateToNext() async {
    // Elegant delayed reveal window (3.5 seconds total)
    await Future.delayed(const Duration(milliseconds: 3500));

    if (!mounted) return;

    // Check for auto-login
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final isLoggedIn = await authProvider.tryAutoLogin();

    if (!mounted) return;

    Widget nextScreen;

    if (isLoggedIn) {
      nextScreen = const MainScreen();
    } else {
      final prefs = await SharedPreferences.getInstance();
      final hasSeenIntro = prefs.getBool('hasSeenIntro') ?? false;

      if (hasSeenIntro) {
        nextScreen = const LoginScreen();
      } else {
        nextScreen = const IntroScreen();
      }
    }

    if (mounted) {
      // Execute the custom high-fidelity Zoom-Fade Page Transition
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => nextScreen,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Elegant zoom out on the outgoing splash, and smooth fade zoom in on incoming screen
            final zoomIn = Tween<double>(begin: 0.95, end: 1.0).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeInOutCubic),
            );
            final fade = Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeInOut),
            );
            return FadeTransition(
              opacity: fade,
              child: ScaleTransition(
                scale: zoomIn,
                child: child,
              ),
            );
          },
          transitionDuration: const Duration(milliseconds: 800),
        ),
      );
    }
  }

  @override
  void dispose() {
    _logoController.dispose();
    _rotationController.dispose();
    _textController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
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

          // Pulsing Ambient Glowing Portal Blurs
          ..._buildPulsingBlobs(),

          // Main Animated Logo & Branding Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Outer Rotating Ring + Logo Container
                AnimatedBuilder(
                  animation: Listenable.merge([_logoController, _rotationController]),
                  builder: (context, child) {
                    return Opacity(
                      opacity: _logoFade.value,
                      child: Transform.scale(
                        scale: _logoScale.value,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Neon Rotating Ring Slices
                            Transform.rotate(
                              angle: _logoRotate.value,
                              child: Container(
                                width: 160,
                                height: 160,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: SweepGradient(
                                    colors: [
                                      AppColors.primary,
                                      AppColors.secondary,
                                      AppColors.primary.withOpacity(0.1),
                                      AppColors.primary,
                                    ],
                                    stops: const [0.0, 0.25, 0.75, 1.0],
                                  ),
                                ),
                              ),
                            ),
                            
                            // Frosted Mask to separate ring from logo
                            Container(
                              width: 152,
                              height: 152,
                              decoration: const BoxDecoration(
                                color: Color(0xFF16213E),
                                shape: BoxShape.circle,
                              ),
                            ),

                            // Glowing Central App Icon Card
                            Container(
                              width: 140,
                              height: 140,
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0xFF0A0B10),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primary.withOpacity(0.4),
                                    blurRadius: 40,
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
                                        size: 55,
                                        color: AppColors.primary,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 48),

                // Staggered Slide-Fade Text Branding
                AnimatedBuilder(
                  animation: _textController,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _textFade.value,
                      child: Transform.translate(
                        offset: Offset(0, _textSlide.value),
                        child: Column(
                          children: [
                            // App Name using Premium Outfit Typography
                            Text(
                              'CashFlow',
                              style: GoogleFonts.outfit(
                                fontSize: 42,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 2.0,
                              ),
                            ),
                            const SizedBox(height: 8),
                            // Slogan using Premium Inter Typography
                            Text(
                              'Track Your Finances',
                              style: GoogleFonts.inter(
                                fontSize: 15,
                                color: Colors.white.withOpacity(0.6),
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                
                const SizedBox(height: 60),

                // Cohesive pulsing loading dots
                AnimatedBuilder(
                  animation: _textController,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _textFade.value,
                      child: SizedBox(
                        width: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(3, (index) {
                            return _buildPulsingDot(index);
                          }),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPulsingDot(int index) {
    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        // Staggered breath pulse calculation
        final activePulse = math.sin((_pulseController.value * math.pi) - (index * 0.5));
        final opacity = ((activePulse + 1.0) / 2.0).clamp(0.1, 0.8);
        return Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.secondary.withOpacity(opacity),
            boxShadow: [
              if (opacity > 0.4)
                BoxShadow(
                  color: AppColors.secondary.withOpacity(opacity * 0.5),
                  blurRadius: 4,
                  spreadRadius: 1,
                ),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _buildPulsingBlobs() {
    return [
      AnimatedBuilder(
        animation: _pulseController,
        builder: (context, child) {
          return Positioned(
            top: -100,
            left: -100,
            child: Transform.scale(
              scale: _pulseGlow.value,
              child: Container(
                width: 350,
                height: 350,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.primary.withOpacity(0.3),
                      AppColors.primary.withOpacity(0.0),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
      AnimatedBuilder(
        animation: _pulseController,
        builder: (context, child) {
          return Positioned(
            bottom: -100,
            right: -100,
            child: Transform.scale(
              scale: _pulseGlow.value,
              child: Container(
                width: 380,
                height: 380,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.secondary.withOpacity(0.25),
                      AppColors.secondary.withOpacity(0.0),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    ];
  }
}
