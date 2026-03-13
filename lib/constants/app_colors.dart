import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// ignore_for_file: unused_import

class AppColors {
  // --- BASE ---
  static const Color black = Color(0xFF070A15);
  static const Color white = Color(0xFFF0F4FF);
  static const Color transparent = Colors.transparent;

  // --- DARK THEME (Premium Gaming) ---
  static const Color darkBackground = Color(0xFF070A15);
  static const Color darkSurface = Color(0xFF0F1425);
  static const Color darkCard = Color(0xFF161C32);
  static const Color darkBorder = Color(0xFF1F2943);
  static const Color darkTextPrimary = Color(0xFFF0F4FF);
  static const Color darkTextSecondary = Color(0xFF8A94AD);

  // --- LIGHT THEME (DEPRECATED) ---
  static const Color lightBackground = Color(0xFFF8FAFC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFF1F5F9);
  static const Color lightBorder = Color(0xFFE2E8F0);
  static const Color lightTextPrimary = Color(0xFF1E293B);
  static const Color lightTextSecondary = Color(0xFF64748B);

  // --- BRAND (New Gaming System) ---
  static const Color primary = Color(0xFF7000FF);
  static const Color secondary = Color(0xFF00F0FF);
  static const Color accent = Color(0xFFFF006B);
  static const Color highlight = Color(0xFF00FF9D);

  // --- STATUS ---
  static const Color success = Color(0xFF00FF9D);
  static const Color error = Color(0xFFFF006B);
  static const Color warning = Color(0xFFFFCC00);

  // --- COMPATIBILITY NAMES ---
  static const Color background = darkBackground;
  static const Color card = darkCard;
  static const Color textPrimary = darkTextPrimary;
  static const Color textSecondary = darkTextSecondary;
  static const Color danger = error;
  static const Color divider = darkBorder;

  // --- GRADIENTS ---
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, Color(0xFF9E00FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient surfaceGradient = LinearGradient(
    colors: [darkSurface, darkCard],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [accent, Color(0xFFFF5C00)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

}

class AppTheme {
  static ThemeData get darkTheme => _getTheme(isDark: true);
  static ThemeData get lightTheme => _getTheme(isDark: false);

  static ThemeData _getTheme({required bool isDark}) {
    final baseColor =
        isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final surfaceColor =
        isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final textPrimary =
        isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final textSecondary =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return ThemeData(
      useMaterial3: true,
      brightness: isDark ? Brightness.dark : Brightness.light,
      colorScheme: ColorScheme(
        brightness: isDark ? Brightness.dark : Brightness.light,
        primary: AppColors.primary,
        onPrimary: AppColors.white,
        secondary: AppColors.secondary,
        onSecondary: AppColors.white,
        surface: surfaceColor,
        onSurface: textPrimary,
        error: AppColors.error,
        onError: AppColors.white,
        outline: isDark ? AppColors.darkBorder : AppColors.lightBorder,
      ),
      scaffoldBackgroundColor: baseColor,

      // --- TYPOGRAPHY ---
      textTheme: GoogleFonts.outfitTextTheme(
        TextTheme(
          displayLarge: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: textPrimary,
              letterSpacing: -1),
          displayMedium: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: textPrimary,
              letterSpacing: -0.5),
          headlineLarge: TextStyle(
              fontSize: 24, fontWeight: FontWeight.w600, color: textPrimary),
          titleLarge: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: textPrimary),
          bodyLarge: TextStyle(fontSize: 16, color: textPrimary, height: 1.5),
          bodyMedium:
              TextStyle(fontSize: 14, color: textSecondary, height: 1.4),
          labelLarge: TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: textPrimary),
        ),
      ),

      // --- CARD THEME ---
      cardTheme: CardThemeData(
        color: isDark ? AppColors.darkCard : AppColors.lightSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(
            color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
            width: 1,
          ),
        ),
      ),

      // --- BUTTON THEME ---
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          minimumSize: const Size(double.infinity, 58),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          elevation: 0,
          textStyle: GoogleFonts.outfit(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ),

      // --- APPBAR THEME ---
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: textPrimary),
        titleTextStyle: GoogleFonts.outfit(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: textPrimary,
        ),
      ),

      dividerTheme: DividerThemeData(
        color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
        thickness: 1,
        space: 1,
      ),
    );
  }
}
