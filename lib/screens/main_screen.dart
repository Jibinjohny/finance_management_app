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

          Positioned(
            bottom: 20,
            left: 16,
            right: 16,
            child: GlassContainer(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              borderRadius: BorderRadius.circular(30),
              color: Colors.black.withValues(alpha: 0.35),
              borderColor: Colors.white.withValues(alpha: 0.12),
              borderWidth: 1.0,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final W = constraints.maxWidth;
                  final halfW = (W - 70) / 2;

                  // Get flex values for each item to compute exact positions
                  final double flex0 = _currentIndex == 0 ? 7 : (_currentIndex == 1 ? 3 : 1);
                  final double flex1 = _currentIndex == 1 ? 7 : (_currentIndex == 0 ? 3 : 1);
                  final double flex2 = _currentIndex == 2 ? 7 : (_currentIndex == 3 ? 3 : 1);
                  final double flex3 = _currentIndex == 3 ? 7 : (_currentIndex == 2 ? 3 : 1);

                  double targetLeft = 0;
                  double targetWidth = 0;

                  if (_currentIndex == 0) {
                    targetLeft = 0;
                    targetWidth = halfW * (flex0 / (flex0 + flex1));
                  } else if (_currentIndex == 1) {
                    targetLeft = halfW * (flex0 / (flex0 + flex1));
                    targetWidth = halfW * (flex1 / (flex0 + flex1));
                  } else if (_currentIndex == 2) {
                    targetLeft = halfW + 70;
                    targetWidth = halfW * (flex2 / (flex2 + flex3));
                  } else if (_currentIndex == 3) {
                    targetLeft = halfW + 70 + halfW * (flex2 / (flex2 + flex3));
                    targetWidth = halfW * (flex3 / (flex2 + flex3));
                  }

                  // Retrieve gradient colors for the active tab
                  final colors = _getGlowColors(_currentIndex);

                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // Shared Liquid Glass Sliding indicator
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 320),
                        curve: Curves.easeOutBack, // Springy gooey / liquid water-drop effect!
                        left: targetLeft,
                        width: targetWidth,
                        top: 0,
                        bottom: 0,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 320),
                          curve: Curves.easeOutBack,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              colors: [
                                colors[0].withValues(alpha: 0.4),
                                colors[1].withValues(alpha: 0.15),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.25),
                              width: 1.0,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: colors[0].withValues(alpha: 0.38),
                                blurRadius: 18,
                                spreadRadius: -2,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Transparent navigation icons & labels row on top
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: flex0.toInt(),
                                  child: Center(
                                    child: _buildNavItem(
                                      0,
                                      Icons.home_rounded,
                                      AppLocalizations.of(context)!.dashboard,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: flex1.toInt(),
                                  child: Center(
                                    child: _buildNavItem(
                                      1,
                                      Icons.account_balance_wallet_rounded,
                                      AppLocalizations.of(context)!.accounts,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 70), // Center gap perfectly aligned with the 70px Floating Button
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: flex2.toInt(),
                                  child: Center(
                                    child: _buildNavItem(
                                      2,
                                      Icons.pie_chart_rounded,
                                      AppLocalizations.of(context)!.statistics,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: flex3.toInt(),
                                  child: Center(
                                    child: _buildNavItem(
                                      3,
                                      Icons.calendar_month_rounded,
                                      _getCompactLabel(context, 3, AppLocalizations.of(context)!.monthlyReport),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
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
    return _LiquidGlassNavItem(
      index: index,
      icon: icon,
      label: label,
      isSelected: _currentIndex == index,
      onTap: () => _onNavItemTapped(index),
    );
  }

  String _getCompactLabel(BuildContext context, int index, String label) {
    if (index == 3) {
      final parts = label.split(' ');
      return parts.isNotEmpty ? parts[0] : label;
    }
    return label;
  }

  List<Color> _getGlowColors(int index) {
    switch (index) {
      case 0:
        return const [Color(0xFF00B980), Color(0xFF10E2A1)]; // Emerald
      case 1:
        return const [Color(0xFF6C63FF), Color(0xFF9089FF)]; // Violet
      case 2:
        return const [Color(0xFF0984E3), Color(0xFF00CEC9)]; // Royal Cyan
      case 3:
      default:
        return const [Color(0xFFE17055), Color(0xFFFFB366)]; // Neon Amber
    }
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

class _LiquidGlassNavItem extends StatefulWidget {
  final int index;
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _LiquidGlassNavItem({
    required this.index,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_LiquidGlassNavItem> createState() => _LiquidGlassNavItemState();
}

class _LiquidGlassNavItemState extends State<_LiquidGlassNavItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _springController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _springController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
      lowerBound: 0.9,
      upperBound: 1.1,
      value: 1.0,
    );
    _scaleAnimation = _springController;
  }

  @override
  void didUpdateWidget(covariant _LiquidGlassNavItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSelected && !oldWidget.isSelected) {
      _springController.forward(from: 1.0).then((_) {
        _springController.animateTo(1.0, curve: Curves.easeOutCubic);
      });
    }
  }

  @override
  void dispose() {
    _springController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          padding: EdgeInsets.symmetric(
            horizontal: widget.isSelected ? 12 : 8,
            vertical: 10,
          ),
          decoration: const BoxDecoration(), // Snugly transparent wrapper
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.center,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  widget.icon,
                  color: widget.isSelected ? Colors.white : Colors.white60,
                  size: 20,
                ),
                AnimatedSize(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOutCubic,
                  child: !widget.isSelected
                      ? const SizedBox.shrink()
                      : Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Text(
                            widget.label,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.3,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

