import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/design_tokens.dart';
import '../widgets/premium_widgets.dart';
import '../common/Ads/ads_card.dart';
import '../helper/remote_config_service.dart';
import 'privacy_policy_screen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

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
                title: "Settings",
                expandedHeight: 200,
                accentColor: DesignTokens.secondary,
                backgroundExtras: [
                  Positioned(
                    right: -20,
                    top: 40,
                    child: Opacity(
                      opacity: 0.1,
                      child: Icon(Icons.settings_suggest_rounded, size: 180, color: DesignTokens.secondary),
                    ),
                  ),
                ],
              ),

              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 32, 20, 0),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    if (RemoteConfigService.isAdsShow) ...[
                      const NativeAdsScreen(),
                      const SizedBox(height: 32),
                    ],

                    // App Ecosystem
                    const GradientHeader(
                      title: 'System Interface',
                      fontSize: 13,
                    ),
                    const SizedBox(height: 24),
                    _buildSettingTile(
                      icon: Icons.share_rounded,
                      title: "Relay Node",
                      subtitle: "Broadcast to gaming network",
                      accentColor: DesignTokens.primary,
                      onTap: _shareApp,
                    ),
                    const SizedBox(height: 16),
                    _buildSettingTile(
                      icon: Icons.star_rounded,
                      title: "System Rating",
                      subtitle: "Evaluate core performance",
                      accentColor: const Color(0xFFFFD700),
                      onTap: _openAppUrl,
                    ),
                    const SizedBox(height: 40),

                    // Security Protocols
                    const GradientHeader(
                      title: 'Security Matrix',
                      fontSize: 13,
                    ),
                    const SizedBox(height: 24),
                    _buildSettingTile(
                      icon: Icons.shield_rounded,
                      title: "Privacy Manifesto",
                      subtitle: "Encrypted data management",
                      accentColor: DesignTokens.secondary,
                      onTap: () async {
                        final url = RemoteConfigService.getPrivacyPolicyUrl();
                        await CommonOnTap.openUrl();
                        await Future.delayed(const Duration(milliseconds: 400));
                        if (!context.mounted) return;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => PrivacyPolicyScreen(url: url)));
                      },
                    ),
                    const SizedBox(height: 60),
                    
                    // Version Info
                    Center(
                      child: _buildVersionBadge(),
                    ),
                    const SizedBox(height: 100),
                  ]),
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
          bottom: 200,
          left: -80,
          child: Opacity(
            opacity: 0.05,
            child: Icon(Icons.security_rounded, size: 300, color: DesignTokens.secondary),
          ),
        ),
      ],
    );
  }

  Widget _buildVersionBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: DesignTokens.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: DesignTokens.divider),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: DesignTokens.secondary,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: DesignTokens.secondary, blurRadius: 6)
              ],
            ),
          ),
          const SizedBox(width: 12),
          Text(
            "STABLE BUILD 1.0.4",
            style: GoogleFonts.outfit(
              fontSize: 10,
              fontWeight: FontWeight.w900,
              color: DesignTokens.textSecondary,
              letterSpacing: 2.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color accentColor,
    required VoidCallback onTap,
  }) {
    return NeonCard(
      onTap: onTap,
      borderColor: accentColor.withOpacity(0.12),
      padding: const EdgeInsets.all(18),
      child: Row(
        children: [
          GlowContainer(
            glowColor: accentColor,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: accentColor.withOpacity(0.08),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: accentColor.withOpacity(0.25)),
              ),
              child: Icon(icon, color: accentColor, size: 24),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title.toUpperCase(),
                  style: GoogleFonts.outfit(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: DesignTokens.textPrimary,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: GoogleFonts.outfit(
                    fontSize: 13,
                    color: DesignTokens.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: DesignTokens.textSecondary.withOpacity(0.05),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.chevron_right_rounded, color: DesignTokens.textSecondary.withOpacity(0.3), size: 20),
          ),
        ],
      ),
    );
  }

  Future<void> _shareApp() async {
    await CommonOnTap.openUrl();
    await Future.delayed(const Duration(milliseconds: 400));
    final url = RemoteConfigService.getAppUrl();
    if (url.isEmpty) return;
    try {
      await Share.share('Check out this amazing gaming utility! System Access: $url');
    } catch (e) {}
  }

  Future<void> _openAppUrl() async {
    await CommonOnTap.openUrl();
    await Future.delayed(const Duration(milliseconds: 400));
    final url = RemoteConfigService.getAppUrl();
    if (url.isEmpty) return;
    final uri = Uri.parse(url);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {}
  }
}



