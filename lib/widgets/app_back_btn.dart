// app_back_btn
import 'package:aknan_user_app/global/app-assets/assets.dart';
import 'package:aknan_user_app/helpers/navigation.dart';
import 'package:aknan_user_app/localization/change_language.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBackBtn extends StatelessWidget {
  final Function()? onTap;
  const AppBackBtn({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.flip(
      flipX: TLang.isArabic(context),
      child: IconButton(
          onPressed: () {
            if (onTap == null) {
              context.pop();
            }
            onTap?.call();
          },
          icon: SvgPicture.asset(
            Assets.imagesSvgsBackBtnicon,
            height: 28,
            width: 28,
          )),
    );
  }
}
