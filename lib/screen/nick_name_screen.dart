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
          // Tactical Background
          _buildTacticalGrid(),

          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // Cyber Header
              CyberSliverAppBar(
                title: "DNA Sequence",
                expandedHeight: 200,
                accentColor: DesignTokens.primary,
                backgroundExtras: [
                  Positioned(
                    right: -20,
                    top: 40,
                    child: Opacity(
                      opacity: 0.1,
                      child: Icon(Icons.biotech_rounded, size: 180, color: DesignTokens.primary),
                    ),
                  ),
                ],
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  child: Column(
                    children: [
                      // Large Holographic character display
                      _buildCharacterHologram(),
                      
                      const SizedBox(height: 56),

                      // Radical Terminal Input
                      _buildNeuralInput(context),

                      const SizedBox(height: 40),

                      // Verification Details
                      _buildProtocolStatus(),

                      const SizedBox(height: 48),
                      
                      if (RemoteConfigService.isAdsShow) ...[
                        const NativeAdsScreen(),
                        const SizedBox(height: 32),
                      ],

                      // Execution Action
                      GradientButton(
                        text: "AUTHORIZE UPLINK",
                        icon: Icons.fingerprint_rounded,
                        onPressed: () => _onProceed(context),
                        color: DesignTokens.primary,
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

  Widget _buildTacticalGrid() {
    return Positioned.fill(
      child: Opacity(
        opacity: 0.03,
        child: CustomPaint(
          painter: _HolographicGridPainter(),
        ),
      ),
    );
  }

  Widget _buildCharacterHologram() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            // Holographic Rings
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: DesignTokens.primary.withOpacity(0.1), width: 1),
              ),
            ),
            Container(
              width: 170,
              height: 170,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: DesignTokens.primary.withOpacity(0.05), width: 1),
              ),
            ),
            // The Character
            GlowContainer(
              glowColor: DesignTokens.primary,
              blurRadius: 40,
              child: Hero(
                tag: 'character_${model.title}',
                child: model.image != null 
                    ? Image.asset(model.image!, height: 180, fit: BoxFit.contain)
                    : const Icon(Icons.person_rounded, size: 100, color: DesignTokens.primary),
              ),
            ),
            // Scan lines overlaying the character
            Positioned(
              top: 40,
              child: Container(
                width: 150,
                height: 2,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(color: DesignTokens.primary.withOpacity(0.3), blurRadius: 10, spreadRadius: 1)
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text(
          model.title.toUpperCase(),
          style: GoogleFonts.outfit(
            fontSize: 28,
            fontWeight: FontWeight.w900,
            color: DesignTokens.textPrimary,
            letterSpacing: 2,
          ),
        ),
        Text(
          "SUBJECT_ID: ALPHA-SYNC",
          style: GoogleFonts.outfit(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: DesignTokens.primary,
            letterSpacing: 4,
          ),
        ),
      ],
    );
  }

  Widget _buildNeuralInput(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "NEURAL SIGNATURE",
          style: GoogleFonts.outfit(
            fontSize: 11,
            fontWeight: FontWeight.w900,
            color: DesignTokens.textSecondary,
            letterSpacing: 3,
          ),
        ),
        const SizedBox(height: 16),
        CustomPaint(
          painter: _TerminalInputPainter(color: DesignTokens.primary),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: TextField(
              controller: _controller,
              style: GoogleFonts.outfit(
                color: DesignTokens.textPrimary,
                fontWeight: FontWeight.w900,
                letterSpacing: 3,
                fontSize: 18,
              ),
              decoration: InputDecoration(
                hintText: "INSERT_UID_TOKEN",
                hintStyle: GoogleFonts.outfit(
                  color: DesignTokens.textSecondary.withOpacity(0.2),
                  letterSpacing: 2,
                  fontSize: 14,
                ),
                border: InputBorder.none,
                prefixIcon: const Icon(Icons.terminal_rounded, color: DesignTokens.primary, size: 20),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProtocolStatus() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: DesignTokens.surface.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: DesignTokens.primary.withOpacity(0.1)),
      ),
      child: Column(
        children: [
          _buildStatusRow("BIO_VERIFICATION", "READY", DesignTokens.primary),
          const SizedBox(height: 14),
          _buildStatusRow("UPLINK_CHANNEL", "SECURE", DesignTokens.secondary),
          const SizedBox(height: 14),
          _buildStatusRow("ENCRYPTION", "AES-256", Colors.blueGrey),
        ],
      ),
    );
  }

  Widget _buildStatusRow(String label, String status, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.outfit(
            fontSize: 10,
            fontWeight: FontWeight.w900,
            color: DesignTokens.textSecondary,
            letterSpacing: 1.5,
          ),
        ),
        Text(
          status,
          style: GoogleFonts.outfit(
            fontSize: 10,
            fontWeight: FontWeight.w900,
            color: color,
            letterSpacing: 1,
          ),
        ),
      ],
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

class _TerminalInputPainter extends CustomPainter {
  final Color color;
  _TerminalInputPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.3)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final bracketSize = 15.0;

    // Left Brackets
    canvas.drawLine(const Offset(0, 0), Offset(bracketSize, 0), paint);
    canvas.drawLine(const Offset(0, 0), Offset(0, size.height), paint);
    canvas.drawLine(Offset(0, size.height), Offset(bracketSize, size.height), paint);

    // Right Brackets
    canvas.drawLine(Offset(size.width, 0), Offset(size.width - bracketSize, 0), paint);
    canvas.drawLine(Offset(size.width, 0), Offset(size.width, size.height), paint);
    canvas.drawLine(Offset(size.width, size.height), Offset(size.width - bracketSize, size.height), paint);

    // Accent line
    final accentPaint = Paint()..color = color..style = PaintingStyle.fill;
    canvas.drawRect(Rect.fromLTWH(0, size.height / 2 - 5, 2, 10), accentPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _HolographicGridPainter extends CustomPainter {
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




