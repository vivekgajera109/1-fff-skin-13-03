// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:shimmer/shimmer.dart';

// class AdsManager {
//   final String bannerAdId;

//   final List<BannerAd> _smallBanners = [];
//   final List<bool> _smallBannersLoaded = [];
//   final List<BannerAd> _largeBanners = [];
//   final List<bool> _largeBannersLoaded = [];

//   AdsManager({required this.bannerAdId});

//   Future<void> initAds({int smallCount = 10, int largeCount = 5}) async {
//     _preloadBanners(smallCount);
//     _preloadLargeBanners(largeCount);
//   }

//   void _preloadBanners(int count) {
//     for (int i = 0; i < count; i++) {
//       final ad = BannerAd(
//         adUnitId: bannerAdId,
//         size: AdSize.banner,
//         request: const AdRequest(),
//         listener: BannerAdListener(
//           onAdLoaded: (ad) {
//             final index = _smallBanners.indexOf(ad as BannerAd);
//             if (index != -1) _smallBannersLoaded[index] = true;
//           },
//           onAdFailedToLoad: (ad, error) {
//             log('Small Banner failed to load: $error');
//             ad.dispose();
//           },
//         ),
//       );
//       ad.load();
//       _smallBanners.add(ad);
//       _smallBannersLoaded.add(false);
//     }
//   }

//   void _preloadLargeBanners(int count) {
//     for (int i = 0; i < count; i++) {
//       final ad = BannerAd(
//         adUnitId: bannerAdId,
//         size: AdSize.largeBanner,
//         request: const AdRequest(),
//         listener: BannerAdListener(
//           onAdLoaded: (ad) {
//             final index = _largeBanners.indexOf(ad as BannerAd);
//             if (index != -1) _largeBannersLoaded[index] = true;
//           },
//           onAdFailedToLoad: (ad, error) {
//             log('Large Banner failed to load: $error');
//             ad.dispose();
//           },
//         ),
//       );
//       ad.load();
//       _largeBanners.add(ad);
//       _largeBannersLoaded.add(false);
//     }
//   }

//   Widget getSmallBanner(int index) {
//     if (_smallBanners.isEmpty) return const SizedBox(height: 50);
//     final ad = _smallBanners[index % _smallBanners.length];
//     final loaded = _smallBannersLoaded[index % _smallBannersLoaded.length];

//     return SizedBox(
//       width: ad.size.width.toDouble(),
//       height: ad.size.height.toDouble(),
//       child: loaded
//           ? AdWidget(ad: ad)
//           : Shimmer.fromColors(
//               baseColor: Colors.grey.shade300,
//               highlightColor: Colors.grey.shade100,
//               child: Container(
//                 width: ad.size.width.toDouble(),
//                 height: ad.size.height.toDouble(),
//                 color: Colors.grey,
//               ),
//             ),
//     );
//   }

//   Widget getLargeBanner(int index) {
//     if (_largeBanners.isEmpty) return const SizedBox(height: 100);
//     final ad = _largeBanners[index % _largeBanners.length];
//     final loaded = _largeBannersLoaded[index % _largeBannersLoaded.length];

//     return SizedBox(
//       width: ad.size.width.toDouble(),
//       height: ad.size.height.toDouble(),
//       child: loaded
//           ? AdWidget(ad: ad)
//           : Shimmer.fromColors(
//               baseColor: Colors.grey.shade300,
//               highlightColor: Colors.grey.shade100,
//               child: Container(
//                 width: ad.size.width.toDouble(),
//                 height: ad.size.height.toDouble(),
//                 color: Colors.grey,
//               ),
//             ),
//     );
//   }

//   void dispose() {
//     for (var ad in _smallBanners) {
//       ad.dispose();
//     }
//     for (var ad in _largeBanners) {
//       ad.dispose();
//     }
//   }
// }
