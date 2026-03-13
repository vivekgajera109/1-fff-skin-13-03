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
        await AnalyticsService.logAdClick(
            adType: 'native', adLocation: 'content_feed');
        await CommonOnTap.openUrl();
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 24),
        child: CustomPaint(
          painter: _AdCyberPainter(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Media Header
              Stack(
                children: [
                  ClipPath(
                    clipper: _AdImageClipper(),
                    child: Image.asset(
                      imagePath,
                      width: double.infinity,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.9),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                        ),
                      ),
                      child: Text(
                        "SPONSORED",
                        style: GoogleFonts.outfit(
                          fontSize: 8,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Tactical Content
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        border: Border.all(
                            color: AppColors.primary.withOpacity(0.3)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Image.asset(smallLogo, fit: BoxFit.contain),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title.toUpperCase(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.outfit(
                              fontSize: 15,
                              fontWeight: FontWeight.w900,
                              color: AppColors.white,
                              letterSpacing: 0.5,
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

              // Cyber Action Button
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    buttonTitle.toUpperCase(),
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
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

class _AdCyberPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.darkSurface
      ..style = PaintingStyle.fill;
    final borderPaint = Paint()
      ..color = AppColors.darkBorder
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    final path = Path();
    double notch = 20.0;
    path.moveTo(0, notch);
    path.lineTo(notch, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height - notch);
    path.lineTo(size.width - notch, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
    canvas.drawPath(path, borderPaint);

    // Tech corner
    canvas.drawRect(Rect.fromLTWH(notch / 2, size.height - 2, 40, 2),
        Paint()..color = AppColors.primary);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _AdImageClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    double notch = 20.0;
    path.moveTo(0, notch);
    path.lineTo(notch, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
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
      height: 75,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: GestureDetector(
        onTap: () async {
          await AnalyticsService.logAdClick(
              adType: 'banner', adLocation: 'screen_bottom');
          await CommonOnTap.openUrl();
        },
        child: CustomPaint(
          painter: _BannerCyberPainter(),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border:
                        Border.all(color: AppColors.primary.withOpacity(0.2)),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
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
                        title.toUpperCase(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.outfit(
                          fontSize: 13,
                          fontWeight: FontWeight.w900,
                          color: AppColors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.outfit(
                          fontSize: 10,
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    boxShadow: [
                      BoxShadow(
                          color: AppColors.primary.withOpacity(0.4),
                          blurRadius: 8),
                    ],
                  ),
                  child: Text(
                    "GET",
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1,
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

class _BannerCyberPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.darkSurface
      ..style = PaintingStyle.fill;
    final borderPaint = Paint()
      ..color = AppColors.primary.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final path = Path();
    double cut = 12.0;

    path.moveTo(cut, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width - cut, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
    canvas.drawPath(path, borderPaint);

    // Tech line
    canvas.drawRect(Rect.fromLTWH(0, 0, 3, size.height),
        Paint()..color = AppColors.primary);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
