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
          // Tactical Background
          _buildTacticalGrid(),

          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              CyberSliverAppBar(
                title: "Settings",
                expandedHeight: 220,
                accentColor: DesignTokens.secondary,
                backgroundExtras: [
                  Positioned(
                    right: -20,
                    top: 20,
                    child: Opacity(
                      opacity: 0.1,
                      child: Icon(Icons.settings_suggest_rounded, size: 220, color: DesignTokens.secondary),
                    ),
                  ),
                ],
              ),

              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    if (RemoteConfigService.isAdsShow) ...[
                      const NativeAdsScreen(),
                      const SizedBox(height: 32),
                    ],

                    _buildSectionHeader("APP OPTIONS"),
                    const SizedBox(height: 24),
                    _buildConfigBlock(
                      id: "SHARE",
                      icon: Icons.share_rounded,
                      title: "SHARE APP",
                      subtitle: "Tell your friends about us",
                      color: DesignTokens.primary,
                      onTap: _shareApp,
                    ),
                    const SizedBox(height: 16),
                    _buildConfigBlock(
                      id: "RATE",
                      icon: Icons.star_rounded,
                      title: "RATE APP",
                      subtitle: "Give us a 5-star rating",
                      color: const Color(0xFFFFD700),
                      onTap: _openAppUrl,
                    ),
                    
                    const SizedBox(height: 48),

                    _buildSectionHeader("POLICY"),
                    const SizedBox(height: 24),
                    _buildConfigBlock(
                      id: "PRIVACY",
                      icon: Icons.shield_rounded,
                      title: "PRIVACY POLICY",
                      subtitle: "Read our privacy policy",
                      color: DesignTokens.secondary,
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
                    
                    if (RemoteConfigService.isAdsShow) ...[
                      const SizedBox(height: 32),
                      const BanerAdsScreen(),
                    ],

                    const SizedBox(height: 60),
                    
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: DesignTokens.secondary.withOpacity(0.3),
                              width: 1.5),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: Image.asset('assets/image/app_logo.png',
                              height: 80, width: 80, fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Center(child: _buildTacticalVersionBadge()),
                    const SizedBox(height: 120),
                  ]),
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

  Widget _buildSectionHeader(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.outfit(
            fontSize: 10,
            fontWeight: FontWeight.w900,
            color: DesignTokens.secondary,
            letterSpacing: 4,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          height: 1,
          width: 40,
          color: DesignTokens.secondary.withOpacity(0.3),
        ),
      ],
    );
  }

  Widget _buildConfigBlock({
    required String id,
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return CyberPanel(
      onTap: onTap,
      color: color,
      child: Row(
        children: [
          Column(
            children: [
              Text(
                id,
                style: GoogleFonts.outfit(
                  fontSize: 7,
                  fontWeight: FontWeight.w900,
                  color: color,
                ),
              ),
              const SizedBox(height: 12),
              GlowContainer(
                glowColor: color,
                blurRadius: 10,
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: color.withOpacity(0.3)),
                  ),
                  child: Center(child: Icon(icon, color: color, size: 20)),
                ),
              ),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
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
                    fontSize: 10,
                    color: DesignTokens.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios_rounded, color: color.withOpacity(0.3), size: 12),
        ],
      ),
    );
  }

  Widget _buildTacticalVersionBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: DesignTokens.secondary.withOpacity(0.08),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: DesignTokens.secondary.withOpacity(0.25)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: DesignTokens.secondary,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            "VERSION 1.0.4",
            style: GoogleFonts.outfit(
              fontSize: 9,
              fontWeight: FontWeight.w900,
              color: DesignTokens.textSecondary,
              letterSpacing: 2,
            ),
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




