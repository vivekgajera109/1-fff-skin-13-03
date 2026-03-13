import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../theme/design_tokens.dart';
import '../widgets/premium_widgets.dart';
import '../common/Ads/ads_card.dart';
import '../helper/remote_config_service.dart';

class NoInternetScreen extends StatefulWidget {
  const NoInternetScreen({super.key});

  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> with TickerProviderStateMixin {
  bool _checking = false;
  late final AnimationController _scanCtrl;
  late final AnimationController _glowCtrl;

  @override
  void initState() {
    super.initState();
    _scanCtrl = AnimationController(vsync: this, duration: const Duration(seconds: 4))..repeat();
    _glowCtrl = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat(reverse: true);
  }

  @override
  void dispose() {
    _scanCtrl.dispose();
    _glowCtrl.dispose();
    super.dispose();
  }

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
          // Tactical Background
          _buildTacticalGrid(),

          // Scanning Line
          _buildScanningLine(),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  _buildStatusHeader(),
                  const Spacer(),
                  
                  // Central Error Module
                  _buildSignalErrorModule(),
                  
                  const SizedBox(height: 60),
                  
                  // Message Panel
                  _buildErrorPanel(),
                  
                  if (RemoteConfigService.isAdsShow) ...[
                    const SizedBox(height: 24),
                    const BanerAdsScreen(),
                  ],

                  const Spacer(),
                  
                  // Action Area
                  _buildActionArea(),
                  
                  const SizedBox(height: 40),
                  _buildTerminalFooter(),
                  const SizedBox(height: 20),
                ],
              ),
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

  Widget _buildScanningLine() {
    return AnimatedBuilder(
      animation: _scanCtrl,
      builder: (context, child) {
        return Positioned(
          top: MediaQuery.of(context).size.height * _scanCtrl.value,
          left: 0,
          right: 0,
          child: Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  DesignTokens.accent.withOpacity(0.3),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatusHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "NO INTERNET",
              style: GoogleFonts.outfit(
                fontSize: 10,
                fontWeight: FontWeight.w900,
                color: DesignTokens.accent,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 4),
            Container(width: 40, height: 2, color: DesignTokens.accent.withOpacity(0.3)),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: DesignTokens.accent.withOpacity(0.1),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: DesignTokens.accent.withOpacity(0.3)),
          ),
          child: Text(
            "OFFLINE",
            style: GoogleFonts.outfit(
              fontSize: 8,
              fontWeight: FontWeight.w900,
              color: DesignTokens.accent,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignalErrorModule() {
    return AnimatedBuilder(
      animation: _glowCtrl,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: DesignTokens.accent.withOpacity(0.05 + (_glowCtrl.value * 0.05))),
              ),
            ),
            // Brackets
            SizedBox(
              width: 180,
              height: 180,
              child: CustomPaint(painter: _ModuleBracketsPainter(color: DesignTokens.accent)),
            ),
            GlowContainer(
              glowColor: DesignTokens.accent,
              blurRadius: 30 + (_glowCtrl.value * 30),
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: DesignTokens.accent.withOpacity(0.1),
                  shape: BoxShape.circle,
                  border: Border.all(color: DesignTokens.accent.withOpacity(0.3), width: 2),
                ),
                child: ClipOval(
                  child: Image.asset('assets/image/app_logo.png',
                      fit: BoxFit.cover),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildErrorPanel() {
    return CyberPanel(
      color: DesignTokens.accent,
      child: Column(
        children: [
          Text(
            "CONNECTION LOST",
            style: GoogleFonts.outfit(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: DesignTokens.textPrimary,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "Please check your internet connection and try again to restore access.",
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(
              fontSize: 14,
              color: DesignTokens.textSecondary,
              height: 1.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionArea() {
    if (_checking) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(DesignTokens.primary),
                ),
              ),
              const SizedBox(width: 16),
              Text(
                "RETRYING...",
                style: GoogleFonts.outfit(
                  color: DesignTokens.primary,
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            width: double.infinity,
            height: 4,
            decoration: BoxDecoration(
              color: DesignTokens.surface,
              borderRadius: BorderRadius.circular(2),
              border: Border.all(color: DesignTokens.primary.withOpacity(0.1)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: LinearProgressIndicator(
                backgroundColor: Colors.transparent,
                valueColor: const AlwaysStoppedAnimation<Color>(DesignTokens.primary),
              ),
            ),
          ),
        ],
      );
    } else {
      return GradientButton(
        text: "TRY AGAIN",
        icon: Icons.refresh_rounded,
        onPressed: _retryConnection,
        color: DesignTokens.accent,
      );
    }
  }

  Widget _buildTerminalFooter() {
    return Text(
      "STATUS: DISCONNECTED",
      style: GoogleFonts.outfit(
        fontSize: 8,
        fontWeight: FontWeight.bold,
        color: DesignTokens.textSecondary.withOpacity(0.4),
        letterSpacing: 1.5,
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

class _ModuleBracketsPainter extends CustomPainter {
  final Color color;
  _ModuleBracketsPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.3)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    
    double len = 20;
    // TL
    canvas.drawLine(const Offset(0, 0), Offset(len, 0), paint);
    canvas.drawLine(const Offset(0, 0), Offset(0, len), paint);
    // TR
    canvas.drawLine(Offset(size.width, 0), Offset(size.width - len, 0), paint);
    canvas.drawLine(Offset(size.width, 0), Offset(size.width, len), paint);
    // BL
    canvas.drawLine(Offset(0, size.height), Offset(len, size.height), paint);
    canvas.drawLine(Offset(0, size.height), Offset(0, size.height - len), paint);
    // BR
    canvas.drawLine(Offset(size.width, size.height), Offset(size.width - len, size.height), paint);
    canvas.drawLine(Offset(size.width, size.height), Offset(size.width, size.height - len), paint);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}


