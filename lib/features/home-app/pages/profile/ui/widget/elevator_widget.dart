// elevator_widget
import 'package:aknan_user_app/date_converter.dart';
import 'package:aknan_user_app/localization/change_language.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../bases/pagination/widgets/paginations_widgets.dart';
import '../../../../../../global/app-assets/assets.dart';
import '../../../../../../global/theme/app-colors/app_colors_light.dart';
import '../../../../../../localization/locale_keys.g.dart';
import '../../../../../add-maintenance-request/model/user_elevators_list_res_model.dart';

class ElevatorWidget extends PaginationViewItem<ElevatorModelInList> {
  final bool isMinSize;
  final Function()? onTap;
  const ElevatorWidget({
    super.key,
    this.isMinSize = true,
    this.onTap,
    required super.data,
  });

  String get elevatorsName => data.elevatorFullName ?? "";
  String get maintenanceCountInMinWidget =>
      data.remainingMaintenance?.toString() ?? "";
  String get contractTypeValue => data.contractType ?? "";
  String get startDateValue =>
      DateConverter.convertDateTimeToStringDate(data.startDate);
  String get endDateValue =>
      DateConverter.convertDateTimeToStringDate(data.endDate);
  String get periodicMaintenanceCount =>
      data.periodicMaintenances?.toString() ?? "";
  String get emergencyMaintenanceCount =>
      data.emergencyMaintenances?.toString() ?? "";
  String get complaintMaintenanceCount =>
      data.complaintMaintenances?.toString() ?? "";

  String get elevatorCode => data.elevatorCode ?? "";

  Widget _probabilityLeadingWord(String svgPath, String keyWord, String value) {
    return Builder(builder: (context) {
      return DefaultTextStyle(
        style: Theme.of(context).textTheme.displayLarge!,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              svgPath,
              height: 15,
              width: 15,
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            const SizedBox(width: 10),
            Text(keyWord),
            const Spacer(),
            Text(value),
            const SizedBox(width: 20),
          ],
        ),
      );
    });
  }

  Widget _probabilityLeadingNum(String svgPath, String keyWord, String value) {
    return Builder(builder: (context) {
      return DefaultTextStyle(
        style: Theme.of(context).textTheme.displayLarge!,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              svgPath,
              height: 15,
              width: 15,
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            const SizedBox(width: 10),
            Text(keyWord),
            const Spacer(),
            Container(
              height: 20,
              width: 20,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                // borderRadius: BorderRadius.circular(20),
                shape: BoxShape.circle,
              ),
              child: Text(
                value,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            const SizedBox(width: 20),
          ],
        ),
      );
    });
  }

  Widget get minWidget => Builder(builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            ),
            color: Theme.of(context).hoverColor,
            child: Container(
              height: 75.h,
              width: MediaQuery.sizeOf(context).width - 20.w,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Theme.of(context).hoverColor,
                borderRadius: BorderRadius.circular(7),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    elevatorsName,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      width: 55.w,
                      height: 23.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SvgPicture.asset(Assets.imagesSvgsProfileElvetor),
                          Text(maintenanceCountInMinWidget),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });

  Widget get child => isMinSize ? minWidget : maxWidget;

  Widget get maxWidget => Builder(builder: (context) {
        return Container(
          width: MediaQuery.sizeOf(context).width - 20.w,
          margin: const EdgeInsets.symmetric(horizontal: 15),
          padding: const EdgeInsetsDirectional.only(
            start: 20,
            bottom: 20,
            top: 20,
          ),
          decoration: BoxDecoration(
              color: AppColorsLight.instance.primaryColorBlue,
              borderRadius: BorderRadius.circular(7),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).primaryColor.withOpacity(0.8),
                  blurRadius: 10,
                )
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  elevatorsName,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
              const SizedBox(height: 20),
              _probabilityLeadingWord(
                Assets.imagesSvgsContractTypeIco,
                LocaleKeys.contract_type.tre,
                contractTypeValue,
              ),
              const SizedBox(height: 20),
              _probabilityLeadingWord(
                Assets.imagesSvgsCalendar,
                LocaleKeys.start_date.tre,
                startDateValue,
              ),
              const SizedBox(height: 20),
              _probabilityLeadingWord(
                Assets.imagesSvgsCalendar,
                LocaleKeys.end_date.tre,
                endDateValue,
              ),
              const SizedBox(height: 20),
              _probabilityLeadingWord(
                Assets.imagesSvgsElev,
                LocaleKeys.elevator_code.tre,
                elevatorCode,
              ),
              const SizedBox(height: 20),
              _probabilityLeadingNum(
                Assets.imagesSvgsProfileElvetor,
                LocaleKeys.periodic_maintenance.tre,
                periodicMaintenanceCount,
              ),
              const SizedBox(height: 20),
              _probabilityLeadingNum(
                Assets.imagesSvgsProfileElvetor,
                LocaleKeys.emergency_maintenance.tre,
                emergencyMaintenanceCount,
              ),
              const SizedBox(height: 20),
              _probabilityLeadingNum(
                Assets.imagesSvgsProfileElvetor,
                LocaleKeys.complaint_maintenance.tre,
                complaintMaintenanceCount,
              ),
            ],
          ),
        );
      });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedCrossFade(
        firstChild: minWidget,
        secondChild: maxWidget,
        crossFadeState:
            isMinSize ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        duration: const Duration(milliseconds: 200),
        firstCurve: Curves.bounceIn,
        secondCurve: Curves.bounceOut,
        // sizeCurve: Curves.bounceInOut,
      ),
      // child: ,
    );
  }
}
