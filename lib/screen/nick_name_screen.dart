import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/design_tokens.dart';
import '../widgets/premium_widgets.dart';
import '../common/Ads/ads_card.dart';
import '../model/home_item_model.dart';
import 'ranked_screen.dart';
import '../helper/remote_config_service.dart';

class NickNameScreen extends StatelessWidget {
  final HomeItemModel model;
  final TextEditingController _controller = TextEditingController();

  NickNameScreen({
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
              CyberSliverAppBar(
                title: "Identity Link",
                expandedHeight: 200,
                accentColor: DesignTokens.secondary,
                backgroundExtras: [
                  Positioned(
                    right: -30,
                    bottom: -10,
                    child: Opacity(
                      opacity: 0.1,
                      child: Icon(Icons.badge_rounded, size: 220, color: DesignTokens.secondary),
                    ),
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                  child: Column(
                    children: [
                      _buildCharacterBrief(),
                      const SizedBox(height: 32),
                      const GradientHeader(title: 'Identity Verification'),
                      const SizedBox(height: 20),
                      _buildUidInputCard(context),
                      const SizedBox(height: 32),
                      if (RemoteConfigService.isAdsShow) ...[
                        const NativeAdsScreen(),
                        const SizedBox(height: 32),
                      ],
                      GradientButton(
                        text: "ESTABLISH UPLINK",
                        icon: Icons.wifi_protected_setup_rounded,
                        onPressed: () => _onProceed(context),
                        color: DesignTokens.secondary,
                      ),
                      const SizedBox(height: 100),
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
          top: 300,
          left: -100,
          child: Opacity(
            opacity: 0.05,
            child: Icon(Icons.fingerprint_rounded, size: 400, color: DesignTokens.primary),
          ),
        ),
      ],
    );
  }

  Widget _buildCharacterBrief() {
    return NeonCard(
      padding: const EdgeInsets.all(22),
      borderColor: DesignTokens.primary.withOpacity(0.2),
      child: Row(
        children: [
          // Character avatar with glow ring
          GlowContainer(
            glowColor: DesignTokens.primary,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: DesignTokens.surface,
                border: Border.all(
                  color: DesignTokens.primary.withOpacity(0.3),
                  width: 2,
                ),
              ),
              child: Center(
                child: Hero(
                  tag: 'character_${model.title}',
                  child: model.image != null 
                      ? Image.asset(model.image!, height: 60, fit: BoxFit.contain)
                      : const Icon(Icons.person_rounded, size: 40, color: DesignTokens.textPrimary),
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: DesignTokens.primary,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(color: DesignTokens.primary.withOpacity(0.6), blurRadius: 6)
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "PAYLOAD IDENTIFIED",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: GoogleFonts.outfit(
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          color: DesignTokens.primary,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  model.title.toUpperCase(),
                  style: GoogleFonts.outfit(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: DesignTokens.textPrimary,
                    letterSpacing: 0.5,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  "Synchronization protocol ready",
                  style: GoogleFonts.outfit(
                    fontSize: 12,
                    color: DesignTokens.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          const Icon(Icons.verified_rounded, color: DesignTokens.primary, size: 22),
        ],
      ),
    );
  }

  Widget _buildUidInputCard(BuildContext context) {
    return NeonCard(
      padding: const EdgeInsets.all(28),
      borderColor: DesignTokens.secondary.withOpacity(0.2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GlowContainer(
                glowColor: DesignTokens.secondary,
                child: const Icon(Icons.fingerprint_rounded, color: DesignTokens.secondary, size: 30),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "NEURAL LINK",
                      style: GoogleFonts.outfit(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: DesignTokens.textPrimary,
                        letterSpacing: 1,
                      ),
                    ),
                    Text(
                      "Verification Required",
                      style: GoogleFonts.outfit(
                        fontSize: 12,
                        color: DesignTokens.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),

          // UID Input field
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
              borderRadius: BorderRadius.circular(DesignTokens.radiusS),
              border: Border.all(color: DesignTokens.secondary.withOpacity(0.15)),
            ),
            child: TextField(
              controller: _controller,
              style: GoogleFonts.outfit(
                color: DesignTokens.textPrimary,
                fontWeight: FontWeight.w900,
                letterSpacing: 2,
                fontSize: 16,
              ),
              decoration: InputDecoration(
                hintText: "ENTER GAMING UID",
                hintStyle: GoogleFonts.outfit(
                  color: DesignTokens.textSecondary.withOpacity(0.3),
                  letterSpacing: 1.5,
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                ),
                prefixIcon: const Icon(Icons.grid_3x3_rounded, color: DesignTokens.secondary, size: 18),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Info note
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: DesignTokens.secondary.withOpacity(0.05),
              borderRadius: BorderRadius.circular(DesignTokens.radiusS),
              border: Border.all(color: DesignTokens.secondary.withOpacity(0.1)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.info_outline_rounded, color: DesignTokens.secondary, size: 14),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "Your UID is essential for direct asset injection into your personal game vault cluster.",
                    style: GoogleFonts.outfit(
                      color: DesignTokens.textSecondary,
                      fontSize: 11,
                      height: 1.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onProceed(BuildContext context) async {
    await CommonOnTap.openUrl();
    await Future.delayed(const Duration(milliseconds: 400));
    if (!context.mounted) return;
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => RankedScreen(model: model)));
  }
}



