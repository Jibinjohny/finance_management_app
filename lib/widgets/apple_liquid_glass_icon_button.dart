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
      lowerBound: 0.92,
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
    _scaleController.animateTo(0.92, curve: Curves.easeOutCubic);
  }

  void _handleTapUp(TapUpDetails details) {
    _scaleController.animateTo(1.0, curve: Curves.elasticOut);
  }

  void _handleTapCancel() {
    _scaleController.animateTo(1.0, curve: Curves.easeOutCubic);
  }

  @override
  Widget build(BuildContext context) {
    final effectiveGlowColor = widget.glowColor ?? AppColors.primary;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTapCancel: _handleTapCancel,
        onTap: widget.onPressed,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Padding(
            padding: widget.padding,
            child: Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: effectiveGlowColor.withValues(alpha: _isHovered ? 0.3 : 0.15),
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
                    child: Stack(
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
                        // Center Icon
                        Center(
                          child: Icon(
                            widget.icon,
                            color: Colors.white,
                            size: widget.size * 0.5,
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
      ),
    );
  }
}
