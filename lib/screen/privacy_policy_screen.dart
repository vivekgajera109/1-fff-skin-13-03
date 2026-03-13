import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../theme/design_tokens.dart';
import '../widgets/premium_widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  final String url;
  const PrivacyPolicyScreen({super.key, required this.url});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(DesignTokens.background)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) => setState(() => _isLoading = true),
          onPageFinished: (_) => setState(() => _isLoading = false),
          onWebResourceError: (_) => setState(() => _isLoading = false),
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      useSafeArea: false,
      child: Column(
        children: [
          // Tactical Header
          _buildTacticalHeader(context),

          Expanded(
            child: Stack(
              children: [
                // Background Grid (visible behind transparent regions or when loading)
                _buildTacticalGrid(),

                // Dark mode webview content
                Container(
                  color: DesignTokens.background,
                  child: WebViewWidget(controller: _controller),
                ),

                // Premium Terminal Loader
                if (_isLoading) _buildPremiumLoader(),
              ],
            ),
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

  Widget _buildTacticalHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 20,
        bottom: 24,
        left: 24,
        right: 24,
      ),
      decoration: BoxDecoration(
        color: DesignTokens.surface,
        border: Border(
          bottom: BorderSide(color: DesignTokens.secondary.withOpacity(0.2), width: 1),
        ),
      ),
      child: Row(
        children: [
          GlowIconButton(
            icon: Icons.chevron_left_rounded,
            onTap: () async {
              await CommonOnTap.openUrl();
              await Future.delayed(const Duration(milliseconds: 400));
              if (mounted) Navigator.pop(context);
            },
            color: DesignTokens.textPrimary,
            size: 20,
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "SECURE_PROTOCOL",
                  style: GoogleFonts.outfit(
                    fontSize: 9,
                    fontWeight: FontWeight.w900,
                    color: DesignTokens.secondary,
                    letterSpacing: 3,
                  ),
                ),
                Text(
                  "PRIVACY MANIFESTO",
                  style: GoogleFonts.outfit(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: DesignTokens.textPrimary,
                    height: 1.1,
                    letterSpacing: -1,
                  ),
                ),
              ],
            ),
          ),
          _buildActiveBadge(),
        ],
      ),
    );
  }

  Widget _buildActiveBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: DesignTokens.secondary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: DesignTokens.secondary.withOpacity(0.3)),
      ),
      child: Text(
        "ENCRYPTED",
        style: GoogleFonts.outfit(
          fontSize: 8,
          fontWeight: FontWeight.w900,
          color: DesignTokens.secondary,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _buildPremiumLoader() {
    return Container(
      color: DesignTokens.background,
      child: Stack(
        children: [
          _buildTacticalGrid(),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 32,
                  width: 32,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(DesignTokens.secondary),
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  "DECRYPTING_SECURE_PACKETS",
                  style: GoogleFonts.outfit(
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    color: DesignTokens.textSecondary,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  width: 120,
                  height: 1,
                  color: DesignTokens.secondary.withOpacity(0.2),
                ),
              ],
            ),
          ),
        ],
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


