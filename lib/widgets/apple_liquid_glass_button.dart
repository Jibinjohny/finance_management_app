import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_colors.dart';

class AppleLiquidGlassButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final Widget? child;
  final String? label;
  final Gradient? gradient;
  final Color? glowColor;
  final double height;
  final double? width;
  final double borderRadius;
  final bool isLoading;
  final IconData? icon;

  const AppleLiquidGlassButton({
    super.key,
    required this.onPressed,
    this.child,
    this.label,
    this.gradient,
    this.glowColor,
    this.height = 56.0,
    this.width,
    this.borderRadius = 20.0,
    this.isLoading = false,
    this.icon,
  }) : assert(child != null || label != null, 'Either child or label must be provided');

  @override
  State<AppleLiquidGlassButton> createState() => _AppleLiquidGlassButtonState();
}

class _AppleLiquidGlassButtonState extends State<AppleLiquidGlassButton>
    with TickerProviderStateMixin {
  late AnimationController _pressController;
  late AnimationController _rippleController;
  
  bool _isHovered = false;
  Offset _hoverPosition = Offset.zero;
  Offset? _tapPosition;

  @override
  void initState() {
    super.initState();
    // Press squish controller: 0.0 (rest) to 1.0 (fully compressed)
    _pressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    // Water drop ripple controller: 0.0 (impact) to 1.0 (dissolved)
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
    if (widget.onPressed != null && !widget.isLoading) {
      setState(() {
        _tapPosition = details.localPosition;
        _hoverPosition = details.localPosition; // Synchronize light touch position
      });
      _rippleController.forward(from: 0.0);
      _pressController.animateTo(1.0, curve: Curves.easeOutCubic);
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (widget.onPressed != null && !widget.isLoading) {
      _pressController.animateTo(0.0, curve: Curves.elasticOut);
    }
  }

  void _handleTapCancel() {
    if (widget.onPressed != null && !widget.isLoading) {
      _pressController.animateTo(0.0, curve: Curves.easeOutCubic);
    }
  }

  void _updateHoverPosition(Offset localPos) {
    setState(() {
      _hoverPosition = localPos;
    });
  }

  @override
  Widget build(BuildContext context) {
    final effectiveGlowColor = widget.glowColor ?? AppColors.primary;
    final isEnabled = widget.onPressed != null && !widget.isLoading;

    // Premium Glossy Glass Gradient
    final glassGradient = widget.gradient ??
        LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isEnabled
              ? [
                  AppColors.primary.withValues(alpha: 0.35),
                  AppColors.primary.withValues(alpha: 0.15),
                  const Color(0xFF5046E5).withValues(alpha: 0.1),
                ]
              : [
                  Colors.white.withValues(alpha: 0.1),
                  Colors.white.withValues(alpha: 0.03),
                ],
          stops: const [0.0, 0.5, 1.0],
        );

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
        onTap: isEnabled ? widget.onPressed : null,
        child: AnimatedBuilder(
          animation: _pressController,
          builder: (context, child) {
            // Volume-Conserving squash-and-stretch: height squishes to 0.92, width stretches to 1.03
            final double verticalScale = 1.0 - (0.08 * _pressController.value);
            final double horizontalScale = 1.0 + (0.03 * _pressController.value);

            return Transform(
              transform: Matrix4.diagonal3Values(horizontalScale, verticalScale, 1.0),
              alignment: Alignment.center,
              child: Container(
                width: widget.width,
                height: widget.height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  boxShadow: isEnabled
                      ? [
                          // Soft premium active brand shadow glow
                          BoxShadow(
                            color: effectiveGlowColor.withValues(alpha: _isHovered ? 0.3 : 0.18),
                            blurRadius: _isHovered ? 22 : 16,
                            spreadRadius: _isHovered ? -1 : -3,
                            offset: const Offset(0, 6),
                          ),
                          // Ambient drop shadow
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ]
                      : [],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 18.0, sigmaY: 18.0),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: glassGradient,
                        borderRadius: BorderRadius.circular(widget.borderRadius),
                        // Light catches the edges representing high specularity
                        border: Border(
                          top: BorderSide(
                            color: Colors.white.withValues(alpha: isEnabled ? 0.28 : 0.12),
                            width: 1.5,
                          ),
                          bottom: BorderSide(
                            color: Colors.white.withValues(alpha: isEnabled ? 0.08 : 0.04),
                            width: 0.8,
                          ),
                          left: BorderSide(
                            color: Colors.white.withValues(alpha: isEnabled ? 0.16 : 0.08),
                            width: 0.8,
                          ),
                          right: BorderSide(
                            color: Colors.white.withValues(alpha: isEnabled ? 0.16 : 0.08),
                            width: 0.8,
                          ),
                        ),
                      ),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final double W = constraints.maxWidth;
                          final double H = constraints.maxHeight;

                          return Stack(
                            children: [
                              // Specular Gloss Highlight (top reflective arc)
                              Positioned.fill(
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    height: widget.height / 2,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.white.withValues(alpha: isEnabled ? 0.12 : 0.04),
                                          Colors.white.withValues(alpha: 0.0),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              // Specular Hover/Drag Radial Light Catch
                              if (_isHovered && isEnabled)
                                Positioned.fill(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: RadialGradient(
                                        center: Alignment(
                                          (W > 0) ? (_hoverPosition.dx / W * 2.0) - 1.0 : 0.0,
                                          (H > 0) ? (_hoverPosition.dy / H * 2.0) - 1.0 : 0.0,
                                        ),
                                        radius: 0.75,
                                        colors: [
                                          Colors.white.withValues(alpha: 0.15), // High specularity light catch
                                          Colors.transparent,
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                              // Water Drop Click Ripple Overlay
                              if (_tapPosition != null && isEnabled)
                                Positioned.fill(
                                  child: AnimatedBuilder(
                                    animation: _rippleController,
                                    builder: (context, child) {
                                      final double progress = _rippleController.value;
                                      if (progress >= 1.0) return const SizedBox.shrink();
                                      return CustomPaint(
                                        painter: _WaterDropRipplePainter(
                                          center: _tapPosition!,
                                          progress: progress,
                                          color: Colors.white.withValues(alpha: 0.22),
                                        ),
                                      );
                                    },
                                  ),
                                ),

                              // Center Content
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                  child: widget.isLoading
                                      ? const SizedBox(
                                          height: 24,
                                          width: 24,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2.5,
                                          ),
                                        )
                                      : Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            if (widget.icon != null) ...[
                                              Icon(
                                                widget.icon,
                                                color: Colors.white.withValues(alpha: isEnabled ? 1.0 : 0.4),
                                                size: 20,
                                              ),
                                              const SizedBox(width: 8),
                                            ],
                                            widget.child ??
                                                Text(
                                                  widget.label!,
                                                  style: GoogleFonts.outfit(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white.withValues(alpha: isEnabled ? 1.0 : 0.4),
                                                    letterSpacing: 0.5,
                                                  ),
                                                ),
                                          ],
                                        ),
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
            );
          },
        ),
      ),
    );
  }
}

// Organic Water Drop Click Ripple Painter
class _WaterDropRipplePainter extends CustomPainter {
  final Offset center;
  final double progress;
  final Color color;

  _WaterDropRipplePainter({
    required this.center,
    required this.progress,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double maxRadius = size.shortestSide * 2.2;
    final double radius = progress * maxRadius;
    final double opacity = (1.0 - progress).clamp(0.0, 1.0);
    final paint = Paint()
      ..color = color.withValues(alpha: color.opacity * opacity)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant _WaterDropRipplePainter oldDelegate) {
    return oldDelegate.center != center ||
        oldDelegate.progress != progress ||
        oldDelegate.color != color;
  }
}
