import 'package:flutter/material.dart';

class AppColors {
  static const darkGradient = LinearGradient(
    colors: [
      Color(0xFF0F172A),
      Color(0xFF1E1B4B),
      Color(0xFF731D95),
      Color(0xFF1E1B4B),
      Color(0xFF0F172A),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const lightGradient = LinearGradient(
    colors: [
      Color(0xFFA855F7),
      Color(0xFF8B5CF6),
      Color(0xFF6366F1),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const neonGreen = Color(0xFF00FFB2);
  static const neonBlue = Color(0xFF00E0FF);
  static const neonPink = Color(0xFFFF3DF2);

  static Color glass(bool dark) {
    return dark ? Colors.black.withValues(alpha: 0.4) : Colors.white.withValues(alpha: 0.4);
  }
}