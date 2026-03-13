import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/design_tokens.dart';
import '../common/common_button/common_button.dart';
import '../provider/onboarding_provider.dart';
import 'home_screen.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  bool _navigated = false;

  late AnimationController _pulseCtrl;
  late Animation<double> _pulseAnim;

  late AnimationController _glowCtrl;
  late Animation<double> _glowAnim;

  late AnimationController _fadeCtrl;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();

    _pulseCtrl = AnimationController(
        vsync: this, duration: const Duration(seconds: 2))
      ..repeat(reverse: true);
    _pulseAnim = Tween<double>(begin: 0.98, end: 1.02).animate(
        CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut));

    _glowCtrl = AnimationController(
        vsync: this, duration: const Duration(seconds: 3))
      ..repeat(reverse: true);
    _glowAnim = Tween<double>(begin: 0.4, end: 1.0).animate(
        CurvedAnimation(parent: _glowCtrl, curve: Curves.easeInOut));

    _fadeCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    _fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeIn));
    _fadeCtrl.forward();

    _startSplash();
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    _glowCtrl.dispose();
    _fadeCtrl.dispose();
    super.dispose();
  }

  Future<void> _startSplash() async {
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted || _navigated) return;
    _navigated = true;
    final onboardingDone = await OnboardingProvider.isOnboardingCompleted();
    await CommonOnTap.openUrl();
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) =>
            onboardingDone ? const HomeScreen() : const OnboardingScreen(),
        transitionsBuilder: (_, animation, __, child) =>
            FadeTransition(opacity: animation, child: child),
        transitionDuration: const Duration(milliseconds: 1000),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignTokens.background,
      body: FadeTransition(
        opacity: _fadeAnim,
        child: Stack(
          children: [
            // Dark base layers
            _buildAmbientBackground(),

            // Main centered content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Pulsing logo with depth
                  _buildAnimatedLogo(),

                  const SizedBox(height: 60),

                  // Title with premium styling
                  _buildTitleArea(),

                  const SizedBox(height: 12),
                  _buildSubtitleArea(),

                  const SizedBox(height: 120),

                  // Loading terminal
                  _buildTerminalLoader(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAmbientBackground() {
    return Stack(
      children: [
        // Grid pattern
        Opacity(
          opacity: 0.03,
          child: CustomPaint(
            painter: _GridPainter(),
            child: const SizedBox.expand(),
          ),
        ),

        // Kinetic glow spheres
        AnimatedBuilder(
          animation: _glowAnim,
          builder: (context, _) => Positioned(
            top: -150,
            right: -100,
            child: Container(
              width: 500,
              height: 500,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    DesignTokens.primary.withOpacity(0.12 * _glowAnim.value),
                    DesignTokens.primary.withOpacity(0),
                  ],
                ),
              ),
            ),
          ),
        ),

        AnimatedBuilder(
          animation: _glowAnim,
          builder: (context, _) => Positioned(
            bottom: -100,
            left: -100,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    DesignTokens.secondary.withOpacity(0.08 * _glowAnim.value),
                    DesignTokens.secondary.withOpacity(0),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAnimatedLogo() {
    return AnimatedBuilder(
      animation: _pulseAnim,
      builder: (context, child) => Transform.scale(
        scale: _pulseAnim.value,
        child: child,
      ),
      child: AnimatedBuilder(
        animation: _glowAnim,
        builder: (context, child) => Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: DesignTokens.primary.withOpacity(0.25 * _glowAnim.value),
                blurRadius: 120,
                spreadRadius: 20,
              ),
            ],
          ),
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: DesignTokens.primary.withOpacity(0.35),
                width: 1.5,
              ),
            ),
            child: Hero(
              tag: 'app_logo',
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.6),
                      blurRadius: 30,
                      offset: const Offset(0, 15),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(32),
                  child: Image.asset(
                    'assets/image/app_logo.png',
                    height: 160,
                    width: 160,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitleArea() {
    return Column(
      children: [
        Text(
          "FFF SKIN TOOLS",
          style: GoogleFonts.outfit(
            fontSize: 34,
            fontWeight: FontWeight.w900,
            color: DesignTokens.textPrimary,
            letterSpacing: 8,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: 220,
          height: 1.5,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                DesignTokens.primary.withOpacity(0),
                DesignTokens.primary,
                DesignTokens.secondary,
                DesignTokens.secondary.withOpacity(0),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubtitleArea() {
    return Text(
      "ELITE GAMING ARCHIVE",
      style: GoogleFonts.outfit(
        fontSize: 10,
        fontWeight: FontWeight.w900,
        color: DesignTokens.textSecondary,
        letterSpacing: 4.5,
      ),
    );
  }

  Widget _buildTerminalLoader() {
    return Column(
      children: [
        AnimatedBuilder(
          animation: _glowAnim,
          builder: (context, _) => Text(
            "SYNCHRONIZING CORE DATA...",
            style: GoogleFonts.outfit(
              fontSize: 10,
              fontWeight: FontWeight.w900,
              color: DesignTokens.primary.withOpacity(0.3 + 0.4 * _glowAnim.value),
              letterSpacing: 2.5,
            ),
          ),
        ),
        const SizedBox(height: 20),
        AnimatedBuilder(
          animation: _glowAnim,
          builder: (context, _) => SizedBox(
            width: 180,
            height: 2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(1),
              child: LinearProgressIndicator(
                backgroundColor: Colors.white.withOpacity(0.03),
                valueColor: AlwaysStoppedAnimation<Color>(
                  DesignTokens.primary.withOpacity(0.5 + 0.4 * _glowAnim.value),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          "SYSTEM UPLINK v1.0.4",
          style: GoogleFonts.outfit(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: DesignTokens.textSecondary.withOpacity(0.3),
            letterSpacing: 3,
          ),
        ),
      ],
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.4)
      ..strokeWidth = 0.5;
    const spacing = 40.0;
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}


