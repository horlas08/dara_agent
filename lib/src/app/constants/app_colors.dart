import 'package:flutter/material.dart';

class AppColors {
  // ------------------ LIGHT THEME ------------------
  // Background Colors
  static const Color lightBackground = Color(0xFFFFFFFF);

  // Primary Colors
  static const Color lightPrimary = Color(0xFFAA60C8);

  // Text Colors
  static const Color lightTextPrimary = Color(0xFF0C0310);
  static Color lightTextTertiary = Color(0xFF0C0310).withValues(alpha: 0.60);

  // Error/Warning/Success
  static const Color error = Color(0xFFDC3C22);
  static const Color warning = Color(0xFFFFAA00);
  static const Color success = Color(0xFF14AE6F);
  static const Color info = Color(0xFF41B1FC);

  // Utility
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color transparent = Colors.transparent;
}
