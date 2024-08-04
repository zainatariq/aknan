// elevator_more_info_page
// elevator-more-info-page
import 'dart:convert';

import 'package:aknan_user_app/helpers/navigation.dart';
import 'package:aknan_user_app/localization/change_language.dart';
import 'package:aknan_user_app/route/paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../bases/base_state/base_cubit_state.dart';
import '../../../localization/locale_keys.g.dart';
import '../../../widgets/app_back_btn.dart';
import '../../../widgets/app_notification_widget.dart';
import '../../add-maintenance-request/model/user_elevators_list_res_model.dart';
import '../../home-app/pages/profile/ui/widget/elevator_widget.dart';
import '../../home-app/pages/profile/ui/widget/maintenance_work_btn.dart';
import '../../maintenance-work/ui/maintenance_work_page.dart';
import '../cubit/elevator_more_info_cubit.dart';
import '../model/new_maintenance_show_res.dart';

class ElevatorMoreInfoPage extends StatelessWidget {
  final ElevatorModelInList data;
  const ElevatorMoreInfoPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data.elevatorFullName ?? ""),
        leading: const AppBackBtn(),
        actions: const [AppNotificationWidget()],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: Column(
          children: [
            SizedBox(height: 30.h),
            SizedBox(
              child: ElevatorWidget(
                data: data,
                isMinSize: false,
                onTap: null,
              ),
            ),
            SizedBox(height: 200.h),
            CustomBtn2(
              onTap: () {
                // New-Maintenance
                context.push(MaintenanceWorkPage(
                  id: data.id!,
                ));
              },
              tittle: LocaleKeys.maintenance_work.tre,
            ),
            SizedBox(height: 15.h),
            BlocBuilder<ElevatorMoreInfoCubit,
                ICubitState<NewMaintenanceShowRes>>(
              bloc: ElevatorMoreInfoCubit.instance
                ..getNewMaintenanceShowRes(data.id!),
              builder: (context, state) {
                return Visibility(
                  visible: ElevatorMoreInfoCubit.instance.isEditElevatorPage,
                  child: CustomBtn2(
                    onTap: () =>
                        ElevatorMoreInfoCubit.instance.toEditElevatorPage(
                      context,
                      data.id!,
                      data.elevatorCode!
                    ),
                    tittle: LocaleKeys.maintenance_required.tre,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
