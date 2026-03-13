import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../theme/design_tokens.dart';
import '../widgets/premium_widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  final String url;

  const PrivacyPolicyScreen({
    super.key,
    required this.url,
  });

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
          onPageStarted: (_) {
            if (mounted) {
              setState(() => _isLoading = true);
            }
          },
          onPageFinished: (_) {
            if (mounted) {
              setState(() => _isLoading = false);
            }
          },
          onWebResourceError: (_) {
            if (mounted) {
              setState(() => _isLoading = false);
            }
          },
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

  Widget _buildTacticalHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 16,
        bottom: 20,
        left: 20,
        right: 20,
      ),
      decoration: BoxDecoration(
        color: DesignTokens.surface,
        border: Border(
          bottom: BorderSide(
            color: DesignTokens.primary.withOpacity(0.15),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          GlowIconButton(
            icon: Icons.chevron_left_rounded,
            onTap: () async {
              await CommonOnTap.openUrl();
              await Future.delayed(const Duration(milliseconds: 400));
              if (context.mounted) {
                Navigator.pop(context);
              }
            },
            color: DesignTokens.textPrimary,
            size: 20,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "PRIVACY MANIFESTO",
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: DesignTokens.textPrimary,
                    letterSpacing: 1.5,
                  ),
                ),
                Text(
                  "SECURE PROTOCOL v2.4",
                  style: GoogleFonts.outfit(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: DesignTokens.secondary,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
          const GlowContainer(
            glowColor: DesignTokens.primary,
            child: Icon(Icons.security_rounded,
                color: DesignTokens.primary, size: 28),
          ),
        ],
      ),
    );
  }

  Widget _buildPremiumLoader() {
    return Container(
      color: DesignTokens.background,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const GlowContainer(
              glowColor: DesignTokens.primary,
              child: SizedBox(
                height: 44,
                width: 44,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(DesignTokens.primary),
                ),
              ),
            ),
            const SizedBox(height: 28),
            Text(
              "ESTABLISHING SECURE UPLINK...",
              style: GoogleFonts.outfit(
                fontSize: 11,
                fontWeight: FontWeight.w900,
                color: DesignTokens.textSecondary,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: 150,
              height: 2,
              decoration: BoxDecoration(
                color: DesignTokens.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(1),
              ),
              child: LinearProgressIndicator(
                backgroundColor: Colors.transparent,
                valueColor: AlwaysStoppedAnimation<Color>(DesignTokens.primary.withOpacity(0.5)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

