// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:ride_sharing_user_app/util/text_style.dart';

// import '../../../../util/app_strings.dart';
// import '../../../../util/app_style.dart';

// class DottedBorderBox extends StatelessWidget {
//   final double? height;
//   final double? width;
//   final Function() onTap;
//   const DottedBorderBox({Key? key, required this.onTap, this.height=100, this.width=100}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return DottedBorder(
//       dashPattern: const [8, 4],
//       strokeWidth: 1,
//       borderType: BorderType.RRect,
//       color: Colors.grey,
//       radius: const Radius.circular(10),
//       child: GestureDetector(
//         onTap: onTap,
//         child: SizedBox(height: height, width: width,
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(Icons.cloud_upload_rounded,
//                   color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.6),
//                   size: 30,
//                 ),
//                K.sizedBoxH1,
//                 Text(Strings.uploadFile.tr,
//                   style: textMedium.copyWith(fontSize: 12,
//                     color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.6),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
