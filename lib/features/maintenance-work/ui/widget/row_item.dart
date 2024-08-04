// row_item
import 'package:aknan_user_app/date_converter.dart';
import 'package:aknan_user_app/helpers/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../bases/pagination/widgets/paginations_widgets.dart';
import '../../../../global/app-assets/assets.dart';
import '../../../damage-details/ui/damage_details_page.dart';
import '../../../home-app/pages/profile/ui/profile_sub_screen.dart';
import '../../pagnaintion/model/res/maintenance_work_res_model.dart';

class RowItem extends PaginationViewItem<MaintenanceWorkResData> {
  const RowItem({
    required super.data,
    super.key,
  });

  String get time => DateConverter.convertDateTimeToHM(data.dateTime!);
  String get date => DateConverter.convertDateTimeToStringDate(data.dateTime!);
  String get employee => data.name ?? "";
  String get cost => "${data.cost} \$";

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.labelMedium!.copyWith(
            overflow: TextOverflow.ellipsis,
          ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(time),
              Text(date),
            ],
          ),
          Text(employee),
          Text(cost),
          InkWell(
            onTap: () {
              context.push(DamagePage(
                maintenanceWorkResData: data,
              ));
            },
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
              child: Container(
                padding: const EdgeInsets.all(5),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Theme.of(context).hoverColor,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: SvgPicture.asset(Assets.imagesSvgsEyeBlue),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
