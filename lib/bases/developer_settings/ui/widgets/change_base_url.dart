
// import 'package:aknan_user_app/bases/developer_settings/cubit/developer_cubit.dart';
// import 'package:flutter/material.dart';

// class ChangeBaseUrlDialog extends ApiView<DeveloperCubit> {
//   const ChangeBaseUrlDialog({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     String? altBaseurl;
//     return AlertDialog(
//       title: Text('alt_base_url'.translate(context)),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'current value'.translate(context),
//             style: const TextStyle(
//               color: primaryColor,
//               fontSize: 18,
//             ),
//           ),
//           const SizedBox(height: 16),
//           Text(cubit.state.altBaseUrl ?? ''),
//           const SizedBox(height: 8),
//           InputFieldWidget(
//             widgetHint: 'alt_base_url'.translate(context),
//             decoration: InputDecoration(
//               border: const OutlineInputBorder(),
//               hintText: 'alt_base_url'.translate(context),
//             ),
//             onChange: (value) {
//               altBaseurl = value;
//             },
//           ),
//         ],
//       ),
//       actions: [
//         OutlinedButton(
//           onPressed: () {
//             altBaseurl = null;
//             Navigator.of(context).pop();
//           },
//           child: Text('cancel'.translate(context)),
//         ),
//         ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: primaryColor,
//           ),
//           onPressed: () => Navigator.of(context).pop(altBaseurl),
//           child: Text('confirm'.translate(context)),
//         ),
//       ],
//     );
//   }
// }
