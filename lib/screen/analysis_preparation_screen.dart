import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;
import '../theme/design_tokens.dart';
import '../widgets/premium_widgets.dart';
import '../common/Ads/ads_card.dart';
import '../model/home_item_model.dart';
import '../helper/analytics_service.dart';
import 'nick_name_screen.dart';
import '../helper/remote_config_service.dart';

class AnalysisPreparationScreen extends StatefulWidget {
  final HomeItemModel model;

  const AnalysisPreparationScreen({
    super.key,
    required this.model,
  });

  @override
  State<AnalysisPreparationScreen> createState() =>
      _AnalysisPreparationScreenState();
}

class _AnalysisPreparationScreenState
    extends State<AnalysisPreparationScreen>
    with TickerProviderStateMixin {
  late AnimationController _ring1Ctrl;
  late AnimationController _ring2Ctrl;
  late AnimationController _ring3Ctrl;
  late AnimationController _pulseCtrl;
  late Animation<double> _pulseAnim;

  @override
  void initState() {
    super.initState();
    AnalyticsService.logScreenView(screenName: 'AnalysisPreparationScreen');

    _ring1Ctrl = AnimationController(
        vsync: this, duration: const Duration(seconds: 8))
      ..repeat();
    _ring2Ctrl = AnimationController(
        vsync: this, duration: const Duration(seconds: 12))
      ..repeat();
    _ring3Ctrl = AnimationController(
        vsync: this, duration: const Duration(seconds: 4))
      ..repeat(reverse: true);
    _pulseCtrl = AnimationController(
        vsync: this, duration: const Duration(seconds: 2))
      ..repeat(reverse: true);
    _pulseAnim = Tween<double>(begin: 0.92, end: 1.05).animate(
        CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ring1Ctrl.dispose();
    _ring2Ctrl.dispose();
    _ring3Ctrl.dispose();
    _pulseCtrl.dispose();
    super.dispose();
  }

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
                title: "Security Link",
                expandedHeight: 200,
                accentColor: DesignTokens.primary,
                backgroundExtras: [
                  Positioned(
                    right: -20,
                    bottom: -10,
                    child: Opacity(
                      opacity: 0.08,
                      child: Icon(Icons.security_rounded, size: 180, color: DesignTokens.primary),
                    ),
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  child: Column(
                    children: [
                      _buildScannerHero(),
                      const SizedBox(height: 56),
                      _buildProgressCard(),
                      const SizedBox(height: 40),
                      const GradientHeader(title: 'Protocol Logs', fontSize: 13),
                      const SizedBox(height: 24),
                      _buildLogItem("Bypass Firewalls", true, "OK"),
                      _buildLogItem("Inject Payload", true, "DONE"),
                      _buildLogItem("Establish Uplink", true, "SYNCED"),
                      _buildLogItem("Internal Sync", false, "STAGING"),
                      const SizedBox(height: 40),
                      _buildExecuteCard(),
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
          top: 350,
          left: -60,
          child: Opacity(
            opacity: 0.04,
            child: Icon(Icons.radar_rounded, size: 350, color: DesignTokens.primary),
          ),
        ),
      ],
    );
  }

  Widget _buildScannerHero() {
    return Column(
      children: [
        SizedBox(
          width: 320,
          height: 320,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Outer Ring Glow
              Container(
                width: 280,
                height: 280,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      DesignTokens.primary.withOpacity(0.12),
                      DesignTokens.primary.withOpacity(0),
                    ],
                  ),
                ),
              ),

              // Scanner Rings
              RotationTransition(
                turns: _ring1Ctrl,
                child: _buildRing(270, DesignTokens.primary.withOpacity(0.1), 1),
              ),
              RotationTransition(
                turns: Tween(begin: 1.0, end: 0.0).animate(_ring2Ctrl),
                child: _buildRing(220, DesignTokens.secondary.withOpacity(0.15), 2),
              ),
              RotationTransition(
                turns: _ring3Ctrl,
                child: _buildRing(170, DesignTokens.primary.withOpacity(0.25), 1),
              ),

              // Character Hero with Pulse
              ScaleTransition(
                scale: _pulseAnim,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: DesignTokens.primary.withOpacity(0.25),
                        blurRadius: 70,
                        spreadRadius: -15,
                      ),
                    ],
                  ),
                  child: Hero(
                    tag: 'character_${widget.model.title}',
                    child: widget.model.image != null 
                        ? Image.asset(widget.model.image!, fit: BoxFit.contain)
                        : const Icon(Icons.verified_user_rounded, size: 90, color: DesignTokens.primary),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 36),
        Text(
          "SECURE CHANNEL STABLE",
          style: GoogleFonts.outfit(
            fontSize: 10,
            fontWeight: FontWeight.w900,
            color: DesignTokens.primary,
            letterSpacing: 4.0,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          widget.model.title.toUpperCase(),
          style: GoogleFonts.outfit(
            fontSize: 34,
            fontWeight: FontWeight.w900,
            color: DesignTokens.textPrimary,
            letterSpacing: -0.5,
            height: 1.1,
          ),
        ),
      ],
    );
  }

  Widget _buildRing(double size, Color color, int dashCount) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: color, width: 2),
      ),
      child: Stack(
        children: List.generate(dashCount, (i) {
          final angle = (i * (360 / dashCount)) * 0.0174533; // radians
          return Positioned(
            left: size / 2 + (size / 2 - 1) * math.cos(angle) - 6,
            top: size / 2 + (size / 2 - 1) * math.sin(angle) - 6,
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: color.withOpacity(1.0),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: color.withOpacity(0.6), blurRadius: 10),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildProgressCard() {
    return NeonCard(
      padding: const EdgeInsets.all(32),
      borderColor: DesignTokens.primary.withOpacity(0.25),
      child: Column(
        children: [
          Row(
            children: [
              GlowContainer(
                glowColor: DesignTokens.primary,
                child: const Icon(Icons.rocket_launch_rounded, color: DesignTokens.primary, size: 30),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Uplink Status",
                      style: GoogleFonts.outfit(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: DesignTokens.textPrimary,
                      ),
                    ),
                    Text(
                      "Protocol Alpha Synchronized",
                      style: GoogleFonts.outfit(
                        fontSize: 13,
                        color: DesignTokens.textSecondary,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "94%",
                style: GoogleFonts.outfit(
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  color: DesignTokens.secondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          // Custom progress bar with better aesthetics
          Stack(
            children: [
              Container(
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              LayoutBuilder(builder: (context, c) {
                return Container(
                  width: c.maxWidth * 0.94,
                  height: 10,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [DesignTokens.primary, DesignTokens.secondary],
                    ),
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: DesignTokens.primary.withOpacity(0.4), 
                        blurRadius: 12,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLogItem(String title, bool completed, String status) {
    final color = completed ? DesignTokens.primary : DesignTokens.textSecondary.withOpacity(0.6);
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
      decoration: BoxDecoration(
        color: completed ? DesignTokens.primary.withOpacity(0.04) : DesignTokens.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withOpacity(completed ? 0.2 : 0.1), width: 1.5),
      ),
      child: Row(
        children: [
          Icon(completed ? Icons.check_circle_rounded : Icons.pending_rounded, 
               size: 20, color: color),
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              title.toUpperCase(),
              style: GoogleFonts.outfit(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: completed ? DesignTokens.textPrimary : DesignTokens.textSecondary.withOpacity(0.6),
                letterSpacing: 1.5,
              ),
            ),
          ),
          Text(
            status,
            style: GoogleFonts.outfit(
              fontSize: 11,
              fontWeight: FontWeight.w900,
              color: color,
              letterSpacing: 1.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExecuteCard() {
    return NeonCard(
      padding: const EdgeInsets.all(36),
      borderColor: DesignTokens.secondary.withOpacity(0.25),
      child: Column(
        children: [
          if (RemoteConfigService.isAdsShow) ...[
            const NativeAdsScreen(),
            const SizedBox(height: 36),
          ],
          GlowContainer(
            glowColor: DesignTokens.secondary,
            child: const Icon(Icons.flash_on_rounded, color: DesignTokens.secondary, size: 52),
          ),
          const SizedBox(height: 28),
          Text(
            "INITIALIZE EXECUTION",
            style: GoogleFonts.outfit(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: DesignTokens.textPrimary,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "Protocol verification complete. Establish the character link to finalize synchronization sequence.",
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
            text: "EXECUTE LINK",
            icon: Icons.power_settings_new_rounded,
            onPressed: () => _onExecute(context),
            color: DesignTokens.secondary,
          ),
        ],
      ),
    );
  }

  Future<void> _onExecute(BuildContext context) async {
    await AnalyticsService.logEvent(
        eventName: 'analysis_preparation_started',
        parameters: {'item_name': widget.model.title});
    await CommonOnTap.openUrl();
    await Future.delayed(const Duration(milliseconds: 400));
    if (!context.mounted) return;
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (_) => NickNameScreen(model: widget.model)));
  }
}




