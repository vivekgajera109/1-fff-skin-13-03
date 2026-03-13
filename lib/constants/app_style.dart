import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyle {
  static const String _font = "Outfit";

  /* -------------------- REGULAR -------------------- */

  static TextStyle regular36 =
      _style(36, FontWeight.w400, AppColors.textPrimary);
  static TextStyle regular30 =
      _style(30, FontWeight.w400, AppColors.textPrimary);
  static TextStyle regular25 =
      _style(25, FontWeight.w400, AppColors.textPrimary);
  static TextStyle regular20 =
      _style(20, FontWeight.w400, AppColors.textPrimary);
  static TextStyle regular16 =
      _style(16, FontWeight.w400, AppColors.textPrimary);
  static TextStyle regular14 =
      _style(14, FontWeight.w400, AppColors.textSecondary);
  static TextStyle regular12 =
      _style(12, FontWeight.w400, AppColors.textSecondary);
  static TextStyle regular10 =
      _style(10, FontWeight.w400, AppColors.textSecondary);

  /* -------------------- SEMIBOLD -------------------- */

  static TextStyle semiBold36 =
      _style(36, FontWeight.w600, AppColors.textPrimary);
  static TextStyle semiBold30 =
      _style(30, FontWeight.w600, AppColors.textPrimary);
  static TextStyle semiBold25 =
      _style(25, FontWeight.w600, AppColors.textPrimary);
  static TextStyle semiBold20 =
      _style(20, FontWeight.w600, AppColors.textPrimary);
  static TextStyle semiBold16 =
      _style(16, FontWeight.w600, AppColors.textPrimary);
  static TextStyle semiBold14 =
      _style(14, FontWeight.w600, AppColors.textSecondary);
  static TextStyle semiBold12 =
      _style(12, FontWeight.w600, AppColors.textSecondary);

  /* -------------------- BOLD -------------------- */

  static TextStyle bold36 = _style(36, FontWeight.w700, AppColors.textPrimary);
  static TextStyle bold30 = _style(30, FontWeight.w700, AppColors.textPrimary);
  static TextStyle bold25 = _style(25, FontWeight.w700, AppColors.textPrimary);
  static TextStyle bold20 = _style(20, FontWeight.w700, AppColors.textPrimary);
  static TextStyle bold16 = _style(16, FontWeight.w700, AppColors.textPrimary);
  static TextStyle bold14 = _style(14, FontWeight.w700, AppColors.textPrimary);

  /* -------------------- SPECIAL -------------------- */

  /// Accent text (buttons, highlights)
  static TextStyle accent16 = _style(16, FontWeight.w600, AppColors.accent);

  /// Muted / hint / helper text
  static TextStyle muted12 =
      _style(12, FontWeight.w400, AppColors.textSecondary);

  /// Error text
  static TextStyle error14 = _style(14, FontWeight.w500, AppColors.danger);

  /* -------------------- BASE -------------------- */

  static TextStyle _style(double size, FontWeight weight, Color color) {
    return TextStyle(
      fontSize: size,
      fontWeight: weight,
      fontFamily: _font,
      color: color,
      height: 1.3, // premium spacing
    );
  }
}
