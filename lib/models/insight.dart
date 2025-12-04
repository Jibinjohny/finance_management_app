import 'package:flutter/material.dart';

enum InsightType { info, warning, success }

class Insight {
  final String title;
  final String message;
  final InsightType type;
  final IconData icon;

  Insight({
    required this.title,
    required this.message,
    required this.type,
    required this.icon,
  });
}
