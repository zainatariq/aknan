// profile_widget_item_data
import 'package:aknan_user_app/features/authenticate/domain/use-cases/auth_cases.dart';
import 'package:aknan_user_app/global/theme/app-colors/app_colors_light.dart';
import 'package:aknan_user_app/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../global/app-assets/assets.dart';

class ProfileWidgetItemData extends StatefulWidget {
  const ProfileWidgetItemData({
    super.key,
  });

  @override
  State<ProfileWidgetItemData> createState() => _ProfileWidgetItemDataState();
}

class _ProfileWidgetItemDataState extends State<ProfileWidgetItemData> {
  String? userName;
  String? phone;
  String? email;
  String? address;
  void getData() async {
    var user = await sl<AuthCases>().getUserData();
    userName = user!.name!;
    phone = user.phone;
    email = user.email;
    address = user.address;
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.h,
      width: MediaQuery.sizeOf(context).width - 20.w,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsetsDirectional.only(start: 20),
      decoration: BoxDecoration(
        color: AppColorsLight.instance.primaryColorBlue,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text(
            userName ?? "",
            style: Theme.of(context).textTheme.displayMedium,
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              SvgPicture.asset(
                Assets.imagesSvgsIcoCallContUs,
                color: Colors.white,
              ),
              const SizedBox(width: 10),
              Text(
                phone ?? "",
                style: Theme.of(context).textTheme.displayLarge,
              )
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              SvgPicture.asset(
                Assets.imagesSvgsMailContantUs,
                color: Colors.white,
              ),
              const SizedBox(width: 10),
              Text(
                email ?? '',
                style: Theme.of(context).textTheme.displayLarge,
              )
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset(
                Assets.imagesSvgsLoction1,
                color: Colors.white,
              ),
              const SizedBox(width: 15),
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: SizedBox(
                  width: 230.w,
                  child: Text(
                    address ?? '',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
