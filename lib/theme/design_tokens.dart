import 'package:flutter/material.dart';

class DesignTokens {
  // ── Spacing (8pt system) ──────────────────────────────────────────────────
  static const double spacing8 = 8.0;
  static const double spacing12 = 12.0;
  static const double spacing16 = 16.0;
  static const double spacing20 = 20.0;
  static const double spacing24 = 24.0;
  static const double spacing32 = 32.0;

  // ── Border Radius ─────────────────────────────────────────────────────────
  static const double radiusS = 8.0;
  static const double radiusM = 14.0;
  static const double radiusL = 20.0;
  static const double radiusXL = 32.0;
  static const double radiusFull = 999.0;

  // ── Premium Gaming Color Palette ───────────────────────────────────────────────
  static const Color background = Color(0xFF070A15);
  static const Color surface = Color(0xFF0F1425);
  static const Color card = Color(0xFF161C32);
  static const Color border = Color(0xFF1F2943);
  
  static const Color primary = Color(0xFF7000FF);
  static const Color secondary = Color(0xFF00F0FF);
  static const Color accent = Color(0xFFFF006B);
  static const Color highlight = Color(0xFF00FF9D);

  static const Color textPrimary = Color(0xFFF0F4FF);
  static const Color textSecondary = Color(0xFF8A94AD);
  static const Color divider = Color(0xFF1F2943);

  // ── Gradients ─────────────────────────────────────────────────────────────
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, Color(0xFF9E00FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cyberGradient = LinearGradient(
    colors: [secondary, primary],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient neonGradient = LinearGradient(
    colors: [accent, Color(0xFFFF5C00)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // ── Shadows & Glows ───────────────────────────────────────────────────────
  static List<BoxShadow> premiumShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.5),
      blurRadius: 20,
      offset: const Offset(0, 10),
    ),
  ];

  static List<BoxShadow> primaryGlow = [
    BoxShadow(
      color: primary.withOpacity(0.3),
      blurRadius: 15,
      spreadRadius: 1,
    ),
  ];

  static List<BoxShadow> secondaryGlow = [
    BoxShadow(
      color: secondary.withOpacity(0.3),
      blurRadius: 15,
      spreadRadius: 1,
    ),
  ];
}

