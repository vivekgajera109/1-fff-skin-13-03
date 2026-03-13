import 'package:flutter/material.dart';
import '../theme/design_tokens.dart';

class GlowIcon extends StatelessWidget {
  final IconData icon;
  final Color? color;
  final double size;
  final double glowBlur;

  const GlowIcon({
    super.key,
    required this.icon,
    this.color,
    this.size = 24,
    this.glowBlur = 12,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? DesignTokens.primary;
    return Stack(
      alignment: Alignment.center,
      children: [
        Icon(
          icon,
          size: size,
          color: effectiveColor.withOpacity(0.5),
          shadows: [
            Shadow(
              color: effectiveColor,
              blurRadius: glowBlur,
            ),
          ],
        ),
        Icon(
          icon,
          size: size,
          color: effectiveColor,
        ),
      ],
    );
  }
}
