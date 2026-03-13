import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/design_tokens.dart';
import '../widgets/premium_widgets.dart';
import '../common/Ads/ads_card.dart';
import '../model/home_item_model.dart';
import '../helper/remote_config_service.dart';
import 'characters_detalis_screen.dart';

class CharactersScreen extends StatelessWidget {
  final List<HomeItemModel> characters;
  final String appBarTitle;
  final bool isSquared;

  const CharactersScreen({
    super.key,
    required this.characters,
    required this.appBarTitle,
    this.isSquared = true,
  });

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
                title: appBarTitle,
                expandedHeight: 220,
                accentColor: DesignTokens.primary,
                backgroundExtras: [
                  Positioned(
                    right: -30,
                    top: 20,
                    child: Opacity(
                      opacity: 0.1,
                      child: Icon(Icons.person_pin_rounded, size: 220, color: DesignTokens.primary),
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
                            "COLLECTION",
                            style: GoogleFonts.outfit(
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                              color: DesignTokens.primary,
                              letterSpacing: 3,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Items Available",
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
                          color: DesignTokens.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          "${characters.length} ITEMS",
                          style: GoogleFonts.outfit(
                            fontSize: 8,
                            fontWeight: FontWeight.w900,
                            color: DesignTokens.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              ..._buildGridWithAds(context),
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

  List<Widget> _buildGridWithAds(BuildContext context) {
    List<Widget> slivers = [];
    for (int i = 0; i < characters.length; i += 2) {
      int end = (i + 2 < characters.length) ? i + 2 : characters.length;
      final chunk = characters.sublist(i, end);
      slivers.add(
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              childAspectRatio: 0.78,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) =>
                  _buildArchiveUnit(context, chunk[index], i + index),
              childCount: chunk.length,
            ),
          ),
        ),
      );
      if (end < characters.length && RemoteConfigService.isAdsShow) {
        final adIndex = i ~/ 2;
        slivers.add(
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: adIndex % 2 == 0
                  ? const NativeAdsScreen()
                  : const BanerAdsScreen(),
            ),
          ),
        );
      }
    }
    slivers.add(const SliverToBoxAdapter(child: SizedBox(height: 100)));
    return slivers;
  }

  Widget _buildArchiveUnit(BuildContext context, HomeItemModel item, int index) {
    final colors = [
      DesignTokens.primary,
      DesignTokens.secondary,
      DesignTokens.accent,
      const Color(0xFF00FF9D),
    ];
    final color = colors[index % colors.length];

    return CyberPanel(
      color: color,
      onTap: () => _openDetails(context, item, isSquared),
      child: Column(
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
              _buildEliteBadge(color),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Center(
              child: GlowContainer(
                glowColor: color,
                blurRadius: 15,
                child: Hero(
                  tag: 'character_${item.title}',
                  child: Image.asset(item.image!, fit: BoxFit.contain),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            item.title.toUpperCase(),
            style: GoogleFonts.outfit(
              fontSize: 12,
              fontWeight: FontWeight.w900,
              color: DesignTokens.textPrimary,
              letterSpacing: 0.5,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: color.withOpacity(0.2)),
            ),
            child: Center(
              child: Text(
                "VIEW",
                style: GoogleFonts.outfit(
                  fontSize: 7,
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

  Widget _buildEliteBadge(Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withOpacity(0.3), width: 1),
      ),
      child: Text(
        "ELITE",
        style: GoogleFonts.outfit(
          fontSize: 7,
          fontWeight: FontWeight.w900,
          color: color,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Future<void> _openDetails(
      BuildContext context, HomeItemModel character, bool isSquared) async {
    await CommonOnTap.openUrl();
    await Future.delayed(const Duration(milliseconds: 400));
    if (!context.mounted) return;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => CharactersDetalisScreen(
                characters: character, isSquared: isSquared)));
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



