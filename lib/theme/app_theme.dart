import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Islamic Art palette — green & gold
  static const Color emerald = Color(0xFF1B4332);
  static const Color forestGreen = Color(0xFF2D6A4F);
  static const Color sage = Color(0xFF95D5B2);
  static const Color gold = Color(0xFFD4A574);
  static const Color goldLight = Color(0xFFF1D5A6);
  static const Color cream = Color(0xFFFAF3E7);
  static const Color ivory = Color(0xFFFFF8E7);
  static const Color deepRed = Color(0xFF8B2331);
  static const Color charcoal = Color(0xFF2B2B2B);
  static const Color softBrown = Color(0xFF6B4423);

  static const LinearGradient emeraldGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [emerald, forestGreen],
  );

  static const LinearGradient goldGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [gold, goldLight],
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [ivory, cream],
  );
}

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.cream,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.emerald,
      primary: AppColors.emerald,
      secondary: AppColors.gold,
      surface: AppColors.ivory,
      brightness: Brightness.light,
    ),
    textTheme: GoogleFonts.amiriTextTheme().apply(
      bodyColor: AppColors.charcoal,
      displayColor: AppColors.emerald,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      iconTheme: const IconThemeData(color: AppColors.emerald),
      titleTextStyle: GoogleFonts.amiri(
        color: AppColors.emerald,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.emerald,
        foregroundColor: AppColors.ivory,
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        textStyle: GoogleFonts.amiri(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),
    cardTheme: CardThemeData(
      color: AppColors.ivory,
      elevation: 4,
      shadowColor: AppColors.gold.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: AppColors.gold.withOpacity(0.3), width: 1),
      ),
    ),
  );

  static TextStyle get arabicTitle => GoogleFonts.amiri(
        fontSize: 36,
        fontWeight: FontWeight.bold,
        color: AppColors.emerald,
        height: 1.4,
      );

  static TextStyle get arabicLarge => GoogleFonts.amiri(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: AppColors.charcoal,
        height: 1.5,
      );

  static TextStyle get arabicMedium => GoogleFonts.amiri(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        color: AppColors.charcoal,
      );

  static TextStyle get uzbekTitle => GoogleFonts.merriweather(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: AppColors.emerald,
      );

  static TextStyle get uzbekBody => GoogleFonts.merriweather(
        fontSize: 15,
        color: AppColors.charcoal,
        height: 1.5,
      );
}
