// app_notification_widget
import 'package:aknan_user_app/helpers/navigation.dart';
import 'package:aknan_user_app/route/paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../global/app-assets/assets.dart';

class AppNotificationWidget extends StatelessWidget {
  final int? nums;
  final Function()? onTap;
  const AppNotificationWidget({super.key, this.nums, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ??
          () {
            context.pushNamed(AppPaths.notificationScreen);
          },
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Stack(
          // alignment: AlignmentDirectional.bottomStart,
          clipBehavior: Clip.none,
          children: [
            SvgPicture.asset(
              Assets.imagesSvgsNotificationsAppBar,
            ),
            if (nums != null && nums! > 0)
            // if (true)
              PositionedDirectional(
                // textDirection: TextDirection.rtl,
                end: 17.w,
                bottom: 1.h,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: ColoredBox(
                    color: Colors.white,
                    child: Text(
                      "$nums",
                      // "200",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 10.sp,
                          ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
