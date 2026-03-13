import 'package:flutter/material.dart';
import '../theme/design_tokens.dart';

class PremiumCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final bool useGradient;
  final List<Color>? gradientColors;

  const PremiumCard({
    super.key,
    required this.child,
    this.onTap,
    this.useGradient = true,
    this.gradientColors,
  });

  @override
  State<PremiumCard> createState() => _PremiumCardState();
}

class _PremiumCardState extends State<PremiumCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.98).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => widget.onTap != null ? _controller.forward() : null,
      onTapUp: (_) => widget.onTap != null ? _controller.reverse() : null,
      onTapCancel: () => widget.onTap != null ? _controller.reverse() : null,
      onTap: widget.onTap,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(DesignTokens.radiusL),
            border: Border.all(color: DesignTokens.border, width: 1),
            gradient: widget.useGradient
                ? LinearGradient(
                    colors: widget.gradientColors ?? [DesignTokens.primary, DesignTokens.secondary],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            color: widget.useGradient ? null : DesignTokens.surface,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
              if (widget.useGradient)
                BoxShadow(
                  color: (widget.gradientColors?.first ?? DesignTokens.primary).withOpacity(0.2),
                  blurRadius: 20,
                  spreadRadius: -5,
                ),
            ],
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
