import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/design_tokens.dart';
import '../widgets/premium_widgets.dart';
import '../common/Ads/ads_card.dart';
import '../model/home_item_model.dart';
import 'home_screen.dart';
import '../helper/remote_config_service.dart';

class ClaimScreen extends StatelessWidget {
  final HomeItemModel model;
  const ClaimScreen({super.key, required this.model});

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
                title: "Deployment Finalized",
                expandedHeight: 280,
                accentColor: DesignTokens.primary,
                backgroundExtras: [
                  Positioned(
                    right: -50,
                    bottom: -30,
                    child: Opacity(
                      opacity: 0.1,
                      child: Hero(
                        tag: 'character_claim_${model.title}',
                        child: model.image != null 
                            ? Image.asset(model.image!, height: 320, fit: BoxFit.contain)
                            : Icon(Icons.verified_rounded, size: 280, color: DesignTokens.primary),
                      ),
                    ),
                  ),
                ],
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  child: Column(
                    children: [
                      if (RemoteConfigService.isAdsShow) ...[
                        const BanerAdsScreen(),
                        const SizedBox(height: 32),
                      ],
                      
                      // Tactical Deployment Module
                      _buildDeploymentModule(),

                      const SizedBox(height: 40),

                      if (RemoteConfigService.isAdsShow) ...[
                        const NativeAdsScreen(),
                        const SizedBox(height: 40),
                      ],

                      // Final Commit Action
                      _buildFinalCommitAction(context),

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

  Widget _buildDeploymentModule() {
    return CyberPanel(
      color: DesignTokens.primary,
      child: Column(
        children: [
          GlowContainer(
            glowColor: DesignTokens.primary,
            child: Container(
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: DesignTokens.primary.withOpacity(0.1),
                shape: BoxShape.circle,
                border: Border.all(color: DesignTokens.primary.withOpacity(0.35), width: 2),
              ),
              child: const Icon(Icons.verified_rounded, color: DesignTokens.primary, size: 60),
            ),
          ),
          const SizedBox(height: 32),
          Text(
            "CORE_SYNC_OPTIMIZED",
            style: GoogleFonts.outfit(
              color: DesignTokens.primary,
              fontWeight: FontWeight.w900,
              letterSpacing: 4,
              fontSize: 10,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            model.title.toUpperCase(),
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(
              fontSize: 32,
              fontWeight: FontWeight.w900,
              color: DesignTokens.textPrimary,
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: 24),
          const Divider(color: Colors.white12, height: 1),
          const SizedBox(height: 24),
          Text(
            "Payload verification finalized. Node access tokens have been synchronized with your local hardware identifier.",
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(
              color: DesignTokens.textSecondary,
              fontSize: 14,
              height: 1.6,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFinalCommitAction(BuildContext context) {
    return CyberPanel(
      color: DesignTokens.secondary,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.lock_open_rounded, color: DesignTokens.secondary, size: 18),
              const SizedBox(width: 12),
              Text(
                "STAGING_COMMIT",
                style: GoogleFonts.outfit(
                  color: DesignTokens.secondary,
                  fontWeight: FontWeight.w900,
                  fontSize: 10,
                  letterSpacing: 3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            "Initiate the final cryptographic handshake to authorize the deployment to your secure vault.",
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(
              color: DesignTokens.textSecondary,
              fontSize: 14,
              height: 1.5,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 32),
          GradientButton(
            text: "INITIALIZE DEPLOY",
            icon: Icons.double_arrow_rounded,
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
    
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      pageBuilder: (_, __, ___) => _DeployDialog(title: model.title),
      transitionDuration: const Duration(milliseconds: 400),
      transitionBuilder: (context, animation, _, child) {
        return FadeTransition(opacity: animation, 
        child: ScaleTransition(scale: Tween<double>(begin: 0.8, end: 1.0).animate(
          CurvedAnimation(parent: animation, curve: Curves.easeOutBack)),
          child: child));
      },
    );
  }
}

class _DeployDialog extends StatelessWidget {
  final String title;
  const _DeployDialog({required this.title});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: CyberPanel(
        color: DesignTokens.primary,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.rocket_launch_rounded, size: 64, color: DesignTokens.primary),
            const SizedBox(height: 32),
            Text(
              "DEPLOYED",
              style: GoogleFonts.outfit(
                fontSize: 28,
                fontWeight: FontWeight.w900,
                color: DesignTokens.textPrimary,
                letterSpacing: 8,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Hardware link stable. Assets for "$title" are now active in your neural cluster.',
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(
                color: DesignTokens.textSecondary, 
                fontSize: 14, 
                height: 1.6,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 40),
            GradientButton(
              text: "TERMINATE TERMINAL",
              icon: Icons.power_settings_new_rounded,
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const HomeScreen()),
                    (_) => false);
              },
            ),
          ],
        ),
      ),
    );
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




