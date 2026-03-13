import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/design_tokens.dart';
import 'premium_card.dart';

class FeatureGridItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final List<Color>? gradientColors;

  const FeatureGridItem({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {
    return PremiumCard(
      onTap: onTap,
      gradientColors: gradientColors,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: DesignTokens.spacing16,
          vertical: DesignTokens.spacing24,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon with glowing container
            Container(
              padding: const EdgeInsets.all(DesignTokens.spacing16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(DesignTokens.radiusM),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 38,
              ),
            ),
            const SizedBox(height: DesignTokens.spacing20),
            // Title with shadow for readability on gradients
            Text(
              title.toUpperCase(),
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.2,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.3),
                    offset: const Offset(0, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            // Subtitle or accent bar
            Container(
              width: 24,
              height: 2,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.4),
                borderRadius: BorderRadius.circular(1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
