// maintenance_work_btn
import 'package:aknan_user_app/helpers/navigation.dart';
import 'package:aknan_user_app/localization/change_language.dart';
import 'package:aknan_user_app/localization/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../maintenance-work/ui/maintenance_work_page.dart';
import '../profile_sub_screen.dart';

class CustomBtn2 extends StatelessWidget {
  final Function()? onTap;
  final String tittle;
  const CustomBtn2({
    super.key,
    required this.onTap,
    required this.tittle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 80.w),
        child: GestureDetector(
          onTap: onTap,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9),
            ),
            color: Theme.of(context).hoverColor,
            child: Container(
              height: 67.h,
              padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 5.h),
              decoration: BoxDecoration(
                color: Theme.of(context).hoverColor,
                borderRadius: BorderRadius.circular(9),
              ),
              alignment: Alignment.center,
              child: FittedBox(child: Text(tittle)),
            ),
          ),
        ),
      ),
    );
  }
}
