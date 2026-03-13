import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../theme/design_tokens.dart';
import '../widgets/premium_widgets.dart';
import '../common/Ads/ads_card.dart';
import '../provider/home_provider.dart';
import 'dimond_tips_details_screen.dart';
import '../helper/remote_config_service.dart';

class DimondTips extends StatelessWidget {
  const DimondTips({super.key});

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      useSafeArea: false,
      child: Stack(
        children: [
          // Tactical Background
          _buildTacticalGrid(),

          Consumer<HomeProvider>(
            builder: (context, provider, _) {
              final tips = provider.dimondTips;
              return CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  CyberSliverAppBar(
                    title: "Tips & Tricks",
                    expandedHeight: 220,
                    accentColor: DesignTokens.secondary,
                    backgroundExtras: [
                      Positioned(
                        right: -20,
                        top: 20,
                        child: Opacity(
                          opacity: 0.1,
                          child: Icon(Icons.diamond_rounded, size: 220, color: DesignTokens.secondary),
                        ),
                      ),
                    ],
                  ),

                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 32, 24, 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "DIAMOND GUIDE",
                                style: GoogleFonts.outfit(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w900,
                                  color: DesignTokens.secondary,
                                  letterSpacing: 2,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "New Tips Available",
                                style: GoogleFonts.outfit(
                                  fontSize: 11,
                                  color: DesignTokens.textSecondary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: DesignTokens.secondary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              "${tips.length} TIPS",
                              style: GoogleFonts.outfit(
                                fontSize: 8,
                                fontWeight: FontWeight.w900,
                                color: DesignTokens.secondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  if (RemoteConfigService.isAdsShow)
                    const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        child: BanerAdsScreen(),
                      ),
                    ),

                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          if (index >= tips.length) return null;
                          
                          // Ad insertion logic
                          Widget item = Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: _buildAdvisoryModule(context, tips[index], index),
                          );

                          if ((index + 1) % 2 == 0 && RemoteConfigService.isAdsShow) {
                            return Column(
                              children: [
                                item,
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: (index + 1) % 4 == 0 
                                    ? const NativeAdsScreen() 
                                    : const BanerAdsScreen(),
                                ),
                              ],
                            );
                          }
                          return item;
                        },
                        childCount: tips.length,
                      ),
                    ),
                  ),

                  if (RemoteConfigService.isAdsShow)
                    const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                        child: NativeAdsScreen(),
                      ),
                    ),

                  const SliverToBoxAdapter(child: SizedBox(height: 100)),
                ],
              );
            },
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

  Widget _buildAdvisoryModule(BuildContext context, dynamic tip, int index) {
    return CyberPanel(
      color: DesignTokens.secondary,
      onTap: () async {
        await CommonOnTap.openUrl();
        await Future.delayed(const Duration(milliseconds: 400));
        if (!context.mounted) return;
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => DimondTipsDetalis(item: tip)));
      },
      child: Row(
        children: [
          // Index and Glow Icon
          Column(
            children: [
              Text(
                "ID: ${index + 1}",
                style: GoogleFonts.outfit(
                  fontSize: 8,
                  fontWeight: FontWeight.w900,
                  color: DesignTokens.secondary,
                ),
              ),
              const SizedBox(height: 12),
              GlowContainer(
                glowColor: DesignTokens.secondary,
                blurRadius: 10,
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: DesignTokens.secondary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: DesignTokens.secondary.withOpacity(0.3)),
                  ),
                  child: const Center(
                    child: Icon(Icons.bolt_rounded, color: DesignTokens.secondary, size: 20),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 20),

          // Content Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        tip.title.toUpperCase(),
                        style: GoogleFonts.outfit(
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                          color: DesignTokens.textPrimary,
                          letterSpacing: 0,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    _buildMissionBadge(),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  "New strategies for you.",
                  style: GoogleFonts.outfit(
                    fontSize: 10,
                    color: DesignTokens.textSecondary,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(width: 12),
          Icon(Icons.arrow_forward_ios_rounded, color: DesignTokens.secondary.withOpacity(0.4), size: 12),
        ],
      ),
    );
  }

  Widget _buildMissionBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: DesignTokens.secondary.withOpacity(0.12),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: DesignTokens.secondary.withOpacity(0.3)),
      ),
      child: Text(
        "NEW",
        style: GoogleFonts.outfit(
          fontSize: 7,
          fontWeight: FontWeight.w900,
          color: DesignTokens.secondary,
        ),
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




