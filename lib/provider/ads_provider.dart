import 'package:flutter/material.dart';

class AdsProvider extends ChangeNotifier {
  final List<String> _nativeAdsImages = List.generate(
    8,
    (index) => 'assets/ads/native_ads/large${index + 1}.jpg',
  );
  final List<String> _nativeDimondImages = List.generate(
    7,
    (index) => 'assets/ads/dimond/daily_diamond${index + 1}.png',
  );
  final List<String> _bannerImages = List.generate(
    7,
    (index) => 'assets/ads/dimond/daily_diamond${index + 1}.png',
  );

  final List<String> _adTitles = [
    "Unlock Free Fire Skins 🎭🔥",
    "Diamond Tips & Tricks 💎⚡",
    "Exclusive Bundles Waiting 👕✨",
    "Upgrade Your Weapons 🔫🔥",
    "Get Rare Characters Now 🧑‍🚀💥",
    "Free Fire Pro Settings ⚙️🎮",
    "Vehicles & Pets Collection 🚗🐾",
    "Boost Your Gaming Style ⭐",
  ];

  final List<String> _adSubtitles = [
    "Get the latest skin unlock tips daily",
    "Learn how to save diamonds easily",
    "Discover hidden bundles & offers",
    "Maximize weapon skins & upgrades",
    "Unlock and use special characters",
    "Find the best settings like pros",
    "Check out rare pets & vehicles",
    "Customize your style in FF now",
  ];

  final List<String> _buttonTitles = [
    "Unlock Now",
    "Get Tips",
    "Claim Bundle",
    "Upgrade Weapon",
    "Unlock Character",
    "View Settings",
    "Explore Now",
    "Boost Style",
  ];

  List<String> get nativeDimondImages => _nativeDimondImages;
  List<String> get adsImages => _nativeAdsImages;
  List<String> get adTitles => _adTitles;
  List<String> get adSubtitles => _adSubtitles;
  List<String> get buttonTitles => _buttonTitles;
  List<String> get bannerImages => _bannerImages;
}
