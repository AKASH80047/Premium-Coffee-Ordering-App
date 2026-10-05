import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color coffeeBrown = Color(0xFF6B3F20);
  static const Color darkEspresso = Color(0xFF2B1B12);
  static const Color caramel = Color(0xFFD6A15F);
  static const Color cream = Color(0xFFF8F5F0);
  static const Color lightBeige = Color(0xFFF1E6D8);
  static const Color softGray = Color(0xFFE7E7E7);
  static const Color white = Color(0xFFFFFFFF);
  static const Color textDark = Color(0xFF2B1B12);
  static const Color textLight = Color(0xFF888888);
  
  // Dark Theme Colors
  static const Color darkBackground = Color(0xFF1C1511);
  static const Color darkCard = Color(0xFF2A211B);
  static const Color darkPrimary = Color(0xFFB8783D);
  static const Color darkText = Color(0xFFFFFFFF);
  static const Color darkSecondaryText = Color(0xFFC8C0BA);
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColors.coffeeBrown,
      scaffoldBackgroundColor: AppColors.cream,
      colorScheme: ColorScheme.light(
        primary: AppColors.coffeeBrown,
        secondary: AppColors.caramel,
        surface: AppColors.white,
        background: AppColors.cream,
      ),
      textTheme: GoogleFonts.outfitTextTheme().copyWith(
        displayLarge: GoogleFonts.outfit(color: AppColors.textDark, fontWeight: FontWeight.bold),
        displayMedium: GoogleFonts.outfit(color: AppColors.textDark, fontWeight: FontWeight.bold),
        bodyLarge: GoogleFonts.outfit(color: AppColors.textDark),
        bodyMedium: GoogleFonts.outfit(color: AppColors.textDark),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.cream,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.textDark),
        titleTextStyle: TextStyle(color: AppColors.textDark, fontSize: 20, fontWeight: FontWeight.w600),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.coffeeBrown,
          foregroundColor: AppColors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          padding: const EdgeInsets.symmetric(vertical: 16),
          elevation: 0,
          textStyle: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: AppColors.darkPrimary,
      scaffoldBackgroundColor: AppColors.darkBackground,
      colorScheme: ColorScheme.dark(
        primary: AppColors.darkPrimary,
        secondary: AppColors.darkPrimary,
        surface: AppColors.darkCard,
        background: AppColors.darkBackground,
      ),
      textTheme: GoogleFonts.outfitTextTheme().copyWith(
        displayLarge: GoogleFonts.outfit(color: AppColors.darkText, fontWeight: FontWeight.bold),
        displayMedium: GoogleFonts.outfit(color: AppColors.darkText, fontWeight: FontWeight.bold),
        bodyLarge: GoogleFonts.outfit(color: AppColors.darkText),
        bodyMedium: GoogleFonts.outfit(color: AppColors.darkText),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.darkBackground,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.darkText),
        titleTextStyle: TextStyle(color: AppColors.darkText, fontSize: 20, fontWeight: FontWeight.w600),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.darkPrimary,
          foregroundColor: AppColors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          padding: const EdgeInsets.symmetric(vertical: 16),
          elevation: 0,
          textStyle: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
