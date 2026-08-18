import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Brand
  static const Color primary = Color(0xFF2563EB);      // blue-600
  static const Color primaryDark = Color(0xFF1D4ED8);   // blue-700
  static const Color primaryLight = Color(0xFF60A5FA);  // blue-400
  static const Color secondary = Color(0xFF4F46E5);     // indigo-600

  // Gradient (used for logo text / accents)
  static const List<Color> brandGradient = [
    Color(0xFF2563EB), // blue-600
    Color(0xFF4F46E5), // indigo-600
  ];

  // Light theme surfaces
  static const Color backgroundLight = Color(0xFFF9FAFB); // gray-50
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color borderLight = Color(0xFFE5E7EB);     // gray-200
  static const Color chipLight = Color(0xFFF3F4F6);       // gray-100

  // Dark theme surfaces
  static const Color backgroundDark = Color(0xFF0F172A); // slate-900
  static const Color surfaceDark = Color(0xFF1E293B);    // slate-800
  static const Color borderDark = Color(0xFF334155);     // slate-700
  static const Color chipDark = Color(0xFF1E293B);       // slate-800

  // Text
  static const Color textPrimaryLight = Color(0xFF111827);   // gray-900
  static const Color textSecondaryLight = Color(0xFF4B5563); // gray-600
  static const Color textMutedLight = Color(0xFF6B7280);     // gray-500

  static const Color textPrimaryDark = Color(0xFFF1F5F9);    // slate-100
  static const Color textSecondaryDark = Color(0xFFCBD5E1);  // slate-300
  static const Color textMutedDark = Color(0xFF94A3B8);      // slate-400

  // Status
  static const Color success = Color(0xFF16A34A); // green-600
  static const Color error = Color(0xFFDC2626);    // red-600
  static const Color errorBg = Color(0x1ADC2626);  // red-100 @ ~10%
  static const Color warning = Color(0xFFF59E0B);  // amber-500

  // Overlay
  static const Color overlayDark = Color(0xCC000000); // black/80
  static const Color overlayMid = Color(0x33000000);  // black/20
}