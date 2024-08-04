import 'package:aknan_user_app/global/app-assets/assets.dart';
import 'package:aknan_user_app/localization/change_language.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../localization/locale_keys.g.dart';

// pick_image_widget
class PickImageWidget extends StatelessWidget {
  final Function() onCameraTap;
  final Function() onGalleryTap;
  const PickImageWidget({
    super.key,
    required this.onCameraTap,
    required this.onGalleryTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
      height: 200.h,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0.r),
          topRight: Radius.circular(20.0.r),
        ),
      ),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 10.h),
            height: 5.h,
            width: 50.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.r)),
                color: Theme.of(context).primaryColor.withOpacity(.3)),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: onCameraTap,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.1),
                          shape: BoxShape.circle),
                      padding: EdgeInsets.all(20.sp),
                      child: Icon(
                        Icons.camera_alt_outlined,
                        color: Theme.of(context).primaryColor,
                        size: 40.sp,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      LocaleKeys.from_camera.tre,
                      style: TextStyle(fontSize: 14.sp),
                    )
                  ],
                ),
              ),
              const SizedBox(width: 20),
              InkWell(
                onTap: onGalleryTap,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.1),
                          shape: BoxShape.circle),
                      padding: EdgeInsets.all(20.sp),
                      child: Image.asset(
                        Assets.imagesPngsGallery,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                    LocaleKeys.from_gallery.tre,
                      style: TextStyle(fontSize: 14.sp),
                    )
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
        ],
      )),
    );
  }
}
