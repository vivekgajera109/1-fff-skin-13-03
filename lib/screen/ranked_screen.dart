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
  const RankedScreen({super.key, required this.model});

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
                title: "Tier Selection",
                expandedHeight: 220,
                accentColor: DesignTokens.primary,
                backgroundExtras: [
                  Positioned(
                    right: -30,
                    top: 20,
                    child: Opacity(
                      opacity: 0.1,
                      child: Hero(
                        tag: 'character_bg_${model.title}',
                        child: model.image != null 
                            ? Image.asset(model.image!, height: 320, fit: BoxFit.contain)
                            : Icon(Icons.military_tech_rounded, size: 200, color: DesignTokens.primary),
                      ),
                    ),
                  ),
                ],
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "IDENTIFY COMPETITIVE DIVISION",
                        style: GoogleFonts.outfit(
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          color: DesignTokens.primary,
                          letterSpacing: 3,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Sync your current tier for precise node allocation.",
                        style: GoogleFonts.outfit(
                          fontSize: 13,
                          color: DesignTokens.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Tactical Tier Modules
              Consumer<HomeProvider>(
                builder: (context, provider, _) {
                  final ranks = provider.ranked;
                  return SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          bool showNativeAd = RemoteConfigService.isAdsShow && (index != 0 && index % 3 == 0);
                          return Column(
                            children: [
                              _buildRankModule(context, ranks[index], index),
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

  Widget _buildTacticalGrid() {
    return Positioned.fill(
      child: Opacity(
        opacity: 0.03,
        child: CustomPaint(painter: _TacticalGridPainter()),
      ),
    );
  }

  Widget _buildRankModule(BuildContext context, String rank, int index) {
    final color = _getRankColor(index);
    final rankNames = ['BRONZE', 'SILVER', 'GOLD', 'PLATINUM', 'DIAMOND', 'HEROIC', 'VETERAN'];
    final tag = index < rankNames.length ? rankNames[index] : 'LEGEND';

    return CyberPanel(
      color: color,
      onTap: () => _handleSelection(context),
      child: Row(
        children: [
          // Rank ID and Icon
          Column(
            children: [
              Text(
                "NODE_${index + 1}",
                style: GoogleFonts.outfit(
                  fontSize: 7,
                  fontWeight: FontWeight.w900,
                  color: color,
                ),
              ),
              const SizedBox(height: 8),
              GlowContainer(
                glowColor: color,
                blurRadius: 10,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: color.withOpacity(0.3)),
                  ),
                  child: Center(
                    child: Icon(Icons.military_tech_rounded, color: color, size: 24),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 20),

          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        rank.toUpperCase(),
                        style: GoogleFonts.outfit(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: DesignTokens.textPrimary,
                          letterSpacing: -0.5,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    _buildTag(tag, color),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  "STABILIZING_TIER_PROTOCOLS...",
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
          Icon(Icons.chevron_right_rounded, color: color, size: 20),
        ],
      ),
    );
  }

  Widget _buildTag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Text(
        text,
        style: GoogleFonts.outfit(
          fontSize: 8,
          fontWeight: FontWeight.w900,
          color: color,
        ),
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
      Color(0xFFCD7F32), // Bronze
      Color(0xFFC0C0C0), // Silver
      Color(0xFFFFD700), // Gold
      Color(0xFF00E5FF), // Platinum
      Color(0xFF6C5CE7), // Diamond
      Color(0xFFFF3366), // Heroic
      Color(0xFFFF9F1C), // Grandmaster
    ];
    return colors[index % colors.length];
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




