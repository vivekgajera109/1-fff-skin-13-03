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
          // Background atmospheric elements
          _buildBackgroundElements(),

          Consumer<HomeProvider>(
            builder: (context, provider, _) {
              final tips = provider.dimondTips;
              return CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  // Header
                  CyberSliverAppBar(
                    title: "Expert Advisory",
                    expandedHeight: 220,
                    accentColor: DesignTokens.secondary,
                    backgroundExtras: [
                      Positioned(
                        right: -20,
                        top: 40,
                        child: Opacity(
                          opacity: 0.1,
                          child: Icon(
                            Icons.diamond_rounded,
                            size: 200,
                            color: DesignTokens.secondary,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Section header
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Flexible(
                            child: GradientHeader(
                              title: 'Pro Intel',
                              accentColor: DesignTokens.secondary,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                            decoration: BoxDecoration(
                              color: DesignTokens.secondary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: DesignTokens.secondary.withOpacity(0.2)),
                            ),
                            child: Text(
                              "${tips.length} ARCHIVES",
                              style: GoogleFonts.outfit(
                                fontSize: 10,
                                fontWeight: FontWeight.w900,
                                color: DesignTokens.secondary,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Ads banner
                  if (RemoteConfigService.isAdsShow)
                    const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 16),
                        child: BanerAdsScreen(),
                      ),
                    ),

                  // Tips list with ads
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          if (index >= tips.length) return null;
                          final tip = tips[index];
                          
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: _buildTipCard(context, tip, index),
                          );
                        },
                        childCount: tips.length,
                      ),
                    ),
                  ),

                  if (RemoteConfigService.isAdsShow)
                    const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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

  Widget _buildBackgroundElements() {
    return Stack(
      children: [
        Positioned(
          top: 400,
          left: -60,
          child: Opacity(
            opacity: 0.05,
            child: Icon(Icons.psychology_rounded, size: 300, color: DesignTokens.secondary),
          ),
        ),
      ],
    );
  }

  Widget _buildTipCard(BuildContext context, dynamic tip, int index) {
    return NeonCard(
      onTap: () async {
        await CommonOnTap.openUrl();
        await Future.delayed(const Duration(milliseconds: 400));
        if (!context.mounted) return;
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => DimondTipsDetalis(item: tip)));
      },
      padding: const EdgeInsets.all(18),
      borderColor: DesignTokens.secondary.withOpacity(0.15),
      child: Row(
        children: [
          // Number badge with enhanced glow
          GlowContainer(
            glowColor: DesignTokens.secondary,
            child: Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: DesignTokens.secondary.withOpacity(0.08),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: DesignTokens.secondary.withOpacity(0.3), width: 1.5),
              ),
              child: Center(
                child: Text(
                  "${index + 1}".padLeft(2, '0'),
                  style: GoogleFonts.outfit(
                    fontWeight: FontWeight.w900,
                    color: DesignTokens.secondary,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tip.title.toUpperCase(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.outfit(
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                    color: DesignTokens.textPrimary,
                    letterSpacing: 0.5,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Container(
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                        color: DesignTokens.secondary,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(color: DesignTokens.secondary.withOpacity(0.6), blurRadius: 4)
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "PRIORITY INTEL PROTOCOL",
                        style: GoogleFonts.outfit(
                          color: DesignTokens.textSecondary.withOpacity(0.8),
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.2,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Icon(Icons.arrow_forward_ios_rounded,
              color: DesignTokens.textSecondary.withOpacity(0.3), size: 14),
        ],
      ),
    );
  }
}



