import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/common/theme/app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.safeTeal,
        onPrimary: AppColors.white,
        secondary: AppColors.emergencyRed,
        onSecondary: AppColors.white,
        error: AppColors.emergencyRed,
        onError: AppColors.white,
        surface: AppColors.white,
        onSurface: AppColors.darkSlate,
        outline: AppColors.borderColor,
      ),
      scaffoldBackgroundColor: AppColors.white,
      fontFamily: GoogleFonts.inter().fontFamily,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.white,
        contentPadding: const EdgeInsets.all(16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.focusedBorderColor,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.errorBorderColor),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.darkSlate,
        elevation: 0,
        centerTitle: true,
      ),
      textTheme: TextTheme(
        // H1 - Large Heading (24pt - 32pt)
        headlineLarge: GoogleFonts.inter(
          fontSize: 32,
          fontWeight: FontWeight.bold, // 700
          color: AppColors.darkSlate,
          letterSpacing: -0.02, // Adjusting for "Emergency Alert" look
        ),
        headlineMedium: GoogleFonts.inter(
          fontSize: 24,
          fontWeight: FontWeight.bold, // 700
          color: AppColors.darkSlate,
        ),
        // H2 - Section Heading (18pt - 20pt)
        titleLarge: GoogleFonts.inter(
          fontSize: 20,
          fontWeight: FontWeight.w600, // Semi-Bold
          color: AppColors.darkSlate,
        ),
        titleMedium: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.w600, // Semi-Bold
          color: AppColors.darkSlate,
        ),
        // Body (14pt - 16pt)
        bodyLarge: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w400, // Regular
          color: AppColors.darkSlate,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w400, // Regular
          color: AppColors.darkSlate,
        ),
        // Caption (12pt)
        bodySmall: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w400, // Regular
          color: AppColors.darkSlate,
        ),
        // Button (14pt - Medium)
        labelLarge: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500, // Medium
          color: AppColors.white,
        ),
      ),
    );
  }
}
