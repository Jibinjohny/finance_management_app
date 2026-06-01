import 'dart:math' as math;
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
  double _pageScrollValue = 0.0; // Track real-time double scroll position

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
          _pageScrollValue = _pageController.page!; // Update scroll value in real-time
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

                  // Helper to get static left and width coordinates for an index
                  Map<String, double> getStaticPos(int idx) {
                    final double f0 = idx == 0 ? 7 : (idx == 1 ? 3 : 1);
                    final double f1 = idx == 1 ? 7 : (idx == 0 ? 3 : 1);
                    final double f2 = idx == 2 ? 7 : (idx == 3 ? 3 : 1);
                    final double f3 = idx == 3 ? 7 : (idx == 2 ? 3 : 1);

                    double l = 0;
                    double w = 0;

                    if (idx == 0) {
                      l = 0;
                      w = halfW * (f0 / (f0 + f1));
                    } else if (idx == 1) {
                      l = halfW * (f0 / (f0 + f1));
                      w = halfW * (f1 / (f0 + f1));
                    } else if (idx == 2) {
                      l = halfW + 70;
                      w = halfW * (f2 / (f2 + f3));
                    } else if (idx == 3) {
                      l = halfW + 70 + halfW * (f2 / (f2 + f3));
                      w = halfW * (f3 / (f2 + f3));
                    }
                    return {'left': l, 'width': w};
                  }

                  // Real-time interpolation based on double page scroll
                  final double page = _pageScrollValue.clamp(0.0, 3.0);
                  final int floor = page.floor().clamp(0, 3);
                  final int ceil = page.ceil().clamp(0, 3);
                  final double t = page - floor;

                  final posA = getStaticPos(floor);
                  final posB = getStaticPos(ceil);

                  double computedLeft = lerpDouble(posA['left']!, posB['left']!, t)!;
                  double computedWidth = lerpDouble(posA['width']!, posB['width']!, t)!;

                  // Liquid Gooey Stretch physics: peaks at t = 0.5 in the middle of transition
                  final double stretch = 26.0 * (t * (1.0 - t) * 4.0);
                  computedLeft = computedLeft - (stretch * 0.5);
                  computedWidth = computedWidth + stretch;

                  // Volume-Conserving Vertical Squish: peaks at t = 0.5 (up to 4.5px each top/bottom inset)
                  final double squishOffset = 4.5 * (t * (1.0 - t) * 4.0);

                  // Resolve colors of active page in real-time
                  final int nearestIndex = page.round().clamp(0, 3);
                  final colors = _getGlowColors(nearestIndex);

                  // Fixed flex indicators for the static text labels row below
                  final double flex0 = _currentIndex == 0 ? 7 : (_currentIndex == 1 ? 3 : 1);
                  final double flex1 = _currentIndex == 1 ? 7 : (_currentIndex == 0 ? 3 : 1);
                  final double flex2 = _currentIndex == 2 ? 7 : (_currentIndex == 3 ? 3 : 1);
                  final double flex3 = _currentIndex == 3 ? 7 : (_currentIndex == 2 ? 3 : 1);

                  return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onHorizontalDragStart: (details) {
                      _handleNavDragUpdate(details.localPosition.dx, constraints.maxWidth);
                    },
                    onHorizontalDragUpdate: (details) {
                      _handleNavDragUpdate(details.localPosition.dx, constraints.maxWidth);
                    },
                    onHorizontalDragEnd: (details) {
                      _handleNavDragEnd();
                    },
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // Shared Real-Time Liquid Glass Indicator
                        Positioned(
                          left: computedLeft,
                          width: computedWidth,
                          top: squishOffset,
                          bottom: squishOffset,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              // Clean, premium single-tone glass border gradient shifting light catch dynamically
                              gradient: LinearGradient(
                                colors: [
                                  colors[0].withValues(alpha: 0.65),
                                  colors[1].withValues(alpha: 0.25),
                                  colors[0].withValues(alpha: 0.15),
                                ],
                                begin: Alignment(-1.0 + (t * 0.5), -1.0 + (t * 0.3)),
                                end: Alignment(1.0 - (t * 0.5), 1.0 - (t * 0.3)),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: colors[0].withValues(alpha: 0.22),
                                  blurRadius: 15,
                                  spreadRadius: -2,
                                  offset: const Offset(0, 4),
                                ),
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.25),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Container(
                              margin: const EdgeInsets.all(1.2), // Creates a 1.2px delicate single-tone border outline
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18.8),
                                color: const Color(0xFF181824).withValues(alpha: 0.8), // Deep dark glass base
                              ),
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
                                        Icons.home_outlined,
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
                                        Icons.account_balance_wallet_outlined,
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
                                        Icons.pie_chart_outline_rounded,
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
                                        Icons.calendar_month_outlined,
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
                    ),
                  );
                },
              ),
            ),
          ),


          // Centered Floating Action Button with Container Transform
          Positioned(
            bottom: 30, // Mathematically offsets the larger 100x100 container so the 70x70 droplet rests at bottom: 45
            left: 0,
            right: 0,
            child: Center(
              child: OpenContainer(
                closedElevation: 0,
                openElevation: 0,
                closedShape: CircleBorder(),
                closedColor: Colors.transparent,
                openColor: AppColors.background,
                middleColor: AppColors.primary,
                transitionDuration: Duration(milliseconds: 400),
                transitionType: ContainerTransitionType.fade,
                tappable: false, // We handle the tap manually
                closedBuilder: (context, action) {
                  return SizedBox(
                    width: 100,
                    height: 100,
                    child: Center(
                      child: GestureDetector(
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
                  ),
                ),
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

  void _handleNavDragUpdate(double x, double W) {
    if (W <= 0) return;
    final double halfW = (W - 70.0) / 2.0;

    // Linear interpolation mapping touch coordinates to dynamic page value [0.0 - 3.0]
    // taking the 70px center gap into account.
    double page = 0.0;
    if (x <= halfW) {
      page = x / halfW;
    } else if (x <= halfW + 70.0) {
      page = 1.0 + (x - halfW) / 70.0;
    } else {
      page = 2.0 + (x - halfW - 70.0) / halfW;
    }
    page = page.clamp(0.0, 3.0);

    if (_pageController.hasClients) {
      final double pageWidth = MediaQuery.of(context).size.width;
      _pageController.jumpTo(page * pageWidth);
    }
  }

  void _handleNavDragEnd() {
    if (_pageController.hasClients && _pageController.page != null) {
      final int targetIndex = _pageController.page!.round().clamp(0, 3);
      _onNavItemTapped(targetIndex);
    }
  }

  Widget _buildNavItem(int index, IconData outlineIcon, IconData filledIcon, String label) {
    return _LiquidGlassNavItem(
      index: index,
      outlineIcon: outlineIcon,
      filledIcon: filledIcon,
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

class _WaterDropExpandingRipple extends StatefulWidget {
  const _WaterDropExpandingRipple();

  @override
  State<_WaterDropExpandingRipple> createState() => _WaterDropExpandingRippleState();
}

class _WaterDropExpandingRippleState extends State<_WaterDropExpandingRipple>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat();
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
        // Ripple 1
        final double t1 = _controller.value;
        final double scale1 = 0.95 + (0.85 * t1); // scales from 0.95 to 1.8
        final double opacity1 = math.pow(1.0 - t1, 2.5) * 0.45; // Smooth exponential decay

        // Ripple 2 (phased by 0.33)
        final double t2 = (t1 + 0.33) % 1.0;
        final double scale2 = 0.95 + (0.85 * t2);
        final double opacity2 = math.pow(1.0 - t2, 2.5) * 0.45;

        // Ripple 3 (phased by 0.66)
        final double t3 = (t1 + 0.66) % 1.0;
        final double scale3 = 0.95 + (0.85 * t3);
        final double opacity3 = math.pow(1.0 - t3, 2.5) * 0.45;

        return Stack(
          clipBehavior: Clip.none,
          children: [
            // Ripple 1
            if (opacity1 > 0.01)
              Positioned.fill(
                child: Transform.scale(
                  scale: scale1,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withValues(alpha: opacity1),
                        width: 1.0,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: opacity1 * 0.25),
                          blurRadius: 6,
                          spreadRadius: 0.5,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

            // Ripple 2
            if (opacity2 > 0.01)
              Positioned.fill(
                child: Transform.scale(
                  scale: scale2,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withValues(alpha: opacity2),
                        width: 1.0,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: opacity2 * 0.25),
                          blurRadius: 6,
                          spreadRadius: 0.5,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

            // Ripple 3
            if (opacity3 > 0.01)
              Positioned.fill(
                child: Transform.scale(
                  scale: scale3,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withValues(alpha: opacity3),
                        width: 1.0,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: opacity3 * 0.25),
                          blurRadius: 6,
                          spreadRadius: 0.5,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _PulsingAddButton extends StatelessWidget {
  const _PulsingAddButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 62,
      height: 62,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        // Liquid glass gradient — primary tint on top, transparent toward bottom
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary.withValues(alpha: 0.55),
            AppColors.primary.withValues(alpha: 0.30),
            Colors.white.withValues(alpha: 0.08),
          ],
          stops: const [0.0, 0.55, 1.0],
        ),
        // Thin specular border matching the glass nav bar border style
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.40),
          width: 1.5,
        ),
        boxShadow: [
          // Soft primary colour glow
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.45),
            blurRadius: 18,
            spreadRadius: 2,
          ),
          // Deep drop shadow for elevation
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.30),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipOval(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18.0, sigmaY: 18.0),
          child: Stack(
            children: [
              // Inner top-left specular highlight — simulates light catching the glass
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      center: const Alignment(-0.55, -0.55),
                      radius: 0.85,
                      colors: [
                        Colors.white.withValues(alpha: 0.30),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 1.0],
                    ),
                  ),
                ),
              ),

              // + Icon centred
              const Center(
                child: Icon(Icons.add_rounded, color: Colors.white, size: 34),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LiquidGlassNavItem extends StatefulWidget {
  final int index;
  final IconData outlineIcon;
  final IconData filledIcon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _LiquidGlassNavItem({
    required this.index,
    required this.outlineIcon,
    required this.filledIcon,
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
    // Elegant, clean active tab colors (Single-tone matching the page)
    final Color activeColor = widget.index == 0
        ? const Color(0xFF00B980) // Emerald Green
        : (widget.index == 1
            ? const Color(0xFF6C63FF) // Violet Purple
            : (widget.index == 2
                ? const Color(0xFF0984E3) // Royal Cyan
                : const Color(0xFFE17055))); // Neon Amber

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
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  transitionBuilder: (child, anim) => FadeTransition(
                    opacity: anim,
                    child: ScaleTransition(
                      scale: Tween<double>(begin: 0.8, end: 1.0).animate(anim),
                      child: child,
                    ),
                  ),
                  child: Icon(
                    widget.isSelected ? widget.filledIcon : widget.outlineIcon,
                    key: ValueKey<bool>(widget.isSelected),
                    color: widget.isSelected ? activeColor : Colors.white.withValues(alpha: 0.55),
                    size: 20,
                  ),
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
                            style: TextStyle(
                              color: activeColor,
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

