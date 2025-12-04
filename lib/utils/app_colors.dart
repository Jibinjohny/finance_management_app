import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF6C63FF); // Modern Purple
  static const Color secondary = Color(0xFF03DAC6); // Teal Accent
  static const Color background = Color(0xFF121212); // Dark Background
  static const Color surface = Color(0xFF1E1E1E); // Card Background
  static const Color error = Color(0xFFE57373); // Softer Red
  static const Color warning = Color(0xFFFFA726); // Orange
  static const Color success = Color(0xFF81C784); // Softer Green
  static const Color onPrimary = Colors.white;
  static const Color onBackground = Colors.white;
  static const Color onSurface = Colors.white70;
  static const Color expense = Color(0xFFE57373); // Softer Red
  static const Color income = Color(0xFF81C784); // Softer Green
  static const Color textSecondary = Colors.white54;
  static const Color border = Colors.white24;

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF6C63FF), Color(0xFF4834D4)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
