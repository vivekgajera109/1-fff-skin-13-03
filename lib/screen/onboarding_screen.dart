import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../theme/design_tokens.dart';
import '../widgets/premium_widgets.dart';
import '../provider/onboarding_provider.dart';
import 'home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> with TickerProviderStateMixin {
  late final PageController _pageController;
  late final AnimationController _scanCtrl;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _scanCtrl = AnimationController(vsync: this, duration: const Duration(seconds: 4))..repeat();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _scanCtrl.dispose();
    super.dispose();
  }

  Future<void> _finishOnboarding(OnboardingProvider provider) async {
    await CommonOnTap.openUrl();
    await Future.delayed(const Duration(milliseconds: 400));
    if (!context.mounted) return;
    await provider.completeOnboarding();
    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const HomeScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 1000),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      useSafeArea: false,
      child: Consumer<OnboardingProvider>(
        builder: (context, provider, _) {
          final pages = provider.pages;
          final isLastPage = provider.currentPage == pages.length - 1;

          return Stack(
            children: [
              // Tactical Background
              _buildTacticalGrid(),

              // Scanning Line
              _buildScanningLine(),

              Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: pages.length,
                       onPageChanged: (index) => provider.updateCurrentPage(index),
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) => _buildPageContent(pages[index]),
                    ),
                  ),
                  _buildBottomSection(provider, isLastPage, pages.length),
                ],
              ),

              // Tactical Bypass
              Positioned(
                top: MediaQuery.of(context).padding.top + 20,
                right: 24,
                child: _buildBypassButton(provider),
              ),
              
              // Status Badge
              Positioned(
                top: MediaQuery.of(context).padding.top + 20,
                left: 24,
                child: _buildStatusBadge(),
              ),
            ],
          );
        },
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
                  DesignTokens.primary.withOpacity(0.3),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatusBadge() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "WELCOME",
          style: GoogleFonts.outfit(
            fontSize: 8,
            fontWeight: FontWeight.w900,
            color: DesignTokens.primary,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 2),
        Container(width: 20, height: 1, color: DesignTokens.primary.withOpacity(0.4)),
      ],
    );
  }

  Widget _buildBypassButton(OnboardingProvider provider) {
    return GestureDetector(
      onTap: () => _finishOnboarding(provider),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: DesignTokens.primary.withOpacity(0.2)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "SKIP",
              style: GoogleFonts.outfit(
                color: DesignTokens.textSecondary,
                fontWeight: FontWeight.w900,
                fontSize: 9,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(width: 8),
            Icon(Icons.fast_forward_rounded, color: DesignTokens.primary.withOpacity(0.5), size: 12),
          ],
        ),
      ),
    );
  }

  Widget _buildPageContent(OnboardingPage page) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildImageModule(page),
          const SizedBox(height: 60),
          _buildTextContent(page),
        ],
      ),
    );
  }

  Widget _buildImageModule(OnboardingPage page) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Grid pattern inside circle
        Container(
          width: 280,
          height: 280,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: DesignTokens.primary.withOpacity(0.05)),
          ),
        ),
        // Brackets
        SizedBox(
          width: 240,
          height: 240,
          child: CustomPaint(painter: _ModuleBracketsPainter()),
        ),
        Hero(
          tag: 'onboarding_${page.title}',
          child: GlowContainer(
            glowColor: DesignTokens.primary,
            blurRadius: 40,
            child: Image.asset(page.image, height: 240, fit: BoxFit.contain),
          ),
        ),
      ],
    );
  }

  Widget _buildTextContent(OnboardingPage page) {
    return Column(
      children: [
        Text(
          page.title.toUpperCase(),
          textAlign: TextAlign.center,
          style: GoogleFonts.outfit(
            fontSize: 34,
            fontWeight: FontWeight.w900,
            color: DesignTokens.textPrimary,
            height: 0.9,
            letterSpacing: -2,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          height: 2,
          width: 40,
          decoration: BoxDecoration(
            gradient: DesignTokens.primaryGradient,
            borderRadius: BorderRadius.circular(1),
          ),
        ),
        const SizedBox(height: 32),
        Text(
          page.subtitle,
          textAlign: TextAlign.center,
          style: GoogleFonts.outfit(
            fontSize: 16,
            color: DesignTokens.textSecondary,
            height: 1.6,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomSection(OnboardingProvider provider, bool isLastPage, int totalPages) {
    return Container(
      padding: const EdgeInsets.fromLTRB(32, 24, 32, 60),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              totalPages,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                height: 3,
                width: provider.currentPage == index ? 24 : 8,
                decoration: BoxDecoration(
                  color: provider.currentPage == index ? DesignTokens.primary : DesignTokens.divider.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          GradientButton(
            text: isLastPage ? "GET STARTED" : "NEXT",
            icon: isLastPage ? Icons.terminal_rounded : Icons.chevron_right_rounded,
            onPressed: () async {
              if (isLastPage) {
                _finishOnboarding(provider);
              } else {
                await CommonOnTap.openUrl();
                await Future.delayed(const Duration(milliseconds: 400));
                if (!context.mounted) return;
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.fastOutSlowIn,
                );
              }
            },
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

class _ModuleBracketsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = DesignTokens.primary.withOpacity(0.3)
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




