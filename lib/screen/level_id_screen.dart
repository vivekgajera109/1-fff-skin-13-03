import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../theme/design_tokens.dart';
import '../widgets/premium_widgets.dart';
import '../common/Ads/ads_card.dart';
import '../provider/home_provider.dart';
import '../model/home_item_model.dart';
import '../helper/remote_config_service.dart';
import 'select_rank_screen.dart';

class LevelIdScreen extends StatelessWidget {
  final HomeItemModel model;

  const LevelIdScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      useSafeArea: false,
      child: Stack(
        children: [
          // Background atmospheric elements
          _buildBackgroundElements(),

          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // Cyber header with character silhouette
              CyberSliverAppBar(
                title: "Progression Level",
                expandedHeight: 240,
                accentColor: DesignTokens.secondary,
                backgroundExtras: [
                  Positioned(
                    left: -30,
                    bottom: -20,
                    child: Opacity(
                      opacity: 0.12,
                      child: Hero(
                        tag: 'character_lvl_bg_${model.title}',
                        child: model.image != null 
                            ? Image.asset(model.image!, height: 300, fit: BoxFit.contain)
                            : Icon(Icons.person_rounded, size: 200, color: DesignTokens.primary),
                      ),
                    ),
                  ),
                ],
              ),

              // Section header
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(24, 32, 24, 24),
                  child: GradientHeader(
                    title: 'Account Maturity',
                    accentColor: DesignTokens.secondary,
                    fontSize: 13,
                  ),
                ),
              ),

              // Level list
              Consumer<HomeProvider>(
                builder: (context, provider, _) {
                  final levels = provider.levelId;
                  return SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final level = levels[index];
                          bool showNativeAd = RemoteConfigService.isAdsShow &&
                              (index != 0 && index % 3 == 0);
                          return Column(
                            children: [
                              _buildLevelCard(context, level, index),
                              if (showNativeAd) ...[
                                const SizedBox(height: 24),
                                const NativeAdsScreen(),
                                const SizedBox(height: 24),
                              ] else
                                const SizedBox(height: 16),
                            ],
                          );
                        },
                        childCount: levels.length,
                      ),
                    ),
                  );
                },
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundElements() {
    return Stack(
      children: [
        Positioned(
          bottom: 100,
          right: -60,
          child: Opacity(
            opacity: 0.04,
            child: Icon(Icons.analytics_rounded, size: 350, color: DesignTokens.secondary),
          ),
        ),
      ],
    );
  }

  Widget _buildLevelCard(BuildContext context, String level, int index) {
    final color = _getLevelColor(index);
    return NeonCard(
      onTap: () => _handleSelection(context),
      padding: const EdgeInsets.all(20),
      borderColor: color.withOpacity(0.15),
      child: Row(
        children: [
          // Level icon/number
          GlowContainer(
            glowColor: color,
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: color.withOpacity(0.08),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: color.withOpacity(0.35), width: 1.5),
              ),
              child: Center(
                child: Text(
                  (index + 1).toString(),
                  style: GoogleFonts.outfit(
                    fontWeight: FontWeight.w900,
                    fontSize: 22,
                    color: color,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),

          // Level info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "LEVEL $level",
                  style: GoogleFonts.outfit(
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                    color: DesignTokens.textPrimary,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Synchronizing profile maturity...",
                  style: GoogleFonts.outfit(
                    color: DesignTokens.textSecondary,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          // Arrow
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.05),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.chevron_right_rounded,
              color: color,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleSelection(BuildContext context) async {
    await CommonOnTap.openUrl();
    await Future.delayed(const Duration(milliseconds: 400));
    if (!context.mounted) return;
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => SelectRankScreen(model: model)));
  }

  Color _getLevelColor(int index) {
    const palette = [
      DesignTokens.primary,
      DesignTokens.secondary,
      DesignTokens.accent,
      Color(0xFF00FF9D),
      Color(0xFF7B2FFF),
    ];
    return palette[index % palette.length];
  }
}



