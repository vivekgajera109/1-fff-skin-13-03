import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
          // Background atmospheric elements
          _buildBackgroundElements(),

          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              CyberSliverAppBar(
                title: "League Rank",
                expandedHeight: 240,
                accentColor: DesignTokens.primary,
                backgroundExtras: [
                  Positioned(
                    right: -40,
                    top: -10,
                    child: Opacity(
                      opacity: 0.15,
                      child: Hero(
                        tag: 'character_select_${model.title}',
                        child: model.image != null
                            ? Image.asset(model.image!,
                                height: 300, fit: BoxFit.contain)
                            : Icon(Icons.person_rounded,
                                size: 200, color: DesignTokens.primary),
                      ),
                    ),
                  ),
                ],
              ),

              // Section header
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(24, 32, 24, 24),
                  child: GradientHeader(title: 'Target Division', fontSize: 13),
                ),
              ),

              // Rank grid
              Consumer<HomeProvider>(
                builder: (context, provider, _) {
                  final rankImages = provider.selectRankImage;
                  return SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 0.72,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) =>
                            _buildRankCard(context, rankImages[index], index),
                        childCount: rankImages.length,
                      ),
                    ),
                  );
                },
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 32)),

              if (RemoteConfigService.isAdsShow)
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
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

  Widget _buildBackgroundElements() {
    return Stack(
      children: [
        Positioned(
          top: 400,
          left: -80,
          child: Opacity(
            opacity: 0.05,
            child: Icon(Icons.military_tech_rounded,
                size: 400, color: DesignTokens.primary),
          ),
        ),
      ],
    );
  }

  Widget _buildRankCard(BuildContext context, String image, int index) {
    final accents = [
      DesignTokens.primary,
      DesignTokens.secondary,
      const Color(0xFFFFD700),
      DesignTokens.accent,
    ];
    final accent = accents[index % accents.length];

    return NeonCard(
      onTap: () => _handleSelection(context),
      padding: const EdgeInsets.all(16),
      borderColor: accent.withOpacity(0.15),
      child: Column(
        children: [
          // Rank image area with glow
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: accent.withOpacity(0.04),
                    borderRadius: BorderRadius.circular(20),
                    border:
                        Border.all(color: accent.withOpacity(0.12), width: 1.5),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: GlowContainer(
                    glowColor: accent,
                    blurRadius: 15,
                    child: Hero(
                      tag: 'rank_img_$index',
                      child: Image.asset(image, fit: BoxFit.contain),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Select button
          GradientButton(
            text: "SELECT",
            onPressed: () => _handleSelection(context),
            color: accent,
            height: 38,
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
