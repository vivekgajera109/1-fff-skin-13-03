import 'package:flutter/material.dart';
import '../theme/design_tokens.dart';

class ModernBottomNav extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const ModernBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(24, 0, 24, 20),
      height: 70,
      decoration: BoxDecoration(
        color: DesignTokens.surface.withOpacity(0.8),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: DesignTokens.divider.withOpacity(0.5),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(0, Icons.dashboard_rounded, "Home"),
            _buildNavItem(1, Icons.emoji_events_rounded, "Rewards"),
            _buildNavItem(2, Icons.person_rounded, "Profile"),
            _buildNavItem(3, Icons.settings_rounded, "Settings"),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () => onItemSelected(index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              if (isSelected)
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    color: DesignTokens.primary.withOpacity(0.15),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: DesignTokens.primary.withOpacity(0.4),
                        blurRadius: 15,
                        spreadRadius: -5,
                      ),
                    ],
                  ),
                ),
              Icon(
                icon,
                color: isSelected ? DesignTokens.primary : DesignTokens.textSecondary,
                size: 26,
              ),
            ],
          ),
          if (isSelected) ...[
            const SizedBox(height: 4),
            Container(
              width: 4,
              height: 4,
              decoration: const BoxDecoration(
                color: DesignTokens.primary,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
