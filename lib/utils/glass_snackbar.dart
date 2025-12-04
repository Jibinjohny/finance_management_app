import 'package:flutter/material.dart';
import 'dart:ui';
import 'app_colors.dart';

class GlassSnackBar {
  static void show(
    BuildContext context, {
    required String message,
    Color? backgroundColor,
    IconData? icon,
    Duration duration = const Duration(seconds: 3),
  }) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        left: 16,
        right: 16,
        child: Material(
          color: Colors.transparent,
          child: _GlassSnackBarWidget(
            message: message,
            backgroundColor: backgroundColor,
            icon: icon,
            onDismiss: () {}, // Handled by timer
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(duration, () {
      if (overlayEntry.mounted) {
        overlayEntry.remove();
      }
    });
  }

  static void showSuccess(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    show(
      context,
      message: message,
      backgroundColor: AppColors.success,
      icon: Icons.check_circle_outline,
      duration: duration,
    );
  }

  static void showError(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    show(
      context,
      message: message,
      backgroundColor: AppColors.error,
      icon: Icons.error_outline,
      duration: duration,
    );
  }

  static void showInfo(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    show(
      context,
      message: message,
      backgroundColor: AppColors.primary,
      icon: Icons.info_outline,
      duration: duration,
    );
  }

  static void showWarning(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    show(
      context,
      message: message,
      backgroundColor: AppColors.warning,
      icon: Icons.warning_amber_outlined,
      duration: duration,
    );
  }
}

class _GlassSnackBarWidget extends StatefulWidget {
  final String message;
  final Color? backgroundColor;
  final IconData? icon;
  final VoidCallback onDismiss;

  const _GlassSnackBarWidget({
    required this.message,
    this.backgroundColor,
    this.icon,
    required this.onDismiss,
  });

  @override
  State<_GlassSnackBarWidget> createState() => _GlassSnackBarWidgetState();
}

class _GlassSnackBarWidgetState extends State<_GlassSnackBarWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<Offset> _offset;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _opacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _offset = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
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
        return Opacity(
          opacity: _opacity.value,
          child: SlideTransition(position: _offset, child: child),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  (widget.backgroundColor ?? AppColors.surface).withValues(
                    alpha: 0.8,
                  ),
                  (widget.backgroundColor ?? AppColors.surface).withValues(
                    alpha: 0.6,
                  ),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.2),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Row(
              children: [
                if (widget.icon != null) ...[
                  Icon(widget.icon, color: Colors.white, size: 24),
                  const SizedBox(width: 12),
                ],
                Expanded(
                  child: Text(
                    widget.message,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.none,
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
