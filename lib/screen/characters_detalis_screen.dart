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
          // Tactical Background
          _buildTacticalGrid(),

          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // Cyber Header
              SliverAppBar(
                expandedHeight: 460.0,
                pinned: true,
                stretch: true,
                backgroundColor: Colors.transparent,
                automaticallyImplyLeading: false,
                flexibleSpace: FlexibleSpaceBar(
                  stretchModes: const [StretchMode.zoomBackground],
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Atmospheric Background
                      Container(
                        decoration: BoxDecoration(
                          gradient: RadialGradient(
                            center: const Alignment(0, -0.2),
                            radius: 1.0,
                            colors: [
                              DesignTokens.primary.withOpacity(0.15),
                              DesignTokens.background,
                            ],
                          ),
                        ),
                      ),

                      // ID Badge Overlay
                      Positioned(
                        top: 140,
                        right: -20,
                        child: Opacity(
                          opacity: 0.05,
                          child: RotatedBox(
                            quarterTurns: 1,
                            child: Text(
                              "OP_FILE_${characters.title.toUpperCase()}",
                              style: GoogleFonts.outfit(
                                fontSize: 60,
                                fontWeight: FontWeight.w900,
                                color: DesignTokens.primary,
                                letterSpacing: 10,
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Header Back Control
                      Positioned(
                        top: MediaQuery.of(context).padding.top + 10,
                        left: 20,
                        child: GlowIconButton(
                          icon: Icons.arrow_back_ios_new_rounded,
                          color: DesignTokens.primary,
                          size: 16,
                          onTap: () async {
                            await CommonOnTap.openUrl();
                            await Future.delayed(
                                const Duration(milliseconds: 400));
                            if (context.mounted) Navigator.pop(context);
                          },
                        ),
                      ),

                      // Character Image
                      Positioned(
                        top: 100,
                        bottom: 40,
                        left: 20,
                        right: 20,
                        child: Hero(
                          tag: 'character_${characters.title}',
                          child: characters.image != null
                              ? Image.asset(characters.image!,
                                  fit: BoxFit.contain)
                              : Icon(Icons.person_rounded,
                                  size: 220,
                                  color: DesignTokens.primary.withOpacity(0.4)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildProfileHeader(),
                      const SizedBox(height: 40),
                      if (RemoteConfigService.isAdsShow) ...[
                        const BanerAdsScreen(),
                        const SizedBox(height: 36),
                      ],
                      _buildOperationalMatrix(),
                      const SizedBox(height: 40),
                      if (RemoteConfigService.isAdsShow) ...[
                        const NativeAdsScreen(),
                        const SizedBox(height: 40),
                      ],
                      _buildDeploymentTerminal(context),
                      if (RemoteConfigService.isAdsShow) ...[
                        const SizedBox(height: 32),
                        const BanerAdsScreen(),
                      ],
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

  Widget _buildTacticalGrid() {
    return Positioned.fill(
      child: Opacity(
        opacity: 0.03,
        child: CustomPaint(painter: _TacticalGridPainter()),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: DesignTokens.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
                border:
                    Border.all(color: DesignTokens.primary.withOpacity(0.3)),
              ),
              child: Text(
                "ONLINE",
                style: GoogleFonts.outfit(
                  fontSize: 8,
                  fontWeight: FontWeight.w900,
                  color: DesignTokens.primary,
                  letterSpacing: 2,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              "SYNCED // ARCHIVE:097",
              style: GoogleFonts.outfit(
                fontSize: 8,
                fontWeight: FontWeight.bold,
                color: DesignTokens.textSecondary,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          characters.title.toUpperCase(),
          style: GoogleFonts.outfit(
            fontSize: 48,
            fontWeight: FontWeight.w900,
            color: DesignTokens.textPrimary,
            height: 0.9,
            letterSpacing: -2,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          characters.description ??
              "Neural cluster data retrieved for high-tier operator. System integrity verified for immediate deployment protocols.",
          style: GoogleFonts.outfit(
            fontSize: 15,
            color: DesignTokens.textSecondary,
            height: 1.6,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildOperationalMatrix() {
    return Row(
      children: [
        _buildMatrixNode("POWER", "MAX", DesignTokens.primary),
        const SizedBox(width: 16),
        _buildMatrixNode("ELITE", "RANK", DesignTokens.secondary),
        const SizedBox(width: 16),
        _buildMatrixNode("GRID", "ACTIVE", DesignTokens.accent),
      ],
    );
  }

  Widget _buildMatrixNode(String label, String value, Color color) {
    return Expanded(
      child: CyberPanel(
        color: color,
        child: Column(
          children: [
            Text(
              value,
              style: GoogleFonts.outfit(
                textStyle: TextStyle(overflow: TextOverflow.ellipsis),
                fontSize: 15,
                fontWeight: FontWeight.w900,
                color: DesignTokens.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.outfit(
                fontSize: 8,
                fontWeight: FontWeight.w900,
                color: color,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeploymentTerminal(BuildContext context) {
    return CyberPanel(
      color: DesignTokens.secondary,
      child: Column(
        children: [
          Row(
            children: [
              GlowContainer(
                glowColor: DesignTokens.secondary,
                child: const Icon(Icons.bolt_rounded,
                    color: DesignTokens.secondary, size: 24),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "DEPLOYMENT_GATEWAY",
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      color: DesignTokens.textPrimary,
                    ),
                  ),
                  Text(
                    "STATUS: READY_FOR_UPLINK",
                    style: GoogleFonts.outfit(
                      fontSize: 9,
                      color: DesignTokens.secondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 32),
          GradientButton(
            text: "INITIALIZE UPLINK",
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
