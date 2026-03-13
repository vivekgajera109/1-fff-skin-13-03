import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/design_tokens.dart';
import '../widgets/premium_widgets.dart';
import '../common/Ads/ads_card.dart';
import '../helper/remote_config_service.dart';
import '../model/home_item_model.dart';

class DimondTipsDetalis extends StatelessWidget {
  final HomeItemModel item;
  const DimondTipsDetalis({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      useSafeArea: false,
      child: Stack(
        children: [
          // Tactical Background
          _buildTacticalGrid(),

          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              CyberSliverAppBar(
                title: "Briefing Terminal",
                expandedHeight: 220,
                accentColor: DesignTokens.secondary,
                backgroundExtras: [
                  Positioned(
                    right: -40,
                    bottom: -20,
                    child: Opacity(
                      opacity: 0.1,
                      child: Icon(Icons.radar_rounded, size: 240, color: DesignTokens.secondary),
                    ),
                  ),
                ],
              ),

              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    if (RemoteConfigService.isAdsShow) ...[
                      const BanerAdsScreen(),
                      const SizedBox(height: 32),
                    ],

                    // Meta Info Badge
                    _buildMetaBadge(),
                    
                    const SizedBox(height: 32),

                    // Tactical Briefing Module
                    _buildBriefingModule(),

                    if (RemoteConfigService.isAdsShow) ...[
                      const SizedBox(height: 36),
                      const NativeAdsScreen(),
                    ],
                    
                    const SizedBox(height: 48),
                    
                    GradientButton(
                      text: 'ACKNOWLEDGE AND SYNC',
                      icon: Icons.sync_rounded,
                      onPressed: () => Navigator.pop(context),
                      color: DesignTokens.secondary,
                    ),
                    
                    const SizedBox(height: 120),
                  ]),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTacticalGrid() {
    return Positioned.fill(
      child: Opacity(
        opacity: 0.03,
        child: CustomPaint(painter: _TacticalGridPainter()),
      ),
    );
  }

  Widget _buildMetaBadge() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: DesignTokens.secondary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: DesignTokens.secondary.withOpacity(0.3)),
          ),
          child: Text(
            "RESTRICTED ACCESS",
            style: GoogleFonts.outfit(
              fontSize: 8,
              fontWeight: FontWeight.w900,
              color: DesignTokens.secondary,
              letterSpacing: 2,
            ),
          ),
        ),
        Text(
          "BRIEF_FILE_0x44",
          style: GoogleFonts.outfit(
            fontSize: 9,
            fontWeight: FontWeight.bold,
            color: DesignTokens.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildBriefingModule() {
    return CyberPanel(
      color: DesignTokens.secondary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.title.toUpperCase(),
            style: GoogleFonts.outfit(
              fontSize: 26,
              fontWeight: FontWeight.w900,
              color: DesignTokens.textPrimary,
              height: 1,
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: 24),
          const Divider(color: Colors.white12, height: 1),
          const SizedBox(height: 24),
          Text(
            "TACTICAL_ANALYSIS",
            style: GoogleFonts.outfit(
              fontSize: 10,
              fontWeight: FontWeight.w900,
              color: DesignTokens.secondary,
              letterSpacing: 3,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            item.subTitle ?? "Strategic metadata currently cached in remote buffer. Initiating standard decryption protocols for field advisory.",
            style: GoogleFonts.outfit(
              fontSize: 15,
              color: DesignTokens.textSecondary,
              height: 1.6,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _TacticalGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white..strokeWidth = 0.5;
    for (double i = 0; i < size.width; i += 40) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
    for (double i = 0; i < size.height; i += 40) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}




