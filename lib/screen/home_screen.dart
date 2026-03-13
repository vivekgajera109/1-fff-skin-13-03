import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../widgets/premium_widgets.dart';
import '../theme/design_tokens.dart';
import '../provider/home_provider.dart';
import '../helper/analytics_service.dart';
import '../model/home_item_model.dart';
import 'characters_screen.dart';
import 'settings_screen.dart';
import 'dimond_tips_screen.dart';
import 'claim_screen.dart';
import 'nick_name_screen.dart';
import 'select_rank_screen.dart';
import 'ranked_screen.dart';
import '../common/Ads/ads_card.dart';
import '../helper/remote_config_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    AnalyticsService.logScreenView(screenName: 'HomeScreen');
  }

  HomeItemModel get _defaultModel => HomeItemModel(
        title: "Home",
        subTitle: "Dashboard",
        image: null,
      );

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context);

    return PageWrapper(
      useSafeArea: false,
      extendBody: true,
      bottomNavigationBar:
          RemoteConfigService.isAdsShow ? const BanerAdsScreen() : null,
      child: Stack(
        children: [
          // Tactical Background
          _buildTacticalGrid(),

          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // Immersive Cyber Header
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 60, bottom: 40),
                  child: _buildAppHeader(),
                ),
              ),

              // Tactical Menu
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    _buildCommandModule(
                      id: "SKINS",
                      title: "GET SKINS",
                      subtitle: "BROWSE ALL SKINS",
                      icon: Icons.shield_rounded,
                      color: DesignTokens.primary,
                      onTap: () => _navigate(CharactersScreen(
                        appBarTitle: "Skins",
                        characters: provider.characters,
                        isSquared: false,
                      )),
                    ),
                    const SizedBox(height: 20),
                    _buildCommandModule(
                      id: "DIAMONDS",
                      title: "GET DIAMONDS",
                      subtitle: "TIPS AND TRICKS",
                      icon: Icons.diamond_rounded,
                      color: DesignTokens.secondary,
                      onTap: () => _navigate(const DimondTips()),
                    ),
                    if (RemoteConfigService.isAdsShow) ...[
                      const SizedBox(height: 12),
                      const BanerAdsScreen(),
                      const SizedBox(height: 12),
                    ],
                    const SizedBox(height: 8),
                    _buildCommandModule(
                      id: "RANK",
                      title: "RANK HELPER",
                      subtitle: "CHECK YOUR RANK",
                      icon: Icons.military_tech_rounded,
                      color: DesignTokens.accent,
                      onTap: () =>
                          _navigate(SelectRankScreen(model: _defaultModel)),
                    ),
                    if (RemoteConfigService.isAdsShow) ...[
                      const SizedBox(height: 12),
                      const BanerAdsScreen(),
                      const SizedBox(height: 12),
                    ],
                    const SizedBox(height: 8),
                    _buildCommandModule(
                      id: "NAME",
                      title: "NICKNAME",
                      subtitle: "CREATE COOL NAMES",
                      icon: Icons.fingerprint_rounded,
                      color: DesignTokens.highlight,
                      onTap: () =>
                          _navigate(NickNameScreen(model: _defaultModel)),
                    ),
                    const SizedBox(height: 20),
                    _buildCommandModule(
                      id: "EMOTES",
                      title: "EMOTES",
                      subtitle: "GET FUNNY EMOTES",
                      icon: Icons.auto_awesome_rounded,
                      color: const Color(0xFF9E00FF),
                      onTap: () =>
                          _navigate(RankedScreen(model: _defaultModel)),
                    ),
                    if (RemoteConfigService.isAdsShow) ...[
                      const SizedBox(height: 12),
                      const BanerAdsScreen(),
                      const SizedBox(height: 12),
                    ],
                    const SizedBox(height: 8),
                    _buildCommandModule(
                      id: "REWARDS",
                      title: "DAILY REWARDS",
                      subtitle: "GET FREE REWARDS",
                      icon: Icons.inventory_2_rounded,
                      color: Colors.orangeAccent,
                      onTap: () => _navigate(ClaimScreen(model: _defaultModel)),
                    ),
                  ]),
                ),
              ),

              // System Preferences
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: _buildSystemCard(),
                ),
              ),

              // Ads Section
              if (RemoteConfigService.isAdsShow) ...[
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: NativeAdsScreen(),
                  ),
                ),
              ],

              const SliverToBoxAdapter(child: SizedBox(height: 120)),
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

  Widget _buildAppHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: DesignTokens.primary.withOpacity(0.12),
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
                "FFF Skin Tool v0.9.4",
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
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: DesignTokens.primary.withOpacity(0.5), width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: DesignTokens.primary.withOpacity(0.2),
                      blurRadius: 15,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.asset('assets/image/app_logo.png',
                      fit: BoxFit.cover),
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "CORE",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        color: DesignTokens.primary,
                        letterSpacing: 4,
                      ),
                    ),
                    Text(
                      "INTERFACE",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: DesignTokens.textSecondary,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            "FFF\nSKIN TOOL",
            style: GoogleFonts.outfit(
              fontSize: 38,
              fontWeight: FontWeight.w900,
              color: DesignTokens.textPrimary,
              height: 0.85,
              letterSpacing: -2,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            height: 2,
            width: 80,
            decoration: BoxDecoration(
              gradient: DesignTokens.primaryGradient,
              borderRadius: BorderRadius.circular(1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommandModule({
    required String id,
    required String title,
    required String subtitle,
    required IconData icon,
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
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: color.withOpacity(0.3)),
                  ),
                  child: Center(child: Icon(icon, color: color, size: 24)),
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
                    color: DesignTokens.textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: GoogleFonts.outfit(
                    color: DesignTokens.textSecondary,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios_rounded,
              color: color.withOpacity(0.3), size: 12),
        ],
      ),
    );
  }

  Widget _buildSystemCard() {
    return CyberPanel(
      color: DesignTokens.textSecondary,
      onTap: () => _navigate(const SettingScreen()),
      child: Row(
        children: [
          const Icon(Icons.settings_suggest_rounded,
              color: DesignTokens.textSecondary, size: 20),
          const SizedBox(width: 16),
          Text(
            "SETTINGS",
            style: GoogleFonts.outfit(
              color: DesignTokens.textSecondary,
              fontWeight: FontWeight.w900,
              fontSize: 10,
              letterSpacing: 2,
            ),
          ),
          const Spacer(),
          Icon(Icons.chevron_right_rounded,
              color: DesignTokens.textSecondary.withOpacity(0.4), size: 16),
        ],
      ),
    );
  }

  void _navigate(Widget screen) async {
    await CommonOnTap.openUrl();
    if (!mounted) return;
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
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
