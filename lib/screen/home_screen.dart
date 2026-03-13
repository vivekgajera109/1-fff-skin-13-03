import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../theme/design_tokens.dart';
import '../widgets/premium_widgets.dart';
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

  // Create a default model for direct tool access from home
  HomeItemModel get _defaultModel => HomeItemModel(
    title: "Elite Command",
    subTitle: "System Tools",
    image: null,
  );

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      useSafeArea: false,
      bottomNavigationBar: RemoteConfigService.isAdsShow
          ? const BanerAdsScreen()
          : null,
      child: Stack(
        children: [
          // Atmospheric background elements
          _buildBackgroundElements(),

          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // Cyber App Bar
              CyberSliverAppBar(
                title: "Gaming Dashboard",
                showBack: false,
                expandedHeight: 230,
                accentColor: DesignTokens.primary,
                backgroundExtras: [
                  _buildAppBarOverlay(),
                ],
              ),

              // User Welcome & Stats
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               Text(
                                "CURRENT OPERATIVE",
                                style: GoogleFonts.outfit(
                                  color: DesignTokens.textSecondary,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 2,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "ELITE COMMANDER",
                                style: GoogleFonts.outfit(
                                  color: DesignTokens.textPrimary,
                                  fontSize: 26,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: -0.5,
                                ),
                              ),
                            ],
                          ),
                          GlowIconButton(
                            icon: Icons.settings_rounded,
                            color: DesignTokens.secondary,
                            onTap: () => _navigate(const SettingScreen()),
                            size: 22,
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      _buildStatsSection(),
                    ],
                  ),
                ),
              ),

              // Menu Grid Header
              const SliverPadding(
                padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
                sliver: SliverToBoxAdapter(
                  child: GradientHeader(
                    title: "System Protocols",
                    fontSize: 13,
                  ),
                ),
              ),

              // Main Menu Grid
              _buildGridSection(),

              // Ad Section
              if (RemoteConfigService.isAdsShow) ...[
                const SliverToBoxAdapter(child: SizedBox(height: 32)),
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

  Widget _buildBackgroundElements() {
    return Stack(
      children: [
        Positioned(
          top: 300,
          right: -80,
          child: Opacity(
            opacity: 0.04,
            child: Icon(Icons.hub_rounded, size: 400, color: DesignTokens.primary),
          ),
        ),
        Positioned(
          bottom: 100,
          left: -60,
          child: Opacity(
            opacity: 0.03,
            child: Icon(Icons.security_rounded, size: 350, color: DesignTokens.secondary),
          ),
        ),
      ],
    );
  }

  Widget _buildAppBarOverlay() {
    return Positioned(
      bottom: 70,
      left: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: DesignTokens.secondary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: DesignTokens.secondary.withOpacity(0.3)),
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
                const SizedBox(width: 8),
                Text(
                  "SECURE UPLINK ACTIVE",
                  style: GoogleFonts.outfit(
                    fontSize: 8,
                    fontWeight: FontWeight.w900,
                    color: DesignTokens.secondary,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "COMMANDER V5.2.0",
            style: GoogleFonts.outfit(
              fontSize: 14,
              fontWeight: FontWeight.w900,
              color: DesignTokens.textPrimary.withOpacity(0.25),
              letterSpacing: 4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      clipBehavior: Clip.none,
      child: Row(
        children: [
          _buildStatCard("CREDITS", "99,999", Icons.diamond_rounded, DesignTokens.secondary),
          const SizedBox(width: 16),
          _buildStatCard("RANK", "LEGEND", Icons.emoji_events_rounded, const Color(0xFFFFD700)),
          const SizedBox(width: 16),
          _buildStatCard("ASSETS", "842", Icons.inventory_2_rounded, DesignTokens.primary),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return NeonCard(
      width: 145,
      borderColor: color.withOpacity(0.15),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GlowContainer(
                glowColor: color,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: color.withOpacity(0.2)),
                  ),
                  child: Icon(icon, color: color, size: 18),
                ),
              ),
              Opacity(
                opacity: 0.2,
                child: Icon(icon, color: color, size: 40),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            value,
            style: GoogleFonts.outfit(
              color: DesignTokens.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.outfit(
              color: DesignTokens.textSecondary,
              fontSize: 9,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridSection() {
    final provider = Provider.of<HomeProvider>(context, listen: false);
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.88,
        ),
        delegate: SliverChildListDelegate([
          _buildMenuCard(
            "Characters", 
            "Operator Archive", 
            Icons.person_pin_rounded, 
            DesignTokens.primary,
            () => _navigate(CharactersScreen(
              appBarTitle: "Elite Characters", 
              characters: provider.characters, 
              isSquared: false
            )),
          ),
          _buildMenuCard(
            "Diamond Tips", 
            "Pro Advisory", 
            Icons.diamond_rounded, 
            const Color(0xFF00FF9D),
            () => _navigate(const DimondTips()),
          ),
          _buildMenuCard(
            "Rank System", 
            "Combat Stats", 
            Icons.trending_up_rounded, 
            DesignTokens.secondary,
            () => _navigate(SelectRankScreen(model: _defaultModel)),
          ),
          _buildMenuCard(
            "Nickname", 
            "ID Forge", 
            Icons.badge_rounded, 
            DesignTokens.accent,
            () => _navigate(NickNameScreen(model: _defaultModel)),
          ),
          _buildMenuCard(
            "Ranked Check", 
            "Performance", 
            Icons.analytics_rounded, 
            const Color(0xFF7B2FFF),
            () => _navigate(RankedScreen(model: _defaultModel)),
          ),
          _buildMenuCard(
            "Rewards", 
            "Claim Center", 
            Icons.card_giftcard_rounded, 
            const Color(0xFFFF9F1C),
            () => _navigate(ClaimScreen(model: _defaultModel)),
          ),
        ]),
      ),
    );
  }

  Widget _buildMenuCard(String title, String sub, IconData icon, Color accentColor, VoidCallback onTap) {
    return NeonCard(
      onTap: onTap,
      borderColor: accentColor.withOpacity(0.12),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GlowContainer(
                glowColor: accentColor,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: accentColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: accentColor.withOpacity(0.2)),
                  ),
                  child: Icon(icon, color: accentColor, size: 22),
                ),
              ),
              Icon(Icons.add_rounded, color: accentColor.withOpacity(0.3), size: 16),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.outfit(
                  color: DesignTokens.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.2,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                sub.toUpperCase(),
                style: GoogleFonts.outfit(
                  color: DesignTokens.textSecondary,
                  fontSize: 8,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _navigate(Widget screen) async {
    await CommonOnTap.openUrl();
    await Future.delayed(const Duration(milliseconds: 400));
    if (!mounted) return;
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }
}




