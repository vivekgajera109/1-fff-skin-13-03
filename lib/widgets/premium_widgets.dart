import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/design_tokens.dart';
import '../common/common_button/common_button.dart';

export '../common/common_button/common_button.dart' show CommonOnTap, CommonWillPopScope;

// ─────────────────────────────────────────────────────────────────────────────
// GradientButton — primary CTA with glow effect
// ─────────────────────────────────────────────────────────────────────────────
class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;
  final bool isLoading;
  final bool isSecondary;
  final Color? color;
  final double height;

  const GradientButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    this.isSecondary = false,
    this.color,
    this.height = 58,
  });

  @override
  Widget build(BuildContext context) {
    final baseColor = color ?? DesignTokens.primary;
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        gradient: isSecondary
            ? null
            : LinearGradient(
                colors: [baseColor, DesignTokens.secondary],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
        color: isSecondary ? baseColor.withOpacity(0.08) : null,
        borderRadius: BorderRadius.circular(DesignTokens.radiusM),
        border: Border.all(
          color: isSecondary ? baseColor.withOpacity(0.3) : Colors.transparent,
          width: 1.5,
        ),
        boxShadow: isSecondary
            ? null
            : [
                BoxShadow(
                  color: baseColor.withOpacity(0.35),
                  blurRadius: 20,
                  offset: const Offset(0, 6),
                ),
              ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(DesignTokens.radiusM),
          child: Center(
            child: isLoading
                ? const SizedBox(
                    height: 22,
                    width: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (icon != null) ...[
                        Icon(icon,
                            color: isSecondary ? baseColor : Colors.white,
                            size: 20),
                        const SizedBox(width: 8),
                      ],
                      Flexible(
                        child: Text(
                          text,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: GoogleFonts.outfit(
                            color: isSecondary ? baseColor : Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

// Backward-compatible alias
typedef NeonButton = GradientButton;
typedef PremiumButton = GradientButton;

// ─────────────────────────────────────────────────────────────────────────────
// GlassContainer — glassmorphism card with neon border
// ─────────────────────────────────────────────────────────────────────────────
class GlassContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final double blur;
  final double opacity;
  final double borderRadius;
  final Color? borderColor;
  final Color? glowColor;

  const GlassContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.blur = 12.0,
    this.opacity = 0.08,
    this.borderRadius = DesignTokens.radiusL,
    this.borderColor,
    this.glowColor,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveBorder = borderColor ?? DesignTokens.primary.withOpacity(0.15);
    final effectiveGlow = glowColor ?? DesignTokens.primary.withOpacity(0.05);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: effectiveGlow,
            blurRadius: 20,
            spreadRadius: 2,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            padding: padding ?? const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: DesignTokens.surface.withOpacity(opacity + 0.3),
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                color: effectiveBorder,
                width: 1.2,
              ),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  DesignTokens.primary.withOpacity(0.04),
                  DesignTokens.secondary.withOpacity(0.02),
                ],
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

// Backward-compatible alias
typedef GlassCard = GlassContainer;

// ─────────────────────────────────────────────────────────────────────────────
// NeonCard — solid card with neon border and glow
// ─────────────────────────────────────────────────────────────────────────────
class NeonCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? borderColor;
  final double borderRadius;
  final VoidCallback? onTap;
  final double? width;
  final double? height;

  const NeonCard({
    super.key,
    required this.child,
    this.padding,
    this.borderColor,
    this.borderRadius = DesignTokens.radiusL,
    this.onTap,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveBorder = borderColor ?? DesignTokens.primary.withOpacity(0.2);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: DesignTokens.surface,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: effectiveBorder, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: effectiveBorder.withOpacity(0.15),
            blurRadius: 16,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Padding(
            padding: padding ?? const EdgeInsets.all(20),
            child: child,
          ),
        ),
      ),
    );
  }
}



// ─────────────────────────────────────────────────────────────────────────────
// GlowContainer — adds a colored glow effect to any widget
// ─────────────────────────────────────────────────────────────────────────────
class GlowContainer extends StatelessWidget {
  final Widget child;
  final Color glowColor;
  final double blurRadius;
  final double spreadRadius;

  const GlowContainer({
    super.key,
    required this.child,
    this.glowColor = DesignTokens.primary,
    this.blurRadius = 24.0,
    this.spreadRadius = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: glowColor.withOpacity(0.18),
            blurRadius: blurRadius,
            spreadRadius: spreadRadius,
          ),
        ],
      ),
      child: child,
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// GradientHeader — styled section header with neon accent bar
// ─────────────────────────────────────────────────────────────────────────────
class GradientHeader extends StatelessWidget {
  final String title;
  final Color? accentColor;
  final double fontSize;
  final bool centerTitle;

  const GradientHeader({
    super.key,
    required this.title,
    this.accentColor,
    this.fontSize = 13,
    this.centerTitle = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = accentColor ?? DesignTokens.primary;
    final row = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: centerTitle ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        Container(
          width: 4,
          height: 18,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color, DesignTokens.secondary],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(2),
            boxShadow: [
              BoxShadow(color: color.withOpacity(0.6), blurRadius: 8),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Flexible(
          child: Text(
            title.toUpperCase(),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: GoogleFonts.outfit(
              color: DesignTokens.textPrimary,
              fontWeight: FontWeight.w900,
              fontSize: fontSize,
              letterSpacing: 2.5,
            ),
          ),
        ),
      ],
    );

    if (centerTitle) {
      return Center(child: row);
    }
    return row;
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// GlowIconButton — icon with neon glow backdrop
// ─────────────────────────────────────────────────────────────────────────────
class GlowIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final Color? color;
  final double size;

  const GlowIconButton({
    super.key,
    required this.icon,
    this.onTap,
    this.color,
    this.size = 24,
  });

  @override
  Widget build(BuildContext context) {
    final iconColor = color ?? DesignTokens.primary;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.08),
          borderRadius: BorderRadius.circular(DesignTokens.radiusM),
          border: Border.all(color: iconColor.withOpacity(0.25), width: 1.2),
          boxShadow: [
            BoxShadow(
              color: iconColor.withOpacity(0.2),
              blurRadius: 12,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Icon(icon, color: iconColor, size: size),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// AnimatedListTile — animated list item with neon glow on tap
// ─────────────────────────────────────────────────────────────────────────────
class AnimatedListTile extends StatefulWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final VoidCallback onTap;
  final Color? accentColor;
  final Widget? trailing;

  const AnimatedListTile({
    super.key,
    required this.title,
    this.subtitle,
    required this.icon,
    required this.onTap,
    this.accentColor,
    this.trailing,
  });

  @override
  State<AnimatedListTile> createState() => _AnimatedListTileState();
}

class _AnimatedListTileState extends State<AnimatedListTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 150));
    _scale = Tween<double>(begin: 1.0, end: 0.97).animate(
        CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final accent = widget.accentColor ?? DesignTokens.primary;
    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) {
        _ctrl.reverse();
        widget.onTap();
      },
      onTapCancel: () => _ctrl.reverse(),
      child: ScaleTransition(
        scale: _scale,
        child: NeonCard(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          borderColor: accent.withOpacity(0.2),
          borderRadius: DesignTokens.radiusL,
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: accent.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: accent.withOpacity(0.25)),
                  boxShadow: [
                    BoxShadow(
                        color: accent.withOpacity(0.15), blurRadius: 12),
                  ],
                ),
                child: Icon(widget.icon, color: accent, size: 22),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: GoogleFonts.outfit(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: DesignTokens.textPrimary,
                      ),
                    ),
                    if (widget.subtitle != null) ...[
                      const SizedBox(height: 3),
                      Text(
                        widget.subtitle!,
                        style: GoogleFonts.outfit(
                          color: DesignTokens.textSecondary,
                          fontSize: 12,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              widget.trailing ??
                  Icon(Icons.arrow_forward_ios_rounded,
                      color: accent.withOpacity(0.4), size: 14),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// PremiumCard — animated tap card for home feature grid
// ─────────────────────────────────────────────────────────────────────────────
class PremiumCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final Color? glowColor;

  const PremiumCard({
    super.key,
    required this.child,
    this.onTap,
    this.glowColor,
  });

  @override
  State<PremiumCard> createState() => _PremiumCardState();
}

class _PremiumCardState extends State<PremiumCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 120));
    _scale = Tween<double>(begin: 1.0, end: 0.96).animate(
        CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final glow = widget.glowColor ?? DesignTokens.primary;
    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) {
        _ctrl.reverse();
        widget.onTap?.call();
      },
      onTapCancel: () => _ctrl.reverse(),
      child: ScaleTransition(
        scale: _scale,
        child: GlowContainer(
          glowColor: glow.withOpacity(0.15),
          blurRadius: 16,
          spreadRadius: -4,
          child: widget.child,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// CyberSliverAppBar — sliver app bar with cyberpunk header aesthetic
// ─────────────────────────────────────────────────────────────────────────────
class CyberSliverAppBar extends StatelessWidget {
  final double expandedHeight;
  final String title;
  final bool showBack;
  final List<Widget> backgroundExtras;
  final Color? accentColor;
  final VoidCallback? onBack;

  const CyberSliverAppBar({
    super.key,
    required this.title,
    this.expandedHeight = 180,
    this.showBack = true,
    this.backgroundExtras = const [],
    this.accentColor,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final accent = accentColor ?? DesignTokens.primary;
    return SliverAppBar(
      expandedHeight: expandedHeight,
      pinned: true,
      stretch: true,
      backgroundColor: DesignTokens.background,
      leading: showBack
          ? IconButton(
              onPressed: onBack ??
                  () async {
                    await CommonOnTap.openUrl();
                    await Future.delayed(const Duration(milliseconds: 400));
                    if (context.mounted) Navigator.pop(context);
                  },
              icon: GlowIconButton(
                icon: Icons.arrow_back_ios_new_rounded,
                color: accent,
                size: 16,
                onTap: null,
              ),
            )
          : null,
      automaticallyImplyLeading: showBack,
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [
          StretchMode.zoomBackground,
          StretchMode.blurBackground,
        ],
        title: Text(
          title.toUpperCase(),
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w900,
            fontSize: 14,
            letterSpacing: 3,
            color: DesignTokens.textPrimary,
          ),
        ),
        centerTitle: true,
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Deep dark gradient
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    accent.withOpacity(0.2),
                    DesignTokens.background,
                  ],
                ),
              ),
            ),
            // Scan line overlay
            Opacity(
              opacity: 0.04,
              child: CustomPaint(painter: _ScanLinePainter()),
            ),
            // Neon corner accent
            Positioned(
              right: -40,
              top: -40,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: accent.withOpacity(0.07),
                ),
              ),
            ),
            Positioned(
              left: -30,
              bottom: 20,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: DesignTokens.secondary.withOpacity(0.05),
                ),
              ),
            ),
            ...backgroundExtras,
            // Bottom gradient fade
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    DesignTokens.background.withOpacity(0.7),
                    DesignTokens.background,
                  ],
                  stops: const [0.4, 0.8, 1.0],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScanLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1;
    for (double y = 0; y < size.height; y += 4) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ─────────────────────────────────────────────────────────────────────────────
// PageWrapper — base scaffold with cyberpunk ambient background
// ─────────────────────────────────────────────────────────────────────────────
class PageWrapper extends StatelessWidget {
  final Widget child;
  final bool useSafeArea;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final bool extendBody;

  const PageWrapper({
    super.key,
    required this.child,
    this.useSafeArea = true,
    this.appBar,
    this.bottomNavigationBar,
    this.extendBody = false,
  });

  @override
  Widget build(BuildContext context) {
    return CommonWillPopScope(
      child: Scaffold(
        backgroundColor: DesignTokens.background,
        appBar: appBar,
        bottomNavigationBar: bottomNavigationBar,
        extendBody: extendBody,
        body: Stack(
          children: [
            // Ambient glow — top right
            Positioned(
              top: -120,
              right: -120,
              child: Container(
                width: 320,
                height: 320,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: DesignTokens.primary.withOpacity(0.04),
                ),
              ),
            ),
            // Ambient glow — bottom left
            Positioned(
              bottom: -80,
              left: -80,
              child: Container(
                width: 260,
                height: 260,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: DesignTokens.secondary.withOpacity(0.03),
                ),
              ),
            ),
            useSafeArea ? SafeArea(child: child) : child,
          ],
        ),
      ),
    );
  }
}

