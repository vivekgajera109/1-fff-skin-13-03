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
          // Tactical Background
          _buildTacticalGrid(),

          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              CyberSliverAppBar(
                title: "Select Level",
                expandedHeight: 220,
                accentColor: DesignTokens.primary,
                backgroundExtras: [
                  Positioned(
                    right: -20,
                    top: 20,
                    child: Opacity(
                      opacity: 0.1,
                      child: Icon(Icons.hub_rounded,
                          size: 220, color: DesignTokens.primary),
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
                            "LEVELS",
                            style: GoogleFonts.outfit(
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                              color: DesignTokens.primary,
                              letterSpacing: 3,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Choose your current level",
                            style: GoogleFonts.outfit(
                              fontSize: 11,
                              color: DesignTokens.textSecondary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      _buildStatusIndicator(),
                    ],
                  ),
                ),
              ),
              if (RemoteConfigService.isAdsShow)
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(24, 0, 24, 24),
                    child: BanerAdsScreen(),
                  ),
                ),
              Consumer<HomeProvider>(
                builder: (context, provider, _) {
                  final levels = provider.levelId;
                  return SliverPadding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    sliver: SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 18,
                        crossAxisSpacing: 18,
                        childAspectRatio: 0.8,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) =>
                            _buildStabilityNode(context, levels[index], index),
                        childCount: levels.length,
                      ),
                    ),
                  );
                },
              ),
              if (RemoteConfigService.isAdsShow)
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                    child: NativeAdsScreen(),
                  ),
                ),
              const SliverToBoxAdapter(child: SizedBox(height: 120)),
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

  Widget _buildStatusIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: DesignTokens.primary.withOpacity(0.12),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: DesignTokens.primary.withOpacity(0.3)),
      ),
      child: Text(
        "ACTIVE",
        style: GoogleFonts.outfit(
          fontSize: 8,
          fontWeight: FontWeight.w900,
          color: DesignTokens.primary,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _buildStabilityNode(BuildContext context, String level, int index) {
    final colors = [
      DesignTokens.primary,
      DesignTokens.secondary,
      DesignTokens.accent,
      const Color(0xFF00FF9D),
    ];
    final color = colors[index % colors.length];
    final progress = 0.95 - (index * 0.08);

    return CyberPanel(
      color: color,
      onTap: () => _handleSelection(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "ID: ${index + 1}",
                style: GoogleFonts.outfit(
                  fontSize: 8,
                  fontWeight: FontWeight.w900,
                  color: color,
                ),
              ),
              Icon(Icons.bolt_rounded, color: color, size: 10),
            ],
          ),
          const Spacer(),
          Text(
            level,
            style: GoogleFonts.outfit(
              fontSize: 40,
              fontWeight: FontWeight.w900,
              color: DesignTokens.textPrimary,
              height: 0.8,
              letterSpacing: -2,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "EXPERIENCE",
            style: GoogleFonts.outfit(
              fontSize: 9,
              fontWeight: FontWeight.bold,
              color: color.withOpacity(0.8),
              letterSpacing: 1,
            ),
          ),
          const Spacer(),
          _buildStabilityBar(color, progress),
        ],
      ),
    );
  }

  Widget _buildStabilityBar(Color color, double progress) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "PROGRESS",
              style: GoogleFonts.outfit(
                  fontSize: 7,
                  fontWeight: FontWeight.bold,
                  color: DesignTokens.textSecondary),
            ),
            Text(
              "${(progress * 100).toInt()}%",
              style: GoogleFonts.outfit(
                  fontSize: 7, fontWeight: FontWeight.w900, color: color),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Container(
          height: 2,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white12,
            borderRadius: BorderRadius.circular(1),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: progress,
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(1),
                boxShadow: [
                  BoxShadow(color: color.withOpacity(0.5), blurRadius: 4),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _handleSelection(BuildContext context) async {
    await CommonOnTap.openUrl();
    await Future.delayed(const Duration(milliseconds: 400));
    if (!context.mounted) return;
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => SelectRankScreen(model: model)));
  }
}

class _TacticalGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 0.5;
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
