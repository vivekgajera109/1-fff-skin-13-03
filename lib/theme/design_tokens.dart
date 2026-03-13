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
  static const double radiusM = 16.0;
  static const double radiusL = 20.0;
  static const double radiusXL = 32.0;
  static const double radiusFull = 999.0;

  // ── Premium Gaming Color Palette ───────────────────────────────────────────────
  static const Color background = Color(0xFF0A0F1C);
  static const Color surface = Color(0xFF121A2B);
  
  static const Color primary = Color(0xFF6C5CE7);
  static const Color secondary = Color(0xFF00E5FF);
  static const Color accent = Color(0xFFFF3D81);

  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFA0A7B8);
  static const Color divider = Color(0xFF1F2A3A);

  // ── Gradients ─────────────────────────────────────────────────────────────
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [primary, accent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient surfaceGradient = LinearGradient(
    colors: [surface, Color(0xFF1B263B)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ── Shadows & Glows ───────────────────────────────────────────────────────
  static const List<BoxShadow> premiumShadow = [
    BoxShadow(
      color: Colors.black45,
      blurRadius: 15,
      offset: Offset(0, 8),
    ),
  ];

  static const List<BoxShadow> glowShadow = [
    BoxShadow(
      color: Color(0x446C5CE7),
      blurRadius: 15,
      spreadRadius: 2,
    ),
  ];
}

