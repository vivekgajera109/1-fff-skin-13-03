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

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  late final PageController _pageController;
  late final AnimationController _animController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animController.dispose();
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
        pageBuilder: (context, animation, secondaryAnimation) =>
            const HomeScreen(),
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
              // Dynamic Background Elements
              _buildBackgroundElements(),

              Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: pages.length,
                       onPageChanged: (index) {
                        provider.updateCurrentPage(index);
                      },
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final page = pages[index];
                        return _buildPageContent(page);
                      },
                    ),
                  ),
                  _buildBottomSection(provider, isLastPage, pages.length),
                ],
              ),

              // Tactical Skip Button
              Positioned(
                top: MediaQuery.of(context).padding.top + 16,
                right: 20,
                child: GestureDetector(
                  onTap: () => _finishOnboarding(provider),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: DesignTokens.surface.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: DesignTokens.primary.withOpacity(0.15)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "BYPASS",
                          style: GoogleFonts.outfit(
                            color: DesignTokens.textSecondary,
                            fontWeight: FontWeight.w900,
                            fontSize: 10,
                            letterSpacing: 2,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(Icons.fast_forward_rounded, color: DesignTokens.textSecondary.withOpacity(0.5), size: 14),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBackgroundElements() {
    return Stack(
      children: [
        Positioned(
          top: 100,
          left: -80,
          child: Opacity(
            opacity: 0.05,
            child: Icon(Icons.blur_on_rounded, size: 400, color: DesignTokens.primary),
          ),
        ),
        Positioned(
          bottom: 250,
          right: -100,
          child: Opacity(
            opacity: 0.04,
            child: Icon(Icons.radar_rounded, size: 450, color: DesignTokens.secondary),
          ),
        ),
      ],
    );
  }

  Widget _buildPageContent(OnboardingPage page) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 80),
                  AnimatedBuilder(
                    animation: _animController,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, 12 * (1 - _animController.value)),
                        child: child,
                      );
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 240,
                          height: 240,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                DesignTokens.primary.withOpacity(0.15),
                                DesignTokens.primary.withOpacity(0),
                              ],
                            ),
                          ),
                        ),
                        Hero(
                          tag: 'onboarding_${page.title}',
                          child: Container(
                            height: 280,
                            decoration: const BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 40,
                                  offset: Offset(0, 20),
                                ),
                              ],
                            ),
                            child: Image.asset(
                              page.image,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 60),
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(
                          color: DesignTokens.primary.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: DesignTokens.primary.withOpacity(0.2)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                color: DesignTokens.primary,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "SYSTEM RECRUITMENT",
                              style: GoogleFonts.outfit(
                                fontSize: 9,
                                fontWeight: FontWeight.w900,
                                color: DesignTokens.primary,
                                letterSpacing: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        page.title.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.outfit(
                          fontSize: 36,
                          fontWeight: FontWeight.w900,
                          color: DesignTokens.textPrimary,
                          letterSpacing: -1,
                          height: 1.0,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        page.subtitle,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.outfit(
                          fontSize: 16,
                          color: DesignTokens.textSecondary,
                          height: 1.7,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottomSection(
      OnboardingProvider provider, bool isLastPage, int totalPages) {
    return Container(
      padding: const EdgeInsets.fromLTRB(32, 20, 32, 56),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              totalPages,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.elasticOut,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                height: 4,
                width: provider.currentPage == index ? 32 : 8,
                decoration: BoxDecoration(
                  gradient: provider.currentPage == index
                      ? const LinearGradient(colors: [DesignTokens.primary, DesignTokens.secondary])
                      : null,
                  color: provider.currentPage == index
                      ? null
                      : DesignTokens.divider.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
          const SizedBox(height: 48),
          GradientButton(
            text: isLastPage ? "INITIALIZE COMMAND" : "NEXT PROTOCOL",
            icon: isLastPage
                ? Icons.terminal_rounded
                : Icons.chevron_right_rounded,
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


