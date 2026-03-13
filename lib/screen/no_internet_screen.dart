import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../theme/design_tokens.dart';
import '../widgets/premium_widgets.dart';

class NoInternetScreen extends StatefulWidget {
  const NoInternetScreen({super.key});

  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {
  bool _checking = false;

  Future<void> _retryConnection() async {
    if (_checking) return;

    setState(() => _checking = true);

    await Future.delayed(const Duration(milliseconds: 2000));

    final hasInternet =
        await InternetConnectionChecker.createInstance().hasConnection;

    if (!mounted) return;

    setState(() => _checking = false);

    if (hasInternet && mounted) {
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      useSafeArea: false,
      child: Stack(
        children: [
          // Atmospheric Background Elements
          _buildBackgroundElements(),

          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Critical Error Indicator
                    _buildErrorIndicator(),

                    const SizedBox(height: 50),

                    // Error Message Card
                    _buildErrorMessage(),

                    const SizedBox(height: 50),

                    // Action Section
                    _buildActionSection(),

                    const SizedBox(height: 48),

                    Text(
                      "TERMINAL STATUS: DISCONNECTED",
                      style: GoogleFonts.outfit(
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        color: DesignTokens.accent.withOpacity(0.4),
                        letterSpacing: 3.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundElements() {
    return Stack(
      children: [
        Positioned(
          top: -150,
          right: -100,
          child: Opacity(
            opacity: 0.08,
            child: Icon(Icons.wifi_off_rounded,
                size: 450, color: DesignTokens.accent),
          ),
        ),
        Positioned(
          bottom: -100,
          left: -80,
          child: Opacity(
            opacity: 0.05,
            child: Icon(Icons.radar_rounded,
                size: 350, color: DesignTokens.primary),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorIndicator() {
    return GlowContainer(
      glowColor: DesignTokens.accent,
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: DesignTokens.accent.withOpacity(0.08),
          shape: BoxShape.circle,
          border: Border.all(
            color: DesignTokens.accent.withOpacity(0.25),
            width: 1.5,
          ),
        ),
        child: const Icon(
          Icons.signal_wifi_connected_no_internet_4_rounded,
          size: 72,
          color: DesignTokens.accent,
        ),
      ),
    );
  }

  Widget _buildErrorMessage() {
    return NeonCard(
      padding: const EdgeInsets.all(32),
      borderColor: DesignTokens.accent.withOpacity(0.15),
      child: Column(
        children: [
          Text(
            "CONNECTION FAILED",
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(
              fontSize: 26,
              fontWeight: FontWeight.w900,
              color: DesignTokens.textPrimary,
              letterSpacing: 2.0,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            height: 2,
            width: 80,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [DesignTokens.accent, DesignTokens.accent.withOpacity(0)],
              ),
              borderRadius: BorderRadius.circular(1),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            "The secure data stream has been interrupted. Restore network protocols to re-establish secure terminal access.",
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(
              fontSize: 15,
              color: DesignTokens.textSecondary,
              height: 1.7,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionSection() {
    if (_checking) {
      return Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            decoration: BoxDecoration(
              color: DesignTokens.primary.withOpacity(0.08),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: DesignTokens.primary.withOpacity(0.2)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  width: 14,
                  height: 14,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(DesignTokens.primary),
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  "RESTORING SIGNAL...",
                  style: GoogleFonts.outfit(
                    color: DesignTokens.primary,
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: 200,
            height: 3,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(1.5),
              child: LinearProgressIndicator(
                backgroundColor: DesignTokens.primary.withOpacity(0.05),
                valueColor: const AlwaysStoppedAnimation<Color>(DesignTokens.primary),
              ),
            ),
          ),
        ],
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: GradientButton(
          text: "REBOOT CONNECTION",
          icon: Icons.refresh_rounded,
          onPressed: _retryConnection,
        ),
      );
    }
  }
}


