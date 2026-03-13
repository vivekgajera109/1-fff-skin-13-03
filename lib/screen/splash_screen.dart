import 'dart:math';
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

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  bool _navigated = false;
  late AnimationController _mainCtrl;
  late AnimationController _scanCtrl;
  late Animation<double> _fade;
  late Animation<double> _logoScale;
  
  final List<String> _bootLogs = [
    "Loading application...",
    "Connecting...",
    "Preparing data...",
    "Setting up...",
    "Ready.",
  ];
  int _logIndex = 0;

  @override
  void initState() {
    super.initState();
    _mainCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 2000));
    _scanCtrl = AnimationController(vsync: this, duration: const Duration(seconds: 4))..repeat();
    _fade = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _mainCtrl, curve: Curves.easeIn));
    _logoScale = Tween<double>(begin: 0.85, end: 1.0).animate(CurvedAnimation(parent: _mainCtrl, curve: Curves.elasticOut));
    
    _mainCtrl.forward();
    _startBootSequence();
    _startSplash();
  }

  void _startBootSequence() async {
    for (int i = 0; i < _bootLogs.length; i++) {
      await Future.delayed(Duration(milliseconds: 600 + (Random().nextInt(400))));
      if (mounted) setState(() => _logIndex = i);
    }
  }

  @override
  void dispose() {
    _mainCtrl.dispose();
    _scanCtrl.dispose();
    super.dispose();
  }

  Future<void> _startSplash() async {
    await Future.delayed(const Duration(seconds: 5));
    if (!mounted || _navigated) return;
    _navigated = true;
    final onboardingDone = await OnboardingProvider.isOnboardingCompleted();
    await CommonOnTap.openUrl();
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => onboardingDone ? const HomeScreen() : const OnboardingScreen(),
        transitionsBuilder: (_, animation, __, child) => FadeTransition(opacity: animation, child: child),
        transitionDuration: const Duration(milliseconds: 800),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignTokens.background,
      body: Stack(
        children: [
          // Tactical Grid
          Positioned.fill(
            child: Opacity(
              opacity: 0.03,
              child: CustomPaint(painter: _TacticalGridPainter()),
            ),
          ),

          // Scanning Line
          AnimatedBuilder(
            animation: _scanCtrl,
            builder: (context, child) {
              return Positioned(
                top: MediaQuery.of(context).size.height * _scanCtrl.value,
                left: 0,
                right: 0,
                child: Container(
                  height: 2,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        DesignTokens.primary.withOpacity(0.5),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              );
            },
          ),

          // Central content
          FadeTransition(
            opacity: _fade,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Tech Logo Frame
                  _buildCoreUnit(),
                  
                  const SizedBox(height: 56),

                  // Brand Title
                  _buildBrandTitle(),

                  const SizedBox(height: 100),

                  // Terminal Boot Logs
                  _buildTerminalOutput(),
                ],
              ),
            ),
          ),

          // Technical Badge
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(child: _buildVersionBadge()),
          ),
        ],
      ),
    );
  }

  Widget _buildCoreUnit() {
    return ScaleTransition(
      scale: _logoScale,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Glow Background
          Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: DesignTokens.primary.withOpacity(0.1), blurRadius: 40, spreadRadius: 10),
              ],
            ),
          ),
          // Outer Ring
          RotationTransition(
            turns: _scanCtrl,
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: DesignTokens.primary.withOpacity(0.2), width: 1, strokeAlign: BorderSide.strokeAlignOutside),
              ),
              child: Stack(
                children: List.generate(4, (i) {
                  return Positioned(
                    top: i == 0 ? -2 : null,
                    bottom: i == 1 ? -2 : null,
                    left: i == 2 ? -2 : null,
                    right: i == 3 ? -2 : null,
                    child: Container(width: 10, height: 10, decoration: const BoxDecoration(color: DesignTokens.primary, shape: BoxShape.circle)),
                  );
                }),
              ),
            ),
          ),
          // Logo
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: DesignTokens.primary.withOpacity(0.5), width: 2),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: Image.asset('assets/image/app_logo.png', height: 130, width: 130, fit: BoxFit.cover),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBrandTitle() {
    return Column(
      children: [
        Text(
          "FFF",
          style: GoogleFonts.outfit(
            color: Colors.white,
            fontSize: 46,
            fontWeight: FontWeight.w900,
            height: 0.9,
            letterSpacing: -2,
          ),
        ),
        Text(
          "SKIN TOOL",
          style: GoogleFonts.outfit(
            color: DesignTokens.primary,
            fontSize: 26,
            fontWeight: FontWeight.w900,
            height: 0.9,
            letterSpacing: 4,
          ),
        ),
      ],
    );
  }

  Widget _buildTerminalOutput() {
    return SizedBox(
      height: 80,
      child: Column(
        children: [
          Text(
            _bootLogs[_logIndex],
            style: GoogleFonts.firaCode(
              color: DesignTokens.secondary,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: 160,
            height: 2,
            decoration: BoxDecoration(
              color: Colors.white12,
              borderRadius: BorderRadius.circular(1),
            ),
            child: Stack(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  width: 160 * ((_logIndex + 1) / _bootLogs.length),
                  decoration: BoxDecoration(
                    color: DesignTokens.primary,
                    boxShadow: [
                      BoxShadow(color: DesignTokens.primary.withOpacity(0.5), blurRadius: 8),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVersionBadge() {
    return Text(
      "V0.9.4",
      style: GoogleFonts.outfit(
        color: DesignTokens.textSecondary.withOpacity(0.5),
        fontSize: 7,
        fontWeight: FontWeight.w900,
        letterSpacing: 4,
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




