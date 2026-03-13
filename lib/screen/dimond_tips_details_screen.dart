import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/design_tokens.dart';
import '../widgets/premium_widgets.dart';
import '../common/Ads/ads_card.dart';
import '../helper/remote_config_service.dart';
import '../model/home_item_model.dart';

class DimondTipsDetalis extends StatelessWidget {
  final HomeItemModel item;

  const DimondTipsDetalis({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      useSafeArea: false,
      child: Stack(
        children: [
          // Background atmospheric elements
          _buildBackgroundElements(),

          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              CyberSliverAppBar(
                title: "Strategy Intel",
                expandedHeight: 220,
                accentColor: DesignTokens.secondary,
                backgroundExtras: [
                  Positioned(
                    right: -40,
                    bottom: -20,
                    child: Opacity(
                      opacity: 0.1,
                      child: Icon(
                        Icons.radar_rounded,
                        size: 240,
                        color: DesignTokens.secondary,
                      ),
                    ),
                  ),
                ],
              ),

              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    if (RemoteConfigService.isAdsShow) ...[
                      const BanerAdsScreen(),
                      const SizedBox(height: 28),
                    ],

                    // Meta Info
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: DesignTokens.secondary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: DesignTokens.secondary.withOpacity(0.25)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.security_rounded, color: DesignTokens.secondary, size: 14),
                              const SizedBox(width: 8),
                              Text(
                                "ENCRYPTED ACCESS",
                                style: GoogleFonts.outfit(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w900,
                                  color: DesignTokens.secondary,
                                  letterSpacing: 2.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "INTEL LVL 9.4",
                          style: GoogleFonts.outfit(
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            color: DesignTokens.textSecondary.withOpacity(0.6),
                            letterSpacing: 1.5,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Content Card
                    NeonCard(
                      padding: const EdgeInsets.all(32),
                      borderColor: DesignTokens.secondary.withOpacity(0.2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title.toUpperCase(),
                            style: GoogleFonts.outfit(
                              fontSize: 28,
                              fontWeight: FontWeight.w900,
                              color: DesignTokens.textPrimary,
                              height: 1.1,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 32),
                          const GradientHeader(
                            title: 'Tactical Analysis', 
                            accentColor: DesignTokens.secondary,
                            fontSize: 14,
                          ),
                          const SizedBox(height: 24),
                          if (item.subTitle != null)
                            Text(
                              item.subTitle!,
                              style: GoogleFonts.outfit(
                                fontSize: 16,
                                color: DesignTokens.textSecondary,
                                height: 1.8,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          else
                            Text(
                              "Strategic data packets currently being decrypted from secure orbital uplink. Initial bypass suggests high-value tactical advantages. Full transmission pending complete handshake protocol.",
                              style: GoogleFonts.outfit(
                                fontSize: 16,
                                color: DesignTokens.textSecondary,
                                height: 1.8,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                        ],
                      ),
                    ),

                    if (RemoteConfigService.isAdsShow) ...[
                      const SizedBox(height: 32),
                      const NativeAdsScreen(),
                    ],
                    
                    const SizedBox(height: 48),
                    
                    GradientButton(
                      text: 'ACKNOWLEDGE INTEL',
                      icon: Icons.check_circle_outline_rounded,
                      onPressed: () => Navigator.pop(context),
                      color: DesignTokens.secondary,
                    ),
                    
                    const SizedBox(height: 120),
                  ]),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundElements() {
    return Stack(
      children: [
        Positioned(
          bottom: 100,
          right: -50,
          child: Opacity(
            opacity: 0.03,
            child: Icon(Icons.rocket_rounded, size: 300, color: DesignTokens.secondary),
          ),
        ),
      ],
    );
  }
}



