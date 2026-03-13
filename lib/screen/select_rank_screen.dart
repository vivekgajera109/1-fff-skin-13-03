import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/design_tokens.dart';
import '../widgets/premium_widgets.dart';
import '../common/Ads/ads_card.dart';
import '../provider/home_provider.dart';
import '../model/home_item_model.dart';
import 'claim_screen.dart';
import '../helper/remote_config_service.dart';

class SelectRankScreen extends StatelessWidget {
  final HomeItemModel model;
  const SelectRankScreen({super.key, required this.model});

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
                title: "Select Rank",
                expandedHeight: 220,
                accentColor: DesignTokens.primary,
                backgroundExtras: [
                  Positioned(
                    right: -40,
                    top: 20,
                    child: Opacity(
                      opacity: 0.1,
                      child: Icon(Icons.stars_rounded, size: 220, color: DesignTokens.primary),
                    ),
                  ),
                ],
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "CHOOSE YOUR RANK",
                        style: GoogleFonts.outfit(
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          color: DesignTokens.primary,
                          letterSpacing: 3,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Select your current game rank to proceed.",
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

              if (RemoteConfigService.isAdsShow)
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(24, 0, 24, 24),
                    child: BanerAdsScreen(),
                  ),
                ),

              // Tactical Rank Modules
              Consumer<HomeProvider>(
                builder: (context, provider, _) {
                  final rankImages = provider.selectRankImage;
                  return SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    sliver: SliverGrid(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                        childAspectRatio: 0.75,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => _buildDivisionModule(context, rankImages[index], index),
                        childCount: rankImages.length,
                      ),
                    ),
                  );
                },
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 48)),

              if (RemoteConfigService.isAdsShow)
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: NativeAdsScreen(),
                  ),
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

  Widget _buildDivisionModule(BuildContext context, String image, int index) {
    final colors = [
      DesignTokens.primary,
      DesignTokens.secondary,
      DesignTokens.accent,
      const Color(0xFF00FF9D),
    ];
    final color = colors[index % colors.length];

    return CyberPanel(
      color: color,
      onTap: () => _handleSelection(context),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "RANK ${index + 1}",
                  style: GoogleFonts.outfit(
                    fontSize: 8,
                    fontWeight: FontWeight.w900,
                    color: color,
                    letterSpacing: 1,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  "ACTIVE",
                  style: GoogleFonts.outfit(fontSize: 7, fontWeight: FontWeight.w900, color: color),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Center(
              child: GlowContainer(
                glowColor: color,
                blurRadius: 15,
                child: Hero(
                  tag: 'rank_img_$index',
                  child: Image.asset(image, fit: BoxFit.contain),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "LEVEL ${index + 1}",
            style: GoogleFonts.outfit(
              fontSize: 12,
              fontWeight: FontWeight.w900,
              color: DesignTokens.textPrimary,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: color.withOpacity(0.3)),
            ),
            child: Center(
              child: Text(
                "SELECT",
                style: GoogleFonts.outfit(
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  color: color,
                  letterSpacing: 2,
                ),
              ),
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
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => ClaimScreen(model: model)));
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

