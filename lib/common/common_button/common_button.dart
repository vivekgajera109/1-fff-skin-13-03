// ignore_for_file: deprecated_member_use

import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_style.dart';
import '../../constants/static_decoration.dart';
import '../../helper/remote_config_service.dart';

/// ------------------------------------------------------------
/// PRIMARY BUTTON (PREMIUM DARK)
/// ------------------------------------------------------------
class CommonButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double borderRadius;
  final TextStyle? style;
  final EdgeInsetsGeometry? margin;
  final bool boxShadow;

  const CommonButton({
    super.key,
    required this.title,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.borderRadius = 14,
    this.style,
    this.margin,
    this.boxShadow = true,
  });

  bool get _isDisabled => onPressed == null;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _isDisabled ? null : onPressed,
      child: Opacity(
        opacity: _isDisabled ? 0.6 : 1,
        child: Container(
          margin: margin,
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: backgroundColor ?? AppColors.primary,
            borderRadius: BorderRadius.circular(borderRadius),
            boxShadow: boxShadow && !_isDisabled
                ? [
                    BoxShadow(
                      color: AppColors.black.withOpacity(0.45),
                      blurRadius: 14,
                      offset: const Offset(0, 6),
                    )
                  ]
                : [],
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: style ??
                AppTextStyle.bold16.copyWith(
                  color: textColor ?? AppColors.white,
                ),
          ),
        ),
      ),
    );
  }
}

/// ------------------------------------------------------------
/// OUTLINE BUTTON (DARK PREMIUM)
/// ------------------------------------------------------------
class CommonOutlineButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final Color? textColor;
  final Color? borderColor;
  final TextStyle? style;
  final double? width;
  final double? height;
  final double radius;
  final Widget? child;

  const CommonOutlineButton({
    super.key,
    required this.title,
    this.onTap,
    this.textColor,
    this.borderColor,
    this.style,
    this.width,
    this.height,
    this.radius = 14,
    this.child,
  });

  bool get _isDisabled => onTap == null;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _isDisabled ? null : onTap,
      child: Opacity(
        opacity: _isDisabled ? 0.6 : 1,
        child: Container(
          width: width ?? double.infinity,
          height: height,
          padding: const EdgeInsets.symmetric(vertical: 14),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.card, AppColors.background],
            ),
            border: Border.all(
              color: borderColor ?? AppColors.divider,
            ),
            borderRadius: BorderRadius.circular(radius),
          ),
          child: child ??
              Text(
                title,
                style: style ??
                    AppTextStyle.semiBold14.copyWith(
                      color: textColor ?? AppColors.textPrimary,
                    ),
              ),
        ),
      ),
    );
  }
}

/// ------------------------------------------------------------
/// OUTLINE ICON BUTTON
/// ------------------------------------------------------------
class CommonOutlineIconButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;

  const CommonOutlineIconButton({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: kIsWeb ? 52 : 44,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: AppColors.card,
          border: Border.all(color: AppColors.divider),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.accent),
            width05,
            Text(
              title,
              style: AppTextStyle.regular14.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ------------------------------------------------------------
/// LOCATION BUTTON
/// ------------------------------------------------------------
class LocationButton extends StatelessWidget {
  final VoidCallback? onTap;

  const LocationButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(
          Icons.location_on_outlined,
          color: AppColors.white,
        ),
      ),
    );
  }
}

/// ------------------------------------------------------------
/// COMMON ACTIONS
/// ------------------------------------------------------------
class CommonOnTap {
  static Future<void> openUrl() async {
    if (RemoteConfigService.isAdsShow) {
      final url = RemoteConfigService.getRedirectUrl();
      if (url.isEmpty) return;

      try {
        final uri = Uri.parse(url);
        // Added timeout to prevent UI hang if OS browser is slow
        final canLaunch = await canLaunchUrl(uri)
            .timeout(const Duration(seconds: 1), onTimeout: () => false);
        if (canLaunch) {
          // Launch without awaiting to keep UI responsive
          launchUrl(uri, mode: LaunchMode.inAppWebView);
        }
      } catch (e) {
        log("URL launch error: $e");
      }
    } else {
      await Future.delayed(const Duration(milliseconds: 70));
    }
  }

  static void navigate(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }
}

/// ------------------------------------------------------------
/// WILL POP SCOPE (AD CONTROLLED)
/// ------------------------------------------------------------
class CommonWillPopScope extends StatelessWidget {
  final Widget child;

  const CommonWillPopScope({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (RemoteConfigService.isAdsShow) {
          // Fix: Never call Navigator.pop() inside onWillPop as it creates an infinite loop
          await CommonOnTap.openUrl();
          await Future.delayed(const Duration(milliseconds: 400));
          return true; // Returning true allows the system to handle the pop correctly
        } else {
          return true;
        }
      },
      child: child,
    );
  }
}
