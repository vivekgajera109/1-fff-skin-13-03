// // ignore_for_file: deprecated_member_use, use_build_context_synchronously

// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:fff_skin_tools/provider/calculator_provider.dart';
// import 'package:fff_skin_tools/constants/app_colors.dart';
// import 'package:fff_skin_tools/constants/app_style.dart';
// import 'package:fff_skin_tools/constants/static_decoration.dart';
// import 'package:fff_skin_tools/helper/navigation_helper/navigation_helper.dart';
// import 'package:fff_skin_tools/model/card_model.dart';
// import 'package:fff_skin_tools/screen/settings_screen.dart';
// import 'package:url_launcher/url_launcher.dart';

// class ProfessionalCard extends StatelessWidget {
//   final String title;
//   final String subtitle;
//   final String icon;
//   final bool showAdsTag;
//   final bool isFullWidth;
//   // final CardModel card;

//   const ProfessionalCard({
//     super.key,
//     // required this.card,
//     required this.title,
//     required this.subtitle,
//     required this.icon,
//     this.showAdsTag = false,
//     this.isFullWidth = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       // onTap: () async {
      //   await openUrlInApp("https://flutter.dev")
      //       .then(
      //         (value) => log("Link opened"),
      //       )
      //       .catchError(
      //         (error) => log("Error opening link: $error"),
      //       );

//       //   if (card.destination != null) {
//       //     Future.delayed(const Duration(seconds: 1), () {
//       //       if (card.destination != null) {
//       //         navigateWithAnimation(context, card.destination!);
//       //       }
//       //     });
//       //   }
//       // },
//       child: Material(
//         elevation: 6,
//         borderRadius: BorderRadius.circular(20),
//         shadowColor: AppColors.primary.withOpacity(0.3),
//         child: Container(
//           width: isFullWidth ? double.infinity : null,
//           padding: const EdgeInsets.all(15),
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [AppColors.primary, AppColors.secondary],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     width: 47,
//                     height: 47,
//                     decoration: BoxDecoration(
//                       color: AppColors.white.withOpacity(0.2),
//                       // shape: BoxShape.circle,
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     padding: const EdgeInsets.all(8),
//                     child: SvgPicture.asset(
//                       icon,
//                       color: AppColors.white,
//                     ),
//                   ),
//                   if (showAdsTag)
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 6, vertical: 3),
//                       decoration: BoxDecoration(
//                         color: AppColors.white.withOpacity(0.3),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Text('Ad',
//                           style: AppTextStyle.normalRegular12
//                               .copyWith(color: AppColors.white)),
//                     ),
//                 ],
//               ),
//               height10,
//               Text(
//                 title,
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//                 style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                       color: AppColors.white,
//                       fontSize: 18,
//                       fontWeight: FontWeight.w700,
//                     ),
//               ),
//               height05,
//               Text(
//                 subtitle,
//                 style: Theme.of(context).textTheme.bodySmall?.copyWith(
//                       color: AppColors.white.withOpacity(0.9),
//                     ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class ProfessionalCalulatorCard extends StatelessWidget {
//   final bool isFullWidth;
//   // final CalculatorModel card;

//   const ProfessionalCalulatorCard({
//     super.key,
//     // required this.card,
//     this.isFullWidth = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       elevation: 6,
//       borderRadius: BorderRadius.circular(20),
//       shadowColor: AppColors.primary.withOpacity(0.3),
//       child: Container(
//         width: isFullWidth ? double.infinity : null,
//         padding: const EdgeInsets.all(15),
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [AppColors.primary, AppColors.secondary],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   width: 47,
//                   height: 47,
//                   decoration: BoxDecoration(
//                     color: AppColors.white.withOpacity(0.2),
//                     // shape: BoxShape.circle,
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   padding: const EdgeInsets.all(8),
//                   child: SvgPicture.asset(
//                     card.icon,
//                     color: AppColors.white,
//                   ),
//                 ),
//                 if (card.isGame == true)
//                   Container(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
//                     decoration: BoxDecoration(
//                       color: AppColors.white.withOpacity(0.3),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Text('Ad',
//                         style: AppTextStyle.normalRegular12
//                             .copyWith(color: AppColors.white)),
//                   ),
//               ],
//             ),
//             height10,
//             Text(
//               card.title,
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//               style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                     color: AppColors.white,
//                     fontSize: 18,
//                     fontWeight: FontWeight.w700,
//                   ),
//             ),
//             height05,
//             Text(
//               card.subtitle,
//               style: Theme.of(context).textTheme.bodySmall?.copyWith(
//                     color: AppColors.white.withOpacity(0.9),
//                   ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// Future<void> openLink(String url) async {
//   final Uri uri = Uri.parse(url);

//   try {
//     if (!await launchUrl(
//       uri,
//       mode: LaunchMode.externalApplication, // open in external browser
//     )) {
//       throw Exception("Could not launch $url");
//     }
//   } catch (e) {
//     debugPrint("openLink error: $e");
//   }
// }
