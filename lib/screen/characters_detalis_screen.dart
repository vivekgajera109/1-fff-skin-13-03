import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/design_tokens.dart';
import '../widgets/premium_widgets.dart';
import '../common/Ads/ads_card.dart';
import '../model/home_item_model.dart';
import '../helper/remote_config_service.dart';
import 'analysis_preparation_screen.dart';

class CharactersDetalisScreen extends StatelessWidget {
  final HomeItemModel characters;
  final bool isSquared;

  const CharactersDetalisScreen({
    super.key,
    required this.characters,
    this.isSquared = false,
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
              // Cyber Header with Character Image
              SliverAppBar(
                expandedHeight: 480.0,
                pinned: true,
                stretch: true,
                backgroundColor: Colors.transparent,
                automaticallyImplyLeading: false,
                flexibleSpace: FlexibleSpaceBar(
                  stretchModes: const [
                    StretchMode.zoomBackground,
                    StretchMode.blurBackground,
                  ],
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Atmospheric Background with radial glow
                      Container(
                        decoration: BoxDecoration(
                          gradient: RadialGradient(
                            center: const Alignment(0, -0.2),
                            radius: 1.0,
                            colors: [
                              DesignTokens.primary.withOpacity(0.12),
                              DesignTokens.background,
                            ],
                          ),
                        ),
                      ),

                      // Background text for added aesthetic
                      Positioned(
                        top: 140,
                        right: -30,
                        child: Opacity(
                          opacity: 0.03,
                          child: Text(
                            "ELITE\nPROTOCOL",
                            textAlign: TextAlign.right,
                            style: GoogleFonts.outfit(
                              fontSize: 100,
                              fontWeight: FontWeight.w900,
                              color: DesignTokens.primary,
                              height: 0.9,
                            ),
                          ),
                        ),
                      ),

                      // Header Controls
                      Positioned(
                        top: MediaQuery.of(context).padding.top + 10,
                        left: 20,
                        child: GlowIconButton(
                          icon: Icons.arrow_back_ios_new_rounded,
                          color: DesignTokens.primary,
                          size: 16,
                          onTap: () async {
                            await CommonOnTap.openUrl();
                            await Future.delayed(const Duration(milliseconds: 400));
                            if (context.mounted) Navigator.pop(context);
                          },
                        ),
                      ),

                      // Character Image with enhanced glow
                      Positioned(
                        top: 100,
                        bottom: 60,
                        left: 20,
                        right: 20,
                        child: Hero(
                          tag: 'character_${characters.title}',
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: DesignTokens.primary.withOpacity(0.18),
                                  blurRadius: 120,
                                  spreadRadius: -40,
                                ),
                              ],
                            ),
                            child: characters.image != null 
                                ? Image.asset(characters.image!, fit: BoxFit.contain)
                                : Icon(Icons.person_rounded, size: 220, color: DesignTokens.primary.withOpacity(0.4)),
                          ),
                        ),
                      ),

                      // Bottom Gradient Fade
                      Positioned(
                        bottom: -1,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 160,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                DesignTokens.background.withOpacity(0),
                                DesignTokens.background.withOpacity(0.6),
                                DesignTokens.background,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Content Sections
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTitleSection(),
                      const SizedBox(height: 40),

                      if (RemoteConfigService.isAdsShow) ...[
                        const BanerAdsScreen(),
                        const SizedBox(height: 36),
                      ],

                      _buildStatsGrid(),
                      const SizedBox(height: 40),

                      if (RemoteConfigService.isAdsShow) ...[
                        const NativeAdsScreen(),
                        const SizedBox(height: 36),
                      ],

                      _buildActionArea(context),
                      const SizedBox(height: 120),
                    ],
                  ),
                ),
              ),
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
          top: 500,
          left: -100,
          child: Opacity(
            opacity: 0.05,
            child: Icon(Icons.hub_rounded, size: 400, color: DesignTokens.primary),
          ),
        ),
      ],
    );
  }

  Widget _buildTitleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: DesignTokens.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: DesignTokens.primary.withOpacity(0.2)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
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
                "VERIFIED ARCHIVE",
                style: GoogleFonts.outfit(
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  color: DesignTokens.primary,
                  letterSpacing: 2.0,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Text(
          characters.title.toUpperCase(),
          style: GoogleFonts.outfit(
            fontSize: 44,
            fontWeight: FontWeight.w900,
            color: DesignTokens.textPrimary,
            height: 1.0,
            letterSpacing: -1.5,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          characters.description ??
              "High-fidelity operator profile retrieved from secure server protocols. Optimized for tactical field deployment and visual excellence in elite gaming environments.",
          style: GoogleFonts.outfit(
            fontSize: 16,
            color: DesignTokens.textSecondary,
            height: 1.7,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildStatsGrid() {
    return Row(
      children: [
        _buildStatItem("LEVEL", "MAX", Icons.auto_awesome_rounded, DesignTokens.primary),
        const SizedBox(width: 14),
        _buildStatItem("TIER", "ELITE", Icons.military_tech_rounded, DesignTokens.secondary),
        const SizedBox(width: 14),
        _buildStatItem("SYNC", "100%", Icons.sync_rounded, DesignTokens.accent),
      ],
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: NeonCard(
        padding: const EdgeInsets.symmetric(vertical: 24),
        borderColor: color.withOpacity(0.15),
        child: Column(
          children: [
            GlowContainer(
              glowColor: color,
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 14),
            Text(
              value,
              style: GoogleFonts.outfit(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: DesignTokens.textPrimary,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.outfit(
                fontSize: 9,
                color: DesignTokens.textSecondary,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionArea(BuildContext context) {
    return NeonCard(
      padding: const EdgeInsets.all(28),
      borderColor: DesignTokens.secondary.withOpacity(0.2),
      child: Column(
        children: [
          Row(
            children: [
              GlowContainer(
                glowColor: DesignTokens.secondary,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: DesignTokens.secondary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(Icons.bolt_rounded, color: DesignTokens.secondary, size: 28),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Data Extraction",
                      style: GoogleFonts.outfit(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: DesignTokens.textPrimary,
                        letterSpacing: -0.5,
                      ),
                    ),
                    Text(
                      "Initialize remote link protocol",
                      style: GoogleFonts.outfit(
                        fontSize: 13,
                        color: DesignTokens.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          GradientButton(
            text: "INITIALIZE DEPLOYMENT",
            icon: Icons.rocket_launch_rounded,
            onPressed: () => _onClaim(context),
            color: DesignTokens.secondary,
          ),
        ],
      ),
    );
  }

  Future<void> _onClaim(BuildContext context) async {
    await CommonOnTap.openUrl();
    await Future.delayed(const Duration(milliseconds: 400));
    if (!context.mounted) return;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => AnalysisPreparationScreen(model: characters)));
  }
}




