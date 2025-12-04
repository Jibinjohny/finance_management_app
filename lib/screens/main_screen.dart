import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import '../utils/app_colors.dart';
import '../widgets/glass_container.dart';
import 'package:provider/provider.dart';
import '../providers/account_provider.dart';
import 'dashboard_screen.dart';
import 'accounts_screen.dart';
import 'add_account_screen.dart';
import 'stats_screen.dart';
import 'monthly_report_screen.dart';
import 'add_transaction_screen_multistep.dart';
import 'package:cashflow_app/l10n/app_localizations.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  int? _targetIndex; // Track the target page during animation
  late PageController _pageController;
  double _backgroundOffset = 0.0;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const AccountsScreen(),
    const StatsScreen(),
    const MonthlyReportScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
    _pageController.addListener(() {
      if (_pageController.hasClients && _pageController.page != null) {
        setState(() {
          // Move background at half speed for parallax effect
          _backgroundOffset = _pageController.page! * -50;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    // Only update if we're not in the middle of a programmatic navigation
    // or if this is the target page
    if (_targetIndex == null || index == _targetIndex) {
      setState(() {
        _currentIndex = index;
        _targetIndex = null; // Clear target once reached
      });
    }
  }

  void _onNavItemTapped(int index) {
    // Set target index to prevent intermediate page callbacks from updating UI
    _targetIndex = index;

    // Immediately update the selected state to prevent glitching
    setState(() {
      _currentIndex = index;
    });

    // Animate to the selected page
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 400),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Continuous Background
          // Continuous Background
          Positioned(
            left: _backgroundOffset,
            top: 0,
            bottom: 0,
            width: MediaQuery.of(context).size.width * 3,
            child: Container(
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
          ),

          // Blob 1: Top Left - Primary - Slow Parallax (Large)
          Positioned(
            top: -150,
            left: -100 + (_backgroundOffset * 0.2),
            child: Container(
              width: 450,
              height: 450,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withValues(alpha: 0.25),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.25),
                    blurRadius: 150,
                    spreadRadius: 80,
                  ),
                ],
              ),
            ),
          ),

          // Blob 2: Middle Right - Secondary - Medium Parallax (Medium)
          Positioned(
            top: MediaQuery.of(context).size.height * 0.3,
            left:
                MediaQuery.of(context).size.width * 0.8 +
                (_backgroundOffset * 0.5),
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.secondary.withValues(alpha: 0.2),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.secondary.withValues(alpha: 0.2),
                    blurRadius: 120,
                    spreadRadius: 60,
                  ),
                ],
              ),
            ),
          ),

          // Blob 3: Bottom Left - Mixed/Primary - Fast Parallax (Small)
          Positioned(
            bottom: -20,
            left:
                MediaQuery.of(context).size.width * 0.1 +
                (_backgroundOffset * 0.8),
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withValues(alpha: 0.3),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 90,
                    spreadRadius: 45,
                  ),
                ],
              ),
            ),
          ),

          // Main Content PageView
          PageView(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            physics: BouncingScrollPhysics(),
            children: _screens,
          ),

          // Custom Bottom Navigation Bar
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: GlassContainer(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              borderRadius: BorderRadius.circular(30),
              color: AppColors.primary.withValues(alpha: 0.2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Left Side
                  Row(
                    children: [
                      _buildNavItem(
                        0,
                        Icons.home_rounded,
                        AppLocalizations.of(context)!.dashboard,
                      ),
                      SizedBox(width: 10),
                      _buildNavItem(
                        1,
                        Icons.account_balance_wallet_rounded,
                        AppLocalizations.of(context)!.accounts,
                      ),
                    ],
                  ),

                  // Spacer for Center Button
                  SizedBox(width: 60),

                  // Right Side
                  Row(
                    children: [
                      _buildNavItem(
                        2,
                        Icons.pie_chart_rounded,
                        AppLocalizations.of(context)!.statistics,
                      ),
                      SizedBox(width: 10),
                      _buildNavItem(
                        3,
                        Icons.calendar_month_rounded,
                        AppLocalizations.of(context)!.monthlyReport,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Centered Floating Action Button with Container Transform
          Positioned(
            bottom: 45,
            left: 0,
            right: 0,
            child: Center(
              child: OpenContainer(
                closedElevation: 8,
                openElevation: 0,
                closedShape: CircleBorder(),
                closedColor: AppColors.primary,
                openColor: AppColors.background,
                middleColor: AppColors.primary,
                transitionDuration: Duration(milliseconds: 400),
                transitionType: ContainerTransitionType.fade,
                tappable: false, // We handle the tap manually
                closedBuilder: (context, action) {
                  return GestureDetector(
                    onTap: () {
                      final accountProvider = Provider.of<AccountProvider>(
                        context,
                        listen: false,
                      );
                      if (accountProvider.accounts.isEmpty) {
                        showDialog(
                          context: context,
                          barrierColor: Colors.black54,
                          builder: (ctx) => BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Dialog(
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              child: GlassContainer(
                                padding: EdgeInsets.all(24),
                                borderRadius: BorderRadius.circular(24),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.account_balance_wallet_outlined,
                                      color: AppColors.primary,
                                      size: 48,
                                    ),
                                    SizedBox(height: 16),
                                    Text(
                                      AppLocalizations.of(
                                        context,
                                      )!.noAccountsFound,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 12),
                                    Text(
                                      AppLocalizations.of(
                                        context,
                                      )!.noAccountsMessage,
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 14,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 24),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(ctx); // Close dialog
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) =>
                                                    AddAccountScreen(),
                                              ),
                                            );
                                          },
                                          style: TextButton.styleFrom(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 12,
                                            ),
                                            backgroundColor: AppColors.primary,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                          child: Text(
                                            AppLocalizations.of(
                                              context,
                                            )!.createAccount,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 12),
                                        TextButton(
                                          onPressed: () => Navigator.pop(ctx),
                                          style: TextButton.styleFrom(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 12,
                                            ),
                                            backgroundColor: Colors.white
                                                .withValues(alpha: 0.1),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                          child: Text(
                                            AppLocalizations.of(
                                              context,
                                            )!.cancel,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        action();
                      }
                    },
                    child: const _PulsingAddButton(),
                  );
                },
                openBuilder: (context, action) {
                  return const AddTransactionScreenMultiStep();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () => _onNavItemTapped(index),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          shape: BoxShape.circle,
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.4),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ]
              : [],
        ),
        child: Icon(
          icon,
          color: isSelected ? Colors.white : Colors.white54,
          size: 24,
        ),
      ),
    );
  }
}

class _PulsingAddButton extends StatefulWidget {
  const _PulsingAddButton();

  @override
  State<_PulsingAddButton> createState() => _PulsingAddButtonState();
}

class _PulsingAddButtonState extends State<_PulsingAddButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.15,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _glowAnimation = Tween<double>(
      begin: 0.2,
      end: 0.8,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.primary.withValues(alpha: 0.4),
                  AppColors.primary.withValues(alpha: 0.2),
                ],
              ),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.3),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(
                    alpha: _glowAnimation.value,
                  ),
                  blurRadius: 25 + (15 * _controller.value),
                  spreadRadius: 8 * _controller.value,
                ),
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Stack(
              children: [
                // Inner glow
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          Colors.white.withValues(alpha: 0.2),
                          Colors.transparent,
                        ],
                        stops: [0.0, 1.0],
                      ),
                    ),
                  ),
                ),
                // Icon
                Center(
                  child: Icon(Icons.add_rounded, color: Colors.white, size: 36),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
