import 'package:fff_skin_tools/constants/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingProvider extends ChangeNotifier {
  int currentPage = 0;

  final pages = [
    OnboardingPage(
      title: "Meet Iris",
      subtitle:
          "Discover the power of Iris and unlock exclusive Free Fire skins with one tap.",
      image: AppIcons.ffIris,
    ),
    OnboardingPage(
      title: "Otho’s Style",
      subtitle:
          "Customize your character with Otho-inspired skins, emotes, and outfits.",
      image: AppIcons.otho,
    ),
    OnboardingPage(
      title: "Adopt Your Pets",
      subtitle:
          "Level up your gameplay with adorable Free Fire pets and their special abilities.",
      image: AppIcons.pets,
    ),
    OnboardingPage(
      title: "Exclusive Bundles",
      subtitle:
          "Unlock rare bundles and outfits to stand out on the battlefield.",
      image: AppIcons.bundles,
    ),
    OnboardingPage(
      title: "Spin & Win",
      subtitle: "Try your luck with spins and claim amazing rewards every day.",
      image: AppIcons.diamondBox, // Using diamond box for spin/wheel
    ),
  ];

  void updateCurrentPage(int page) {
    currentPage = page;
    notifyListeners();
  }

  /// MARK: completeOnboarding
  Future<void> completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_done', true);
  }

  /// Check if onboarding is completed
  static Future<bool> isOnboardingCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('onboarding_done') ?? false;
  }
}

class OnboardingPage {
  final String title;
  final String subtitle;
  final String image;

  OnboardingPage({
    required this.title,
    required this.subtitle,
    required this.image,
  });
}
