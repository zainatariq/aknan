import 'dart:io';

import 'package:flutter/material.dart';

import '../global/app-assets/assets.dart';
import '../helpers/custom_pick_helper.dart';

class ImagePick extends StatelessWidget {
  final Function(File img) onSelectImg;
  final Function() deleteImg;
  final double? hight;
  final double? width;
  final Widget? pickWidget;
  final File? selectedFile;
  const ImagePick({
    super.key,
    required this.onSelectImg,
    required this.deleteImg,
    this.hight,
    this.pickWidget,
    this.width,
    this.selectedFile,
  });

  void pickImg(context) {
    CustomPickHelper.showPickImageBottomSheet(context).then((value) {
      if (value != null) {
        onSelectImg(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Align(
        alignment: Alignment.center,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: selectedFile != null
              ? Stack(
                  alignment: FractionalOffset.bottomLeft,
                  children: [
                    // StatefulBuilder(builder: ())
                    Image.file(
                      File(selectedFile!.path),
                      width: width ?? 200,
                      height: hight ?? 100,
                      fit: BoxFit.cover,
                    ),
                    IconButton(
                      onPressed: () {
                        deleteImg.call();
                      },
                      icon: const Icon(
                        Icons.close,
                        size: 25,
                        color: Colors.teal,
                      ),
                    ),
                  ],
                )
              : InkWell(
                  onTap: () => pickImg(context),
                  child: pickWidget ??
                      SizedBox(
                        height: hight ?? 100,
                        width: width ?? 200,
                        child: Image.asset(
                          Assets.imagesPngsCameraPlaceholder,
                          width: 50,
                          color: Theme.of(context)
                              .bottomNavigationBarTheme
                              .backgroundColor,
                        ),
                      ),
                ),

          // : const SizedBox(
          //     height: 20,
          //   ),
        ),
      ),
    );
  }
}
