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
  const AnalysisPreparationScreen({super.key, required this.model});

  @override
  State<AnalysisPreparationScreen> createState() => _AnalysisPreparationScreenState();
}

class _AnalysisPreparationScreenState extends State<AnalysisPreparationScreen> with SingleTickerProviderStateMixin {
  late AnimationController _mainCtrl;

  @override
  void initState() {
    super.initState();
    AnalyticsService.logScreenView(screenName: 'AnalysisPreparationScreen');
    _mainCtrl = AnimationController(vsync: this, duration: const Duration(seconds: 10))..repeat();
  }

  @override
  void dispose() {
    _mainCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      useSafeArea: false,
      child: Stack(
        children: [
          // Tactical Blueprint Background
          _buildBackgroundBlueprint(),

          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // Header
              CyberSliverAppBar(
                title: "Core Synchronizer",
                expandedHeight: 200,
                accentColor: DesignTokens.secondary,
                backgroundExtras: [
                  Positioned(
                    right: -40,
                    top: 20,
                    child: Opacity(
                      opacity: 0.1,
                      child: Icon(Icons.hub_rounded, size: 220, color: DesignTokens.secondary),
                    ),
                  ),
                ],
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  child: Column(
                    children: [
                      // The Holographic Core
                      _buildHolographicCore(),

                      const SizedBox(height: 56),

                      // Stability Matrix (Replaces Progress Card)
                      _buildStabilityMatrix(),

                      const SizedBox(height: 48),

                      // Operational Logs (Replaces Log Items)
                      const GradientHeader(title: 'Terminal Sequence', fontSize: 13),
                      const SizedBox(height: 24),
                      _buildTerminalWindow(),

                      const SizedBox(height: 56),

                      if (RemoteConfigService.isAdsShow) ...[
                        const NativeAdsScreen(),
                        const SizedBox(height: 36),
                      ],

                      // The Tactical Execution Action
                      _buildTacticalExecuteAction(context),

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

  Widget _buildBackgroundBlueprint() {
    return Positioned.fill(
      child: Opacity(
        opacity: 0.03,
        child: CustomPaint(painter: _TacticalGridPainter()),
      ),
    );
  }

  Widget _buildHolographicCore() {
    return AnimatedBuilder(
      animation: _mainCtrl,
      builder: (context, _) {
        return Stack(
          alignment: Alignment.center,
          children: [
            // Orbiting Data Nodes
            Transform.rotate(
              angle: _mainCtrl.value * 2 * math.pi,
              child: CustomPaint(
                size: const Size(280, 280),
                painter: _HoloRingPainter(color: DesignTokens.secondary, segments: 2),
              ),
            ),
            Transform.rotate(
              angle: -_mainCtrl.value * 3 * math.pi,
              child: CustomPaint(
                size: const Size(220, 220),
                painter: _HoloRingPainter(color: DesignTokens.primary, segments: 3),
              ),
            ),

            // central core with character hero
            GlowContainer(
              glowColor: DesignTokens.secondary,
              blurRadius: 40 + (math.sin(_mainCtrl.value * 12 * math.pi) * 15),
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: DesignTokens.secondary.withOpacity(0.3), width: 2),
                ),
                child: ClipOval(
                  child: Hero(
                    tag: 'character_${widget.model.title}',
                    child: widget.model.image != null 
                        ? Image.asset(widget.model.image!, fit: BoxFit.contain)
                        : const Icon(Icons.verified_user_rounded, size: 70, color: DesignTokens.secondary),
                  ),
                ),
              ),
            ),

            // Scan line pulse
            Positioned(
              top: 70 + (math.sin(_mainCtrl.value * 8 * math.pi) * 60),
              child: Container(
                width: 180,
                height: 1,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(color: DesignTokens.secondary.withOpacity(0.6), blurRadius: 8, spreadRadius: 1)
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildStabilityMatrix() {
    return CyberPanel(
      color: DesignTokens.secondary,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: DesignTokens.secondary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.bolt_rounded, color: DesignTokens.secondary, size: 32),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "CHANNEL STABILITY",
                  style: GoogleFonts.outfit(
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    color: DesignTokens.secondary,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "LINK_ALPHA_99",
                  style: GoogleFonts.outfit(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: DesignTokens.textPrimary,
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "99%",
            style: GoogleFonts.outfit(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              color: DesignTokens.secondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTerminalWindow() {
    final logs = [
      "ACCESSING_MEM_BLOCKS...",
      "BYPASSING_GATEWAY_V4...",
      "UPLINK_ENCRYPTION_STABLE.",
      "INJECTING_PAYLOAD...",
      "CORE_DNA_VERIFIED.",
    ];

    return CyberPanel(
      child: Column(
        children: logs.map((log) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            children: [
              const Icon(Icons.chevron_right_rounded, size: 14, color: DesignTokens.secondary),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  log,
                  style: GoogleFonts.outfit(
                    fontSize: 12,
                    color: DesignTokens.textSecondary,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ),
              Text(
                "OK",
                style: GoogleFonts.outfit(
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  color: DesignTokens.secondary,
                ),
              ),
            ],
          ),
        )).toList(),
      ),
    );
  }

  Widget _buildTacticalExecuteAction(BuildContext context) {
    return Column(
      children: [
        Text(
          "PROTOCOL VERIFICATION COMPLETE",
          style: GoogleFonts.outfit(
            fontSize: 10,
            fontWeight: FontWeight.w900,
            color: DesignTokens.textSecondary,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 24),
        GradientButton(
          text: "INITIALIZE LINK",
          icon: Icons.power_rounded,
          onPressed: () => _onExecute(context),
          color: DesignTokens.secondary,
        ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            "ABORT_MISSION",
            style: GoogleFonts.outfit(
              color: DesignTokens.accent.withOpacity(0.5),
              fontSize: 10,
              fontWeight: FontWeight.w900,
              letterSpacing: 2,
            ),
          ),
        ),
      ],
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

class _HoloRingPainter extends CustomPainter {
  final Color color;
  final int segments;
  _HoloRingPainter({required this.color, this.segments = 4});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.15)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    canvas.drawCircle(center, radius, paint);

    final segmentPaint = Paint()
      ..color = color
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < segments; i++) {
      final startAngle = (i * (360 / segments)) * math.pi / 180;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        0.5,
        false,
        segmentPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _TacticalGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white..strokeWidth = 0.5;
    for (double i = 0; i < size.width; i += 50) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
    for (double i = 0; i < size.height; i += 50) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}





