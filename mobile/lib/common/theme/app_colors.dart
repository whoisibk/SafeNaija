import 'package:flutter/material.dart';

abstract class AppColors {
  // Primary
  static const Color safeTeal = Color(0xFF128C7E);
  static const Color safeTealDark = Color(0xFF0D9488);

  // Secondary / Error
  static const Color emergencyRed = Color(0xFFDC2626);
  static const Color emergencyRedDark = Color(0xFFE11D48);

  // Backgrounds
  static const Color white = Color(0xFFFFFFFF);

  // Surfaces / Neutrals
  static const Color softGray = Color(0xFFF3F4F6); // Light mode surface
  static const Color softGrayDark = Color(0xFFF9FAFB);

  // Text / OnBackground
  static const Color darkSlate = Color(0xFF1F2937);
  static const Color darkSlateDark = Color(0xFF111827);
  static const Color slateGrey = Color(0xFF64748B);
  static const Color neutralGrey = Color(0xFF9CA3AF);

  // Functional Semantic
  static const Color safetyGreen = Color(0xFF10B981);
  static const Color warningOrange = Color(0xFFF59E0B);

  // Borders
  static const Color borderColor = Color(0xFFE5E7EB); // Gray 200
  static const Color focusedBorderColor = safeTeal;
  static const Color errorBorderColor = emergencyRed;
  static const Color infoBlue = Color(0xFF3B82F6); // Blue 500
}
