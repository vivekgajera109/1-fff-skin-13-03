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
          // Background atmospheric elements
          _buildBackgroundElements(),

          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // Cyber Header with Character Preview
              CyberSliverAppBar(
                title: "Claim Synchronized",
                expandedHeight: 280,
                accentColor: DesignTokens.primary,
                backgroundExtras: [
                  Positioned(
                    right: -50,
                    bottom: -30,
                    child: Opacity(
                      opacity: 0.15,
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
                      _buildSuccessCard(),
                      const SizedBox(height: 32),
                      if (RemoteConfigService.isAdsShow) ...[
                        const NativeAdsScreen(),
                        const SizedBox(height: 32),
                      ],
                      _buildActionCard(context),
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
          top: 400,
          left: -40,
          child: Opacity(
            opacity: 0.04,
            child: Icon(Icons.hub_rounded, size: 350, color: DesignTokens.primary),
          ),
        ),
      ],
    );
  }

  Widget _buildSuccessCard() {
    return NeonCard(
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 32),
      borderColor: DesignTokens.primary.withOpacity(0.25),
      child: Column(
        children: [
          GlowContainer(
            glowColor: DesignTokens.primary,
            child: Container(
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: DesignTokens.primary.withOpacity(0.08),
                shape: BoxShape.circle,
                border: Border.all(color: DesignTokens.primary.withOpacity(0.35), width: 2),
              ),
              child: const Icon(Icons.check_circle_outline_rounded, color: DesignTokens.primary, size: 68),
            ),
          ),
          const SizedBox(height: 36),
          Text(
            "ALGORITHM OPTIMIZED",
            style: GoogleFonts.outfit(
              color: DesignTokens.primary,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.5,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            model.title.toUpperCase(),
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(
              fontSize: 36,
              fontWeight: FontWeight.w900,
              color: DesignTokens.textPrimary,
              letterSpacing: -0.5,
              height: 1.0,
            ),
          ),
          const SizedBox(height: 32),
          const GradientHeader(title: 'Protocol Status', centerTitle: true, fontSize: 13),
          const SizedBox(height: 24),
          Text(
            "The character data for ${model.title} has been compiled and is staged for local synchronization. All cryptographic signatures verified.",
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(
              color: DesignTokens.textSecondary,
              fontSize: 16,
              height: 1.7,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(BuildContext context) {
    return NeonCard(
      padding: const EdgeInsets.all(32),
      borderColor: DesignTokens.secondary.withOpacity(0.25),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GlowContainer(
                glowColor: DesignTokens.secondary,
                child: const Icon(Icons.terminal_rounded, color: DesignTokens.secondary, size: 24),
              ),
              const SizedBox(width: 14),
              Text(
                "FINAL HANDSHAKE",
                style: GoogleFonts.outfit(
                  color: DesignTokens.secondary,
                  fontWeight: FontWeight.w900,
                  fontSize: 14,
                  letterSpacing: 2.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            "Establish the cryptographic connection to finalize deployment to your local storage cluster.",
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(
              color: DesignTokens.textSecondary,
              fontSize: 15,
              height: 1.7,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 36),
          GradientButton(
            text: "COMMIT DEPLOYMENT",
            icon: Icons.vpn_key_rounded,
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
      transitionDuration: const Duration(milliseconds: 500),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.9, end: 1.0).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeOutBack)),
            child: child,
          ),
        );
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
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: NeonCard(
        padding: const EdgeInsets.all(36),
        borderColor: DesignTokens.primary.withOpacity(0.4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GlowContainer(
              glowColor: DesignTokens.primary,
              child: Container(
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: DesignTokens.primary.withOpacity(0.08),
                  shape: BoxShape.circle,
                  border: Border.all(color: DesignTokens.primary.withOpacity(0.4), width: 2),
                ),
                child: const Icon(Icons.verified_rounded, size: 72, color: DesignTokens.primary),
              ),
            ),
            const SizedBox(height: 36),
            Text(
              "DEPLOYED",
              style: GoogleFonts.outfit(
                fontSize: 28,
                fontWeight: FontWeight.w900,
                color: DesignTokens.textPrimary,
                letterSpacing: 6,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Assets for "$title" have been successfully synchronized. Restart your session to view changes in the interface.',
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(
                color: DesignTokens.textSecondary, 
                fontSize: 15, 
                height: 1.7,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 40),
            GradientButton(
              text: "RETURN TO BASE",
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



