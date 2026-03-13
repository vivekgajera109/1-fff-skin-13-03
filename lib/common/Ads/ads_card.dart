import 'dart:math';
import 'package:fff_skin_tools/common/modern_ui.dart';
import 'package:fff_skin_tools/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:fff_skin_tools/provider/ads_provider.dart';
import 'package:fff_skin_tools/common/common_button/common_button.dart';
import 'package:fff_skin_tools/helper/remote_config_service.dart';
import 'package:fff_skin_tools/helper/analytics_service.dart';

/// ===================================================================
/// ✅ SAFE NATIVE AD CARD (Premium Obsidian Style)
/// ===================================================================
class NativeAdsScreen extends StatefulWidget {
  const NativeAdsScreen({super.key});

  @override
  State<NativeAdsScreen> createState() => _NativeAdsScreenState();
}

class _NativeAdsScreenState extends State<NativeAdsScreen> {
  @override
  void initState() {
    super.initState();
    // Log ad impression
    if (RemoteConfigService.isAdsShow) {
      AnalyticsService.logAdImpression(
        adType: 'native',
        adLocation: 'content_feed',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!RemoteConfigService.isAdsShow) return const SizedBox.shrink();

    final adsProvider = context.watch<AdsProvider>();
    final random = Random();

    final imagePath =
        adsProvider.adsImages[random.nextInt(adsProvider.adsImages.length)];
    final smallLogo = adsProvider.nativeDimondImages[
        random.nextInt(adsProvider.nativeDimondImages.length)];
    final title =
        adsProvider.adTitles[random.nextInt(adsProvider.adTitles.length)];
    final subtitle =
        adsProvider.adSubtitles[random.nextInt(adsProvider.adSubtitles.length)];
    final buttonTitle = adsProvider
        .buttonTitles[random.nextInt(adsProvider.buttonTitles.length)];

    return GestureDetector(
      onTap: () async {
        // Log ad click
        await AnalyticsService.logAdClick(
          adType: 'native',
          adLocation: 'content_feed',
        );
        await CommonOnTap.openUrl();
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.15),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            color: AppColors.card,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Ad Media
                Stack(
                  children: [
                    Image.asset(
                      imagePath,
                      width: double.infinity,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          "AD",
                          style: GoogleFonts.outfit(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // Content
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: AppColors.white.withOpacity(0.05)),
                        ),
                        child: Image.asset(smallLogo, fit: BoxFit.contain),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.outfit(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: AppColors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              subtitle,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.outfit(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Action Button
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      buttonTitle.toUpperCase(),
                      style: GoogleFonts.outfit(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// ===================================================================
/// ✅ SAFE BANNER AD (Premium Obsidian Style)
/// ===================================================================
class BanerAdsScreen extends StatefulWidget {
  const BanerAdsScreen({super.key});

  @override
  State<BanerAdsScreen> createState() => _BanerAdsScreenState();
}

class _BanerAdsScreenState extends State<BanerAdsScreen> {
  @override
  void initState() {
    super.initState();
    // Log ad impression
    if (RemoteConfigService.isAdsShow) {
      AnalyticsService.logAdImpression(
        adType: 'banner',
        adLocation: 'screen_bottom',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!RemoteConfigService.isAdsShow) return const SizedBox.shrink();

    final adsProvider = context.watch<AdsProvider>();
    final random = Random();

    final title =
        adsProvider.adTitles[random.nextInt(adsProvider.adTitles.length)];
    final subtitle =
        adsProvider.adSubtitles[random.nextInt(adsProvider.adSubtitles.length)];
    final smallLogo = adsProvider.nativeDimondImages[
        random.nextInt(adsProvider.nativeDimondImages.length)];

    return Container(
      height: 90,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: GestureDetector(
        onTap: () async {
          // Log ad click
          await AnalyticsService.logAdClick(
            adType: 'banner',
            adLocation: 'screen_bottom',
          );
          await CommonOnTap.openUrl();
        },
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.white.withOpacity(0.05)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: 50,
                  height: 50,
                  color: AppColors.background,
                  child: Image.asset(smallLogo, fit: BoxFit.cover),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.outfit(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.outfit(
                        fontSize: 11,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  "OPEN",
                  style: GoogleFonts.outfit(
                    color: AppColors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
