import 'dart:ui';
import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class AppleLiquidGlassIconButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final double size;
  final Color? glowColor;
  final bool isSelected;
  final EdgeInsetsGeometry padding;

  const AppleLiquidGlassIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.size = 40.0,
    this.glowColor,
    this.isSelected = false,
    this.padding = const EdgeInsets.all(8.0),
  });

  @override
  State<AppleLiquidGlassIconButton> createState() => _AppleLiquidGlassIconButtonState();
}

class _AppleLiquidGlassIconButtonState extends State<AppleLiquidGlassIconButton>
    with TickerProviderStateMixin {
  late AnimationController _pressController;
  late AnimationController _rippleController;

  bool _isHovered = false;
  Offset _hoverPosition = Offset.zero;
  Offset? _tapPosition;

  @override
  void initState() {
    super.initState();
    // Press squish: 0.0 to 1.0 compression
    _pressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    // Water drop ripple: 0.0 to 1.0 dissolution
    _rippleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
  }

  @override
  void dispose() {
    _pressController.dispose();
    _rippleController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _tapPosition = details.localPosition;
      _hoverPosition = details.localPosition; // Align specular highlight
    });
    _rippleController.forward(from: 0.0);
    _pressController.animateTo(1.0, curve: Curves.easeOutCubic);
  }

  void _handleTapUp(TapUpDetails details) {
    _pressController.animateTo(0.0, curve: Curves.elasticOut);
  }

  void _handleTapCancel() {
    _pressController.animateTo(0.0, curve: Curves.easeOutCubic);
  }

  void _updateHoverPosition(Offset localPos) {
    setState(() {
      _hoverPosition = localPos;
    });
  }

  @override
  Widget build(BuildContext context) {
    final effectiveGlowColor = widget.glowColor ?? AppColors.primary;

    return MouseRegion(
      onEnter: (event) {
        setState(() {
          _isHovered = true;
          _hoverPosition = event.localPosition;
        });
      },
      onHover: (event) => _updateHoverPosition(event.localPosition),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTapCancel: _handleTapCancel,
        onTap: widget.onPressed,
        child: AnimatedBuilder(
          animation: _pressController,
          builder: (context, child) {
            // Elastic circular squish: conserve volume
            final double verticalScale = 1.0 - (0.08 * _pressController.value);
            final double horizontalScale = 1.0 + (0.04 * _pressController.value);

            return Transform(
              transform: Matrix4.diagonal3Values(horizontalScale, verticalScale, 1.0),
              alignment: Alignment.center,
              child: Padding(
                padding: widget.padding,
                child: Container(
                  width: widget.size,
                  height: widget.size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: effectiveGlowColor.withValues(alpha: _isHovered ? 0.28 : 0.15),
                        blurRadius: _isHovered ? 15 : 10,
                        spreadRadius: -3,
                        offset: const Offset(0, 4),
                      ),
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.15),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 18.0, sigmaY: 18.0),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.white.withValues(alpha: 0.12),
                              Colors.white.withValues(alpha: 0.04),
                            ],
                          ),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.18),
                            width: 1.0,
                          ),
                        ),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            final double W = constraints.maxWidth;
                            final double H = constraints.maxHeight;

                            return Stack(
                              children: [
                                // Top Specular Highlight Arc
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
                                            Colors.white.withValues(alpha: 0.1),
                                            Colors.transparent,
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                // Specular Light Catch Highlight (Interactive position-based)
                                if (_isHovered)
                                  Positioned.fill(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: RadialGradient(
                                          center: Alignment(
                                            (W > 0) ? (_hoverPosition.dx / W * 2.0) - 1.0 : 0.0,
                                            (H > 0) ? (_hoverPosition.dy / H * 2.0) - 1.0 : 0.0,
                                          ),
                                          radius: 0.75,
                                          colors: [
                                            Colors.white.withValues(alpha: 0.15),
                                            Colors.transparent,
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                // Water Drop Click Ripple Overlay
                                if (_tapPosition != null)
                                  Positioned.fill(
                                    child: AnimatedBuilder(
                                      animation: _rippleController,
                                      builder: (context, child) {
                                        final double progress = _rippleController.value;
                                        if (progress >= 1.0) return const SizedBox.shrink();
                                        return CustomPaint(
                                          painter: _CircularWaterDropRipplePainter(
                                            center: _tapPosition!,
                                            progress: progress,
                                            color: Colors.white.withValues(alpha: 0.22),
                                          ),
                                        );
                                      },
                                    ),
                                  ),

                                // Center Icon
                                Center(
                                  child: Icon(
                                    widget.icon,
                                    color: Colors.white,
                                    size: widget.size * 0.5,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// Organic Circular Water Drop Click Ripple Painter
class _CircularWaterDropRipplePainter extends CustomPainter {
  final Offset center;
  final double progress;
  final Color color;

  _CircularWaterDropRipplePainter({
    required this.center,
    required this.progress,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double maxRadius = size.shortestSide * 2.0;
    final double radius = progress * maxRadius;
    final double opacity = (1.0 - progress).clamp(0.0, 1.0);
    final paint = Paint()
      ..color = color.withValues(alpha: color.opacity * opacity)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant _CircularWaterDropRipplePainter oldDelegate) {
    return oldDelegate.center != center ||
        oldDelegate.progress != progress ||
        oldDelegate.color != color;
  }
}
