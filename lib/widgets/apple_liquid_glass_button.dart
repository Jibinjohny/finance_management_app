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
    with SingleTickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
      lowerBound: 0.95,
      upperBound: 1.0,
      value: 1.0,
    );
    _scaleAnimation = _scaleController;
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (widget.onPressed != null && !widget.isLoading) {
      _scaleController.animateTo(0.95, curve: Curves.easeOutCubic);
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (widget.onPressed != null && !widget.isLoading) {
      _scaleController.animateTo(1.0, curve: Curves.elasticOut);
    }
  }

  void _handleTapCancel() {
    if (widget.onPressed != null && !widget.isLoading) {
      _scaleController.animateTo(1.0, curve: Curves.easeOutCubic);
    }
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
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTapCancel: _handleTapCancel,
        onTap: isEnabled ? widget.onPressed : null,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              boxShadow: isEnabled
                  ? [
                      // Deep Neon Glow Shadow
                      BoxShadow(
                        color: effectiveGlowColor.withValues(alpha: _isHovered ? 0.35 : 0.22),
                        blurRadius: _isHovered ? 25 : 18,
                        spreadRadius: _isHovered ? -1 : -3,
                        offset: const Offset(0, 8),
                      ),
                      // Soft ambient dark drop shadow
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.25),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
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
                  child: Stack(
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

                      // Interactive Liquid Light Hover Glow overlay
                      if (_isHovered && isEnabled)
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: RadialGradient(
                                center: Alignment.center,
                                radius: 1.0,
                                colors: [
                                  Colors.white.withValues(alpha: 0.08),
                                  Colors.transparent,
                                ],
                              ),
                            ),
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
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
