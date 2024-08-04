// maintenance_request_item_view
import 'package:aknan_user_app/helpers/navigation.dart';
import 'package:aknan_user_app/route/paths.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../bases/base-models/maintenance_request_model.dart';

class MaintenanceRequestItemView extends StatelessWidget {
  final MaintenanceRequestModel item;
  const MaintenanceRequestItemView({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(
          AppPaths.addMaintenanceRequestPage,
          arguments: {"id": item.id ?? "6"},
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 61.w,
            height: 70.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).scaffoldBackgroundColor,
              border: Border.all(
                color: Theme.of(context).focusColor,
                width: 2,
              ),
            ),
            child: SvgPicture.asset(
              item.iconLocalPath ?? "",
              height: 20,
              width: 50,
            ),
          ),
          const SizedBox(height: 5),
          Center(
            child: Text(
              item.type?.name.tr(context: context) ?? "",
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
            ),
          )
        ],
      ),
    );
  }
}
