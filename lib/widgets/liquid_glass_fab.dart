import 'dart:ui';
import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

/// A premium liquid-glass floating action button that matches the
/// [AppleLiquidGlassIconButton] design used in the app bar.
class LiquidGlassFAB extends StatefulWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final double size;

  const LiquidGlassFAB({
    super.key,
    required this.onPressed,
    this.icon = Icons.add_rounded,
    this.size = 58.0,
  });

  @override
  State<LiquidGlassFAB> createState() => _LiquidGlassFABState();
}

class _LiquidGlassFABState extends State<LiquidGlassFAB>
    with SingleTickerProviderStateMixin {
  late AnimationController _pressController;
  Offset? _tapPosition;

  @override
  void initState() {
    super.initState();
    _pressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 140),
    );
  }

  @override
  void dispose() {
    _pressController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails d) {
    setState(() => _tapPosition = d.localPosition);
    _pressController.animateTo(1.0, curve: Curves.easeOutCubic);
  }

  void _onTapUp(TapUpDetails _) {
    _pressController.animateTo(0.0, curve: Curves.elasticOut);
  }

  void _onTapCancel() {
    _pressController.animateTo(0.0, curve: Curves.easeOutCubic);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _pressController,
      builder: (context, child) {
        final double v = _pressController.value;
        // Volume-preserving squish on press
        final double sx = 1.0 + 0.04 * v;
        final double sy = 1.0 - 0.08 * v;

        return Transform(
          transform: Matrix4.diagonal3Values(sx, sy, 1.0),
          alignment: Alignment.center,
          child: GestureDetector(
            onTapDown: _onTapDown,
            onTapUp: _onTapUp,
            onTapCancel: _onTapCancel,
            onTap: widget.onPressed,
            child: Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                // Liquid glass gradient: primary tint fades to frosted white
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.primary.withValues(alpha: 0.60),
                    AppColors.primary.withValues(alpha: 0.35),
                    Colors.white.withValues(alpha: 0.08),
                  ],
                  stops: const [0.0, 0.55, 1.0],
                ),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.38),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.45),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.28),
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
                      // Top-half specular arc highlight (matches app-bar icon button)
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            height: widget.size / 2,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.white.withValues(alpha: 0.18),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Tap ripple overlay
                      if (_tapPosition != null)
                        Positioned.fill(
                          child: AnimatedBuilder(
                            animation: _pressController,
                            builder: (context, _) {
                              final progress = 1.0 - _pressController.value;
                              return CustomPaint(
                                painter: _RipplePainter(
                                  center: _tapPosition!,
                                  progress: progress,
                                  color: Colors.white.withValues(alpha: 0.20),
                                ),
                              );
                            },
                          ),
                        ),

                      // + icon
                      Center(
                        child: Icon(
                          widget.icon,
                          color: Colors.white,
                          size: widget.size * 0.50,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _RipplePainter extends CustomPainter {
  final Offset center;
  final double progress;
  final Color color;

  _RipplePainter({
    required this.center,
    required this.progress,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final radius = progress * size.shortestSide;
    final opacity = (1.0 - progress).clamp(0.0, 1.0);
    final paint = Paint()
      ..color = color.withValues(alpha: color.a * opacity)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant _RipplePainter old) =>
      old.progress != progress || old.center != center;
}
