// damage_details_page
import 'package:aknan_user_app/helpers/navigation.dart';
import 'package:aknan_user_app/localization/change_language.dart';
import 'package:aknan_user_app/localization/locale_keys.g.dart';
import 'package:aknan_user_app/main.dart';
import 'package:aknan_user_app/widgets/app_back_btn.dart';
import 'package:aknan_user_app/widgets/app_notification_widget.dart';
import 'package:aknan_user_app/widgets/custom_image.dart';
import 'package:aknan_user_app/widgets/photo_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../maintenance-work/pagnaintion/model/res/maintenance_work_res_model.dart';

class DamagePage extends StatelessWidget {
  final MaintenanceWorkResData maintenanceWorkResData;
  const DamagePage({
    super.key,
    required this.maintenanceWorkResData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.damage.tre),
        leading: const AppBackBtn(),
        actions: const [
          AppNotificationWidget(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (maintenanceWorkResData.externalBills != null &&
                (maintenanceWorkResData.externalBills?.isNotEmpty ?? false))
              InkWell(
                onTap: () {
                  context.push(
                    PhotoPage(
                      netImages: [
                        ...maintenanceWorkResData.externalBills!
                            .map((e) => e.img!)
                      ],
                    ),
                  );
                },
                child: SizedBox(
                  height: 269.h,
                  child: ListView.separated(
                    itemCount: 3,
                    padding: const EdgeInsetsDirectional.only(start: 10),
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(width: 10),
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          context.push(PhotoPage.networkImage(img));
                        },
                        child: CustomImage(
                          image: img,
                          height: 269.h,
                          width: 300.w,
                          fit: BoxFit.contain,
                        ),
                      );
                    },
                  ),
                ),
              ),
            const SizedBox(height: 30),
            Text(
              LocaleKeys.damage.tre,
              style: Theme.of(context).textTheme.headlineMedium!,
            ),
            const SizedBox(height: 30),
            Text(maintenanceWorkResData.damageNote ?? ""),
          ],
        ),
      ),
    );
  }
}
