import 'dart:ui';
import 'package:flutter/material.dart';

class GlassContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? borderRadius;
  final double blur;
  final double opacity;
  final Color? color;
  final Color? borderColor;
  final Gradient? gradient;
  final List<BoxShadow>? boxShadow;
  final double borderWidth;

  const GlassContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.borderRadius,
    this.blur = 15.0, // Increased default blur
    this.opacity = 0.1,
    this.color,
    this.borderColor,
    this.gradient,
    this.boxShadow,
    this.borderWidth = 1.5,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(24),
        boxShadow:
            boxShadow ??
            [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 15,
                spreadRadius: -2,
                offset: Offset(0, 8),
              ),
            ],
      ),
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: color ?? Colors.white.withValues(alpha: 0.05),
              borderRadius: borderRadius ?? BorderRadius.circular(24),
              border: Border.all(
                color: borderColor ?? Colors.white.withValues(alpha: 0.15),
                width: borderWidth,
              ),
              gradient:
                  gradient ??
                  LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withValues(alpha: 0.15),
                      Colors.white.withValues(alpha: 0.05),
                      Colors.white.withValues(alpha: 0.02),
                    ],
                    stops: [0.0, 0.4, 1.0],
                  ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
