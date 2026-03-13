import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../theme/design_tokens.dart';
import '../widgets/premium_widgets.dart';
import '../common/Ads/ads_card.dart';
import '../provider/home_provider.dart';
import '../model/home_item_model.dart';
import 'level_id_screen.dart';
import '../helper/remote_config_service.dart';

class RankedScreen extends StatelessWidget {
  final HomeItemModel model;

  const RankedScreen({
    super.key,
    required this.model,
  });

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
              // Header with character image
              CyberSliverAppBar(
                title: "League Tier",
                expandedHeight: 240,
                accentColor: DesignTokens.primary,
                backgroundExtras: [
                  Positioned(
                    right: -30,
                    bottom: -15,
                    child: Opacity(
                      opacity: 0.12,
                      child: Hero(
                        tag: 'character_bg_${model.title}',
                        child: model.image != null 
                            ? Image.asset(model.image!, height: 320, fit: BoxFit.contain)
                            : Icon(Icons.person_rounded, size: 200, color: DesignTokens.primary),
                      ),
                    ),
                  ),
                ],
              ),

              // Section header
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Flexible(
                        child: GradientHeader(
                          title: 'Competitive Division',
                          fontSize: 13,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: DesignTokens.primary.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: DesignTokens.primary.withOpacity(0.2)),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                color: DesignTokens.primary,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "LIVE STATUS",
                              style: GoogleFonts.outfit(
                                fontSize: 9,
                                fontWeight: FontWeight.w900,
                                color: DesignTokens.primary,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Rank list
              Consumer<HomeProvider>(
                builder: (context, provider, _) {
                  final ranks = provider.ranked;
                  return SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final rank = ranks[index];
                          bool showNativeAd = RemoteConfigService.isAdsShow &&
                              (index != 0 && index % 3 == 0);
                          return Column(
                            children: [
                              _buildRankItem(context, rank, index),
                              if (showNativeAd) ...[
                                const SizedBox(height: 24),
                                const NativeAdsScreen(),
                                const SizedBox(height: 24),
                              ] else
                                const SizedBox(height: 16),
                            ],
                          );
                        },
                        childCount: ranks.length,
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
          top: 350,
          left: -100,
          child: Opacity(
            opacity: 0.04,
            child: Icon(Icons.military_tech_rounded, size: 450, color: DesignTokens.primary),
          ),
        ),
      ],
    );
  }

  Widget _buildRankItem(BuildContext context, String rank, int index) {
    final color = _getRankColor(index);
    final rankNames = ['BRONZE', 'SILVER', 'GOLD', 'PLATINUM', 'DIAMOND', 'HEROIC', 'GRANDMASTER'];
    final rankTag = index < rankNames.length ? rankNames[index] : 'LEGEND';

    return NeonCard(
      onTap: () => _handleSelection(context),
      padding: const EdgeInsets.all(20),
      borderColor: color.withOpacity(0.15),
      child: Row(
        children: [
          // Rank icon box
          GlowContainer(
            glowColor: color,
            child: Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                color: color.withOpacity(0.08),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: color.withOpacity(0.35), width: 1.5),
              ),
              child: Center(
                child: Icon(Icons.military_tech_rounded, color: color, size: 28),
              ),
            ),
          ),
          const SizedBox(width: 20),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        rank.toUpperCase(),
                        style: GoogleFonts.outfit(
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                          color: DesignTokens.textPrimary,
                          letterSpacing: -0.5,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: color.withOpacity(0.35), width: 1),
                      ),
                      child: Text(
                        rankTag,
                        style: GoogleFonts.outfit(
                          fontSize: 9,
                          fontWeight: FontWeight.w900,
                          color: color,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  "Synthesizing operational protocols...",
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
        MaterialPageRoute(builder: (_) => LevelIdScreen(model: model)));
  }

  Color _getRankColor(int index) {
    const colors = [
      Color(0xFFCD7F32),
      Color(0xFFC0C0C0),
      Color(0xFFFFD700),
      Color(0xFF00E5FF),
      Color(0xFF6C5CE7),
      Color(0xFFFF3D81),
      Color(0xFFFF9F1C),
    ];
    return colors[index % colors.length];
  }
}



