//maintenance-work
// maintenance_work_page
import 'package:aknan_user_app/features/maintenance-work/pagnaintion/usa-case/n.dart';
import 'package:aknan_user_app/localization/change_language.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bases/pagination/state/pagination_bloc_state.dart';
import '../../../bases/pagination/typedef/page_typedef.dart';
import '../../../bases/pagination/widgets/paginations_widgets.dart';
import '../../../localization/locale_keys.g.dart';
import '../../../widgets/app_back_btn.dart';
import '../../../widgets/app_notification_widget.dart';
import '../pagnaintion/model/req/get_maintenance_work_req_model.dart';
import 'widget/row_item.dart';

class MaintenanceWorkPage extends StatelessWidget {
  final String id;
  const MaintenanceWorkPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.maintenance_work.tre),
        leading: const AppBackBtn(),
        actions: const [
          AppNotificationWidget(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: DefaultTextStyle(
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      overflow: TextOverflow.ellipsis,
                      fontSize: 13,
                    ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(LocaleKeys.time_and_date.tre),
                    Text(LocaleKeys.employee.tre),
                    Text(LocaleKeys.cost.tre),
                    Text(LocaleKeys.damage.tre),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
    Expanded(
              child: BlocProvider(
                create: (context) => PaginateGetMaintenanceWorkController(
                  GetMaintenanceWorkUseCase(
                    GetMaintenanceWorkReqModel(
                      1,
                      id: id,
                    ),
                  ),
                )..startInitData(),
                child: BlocBuilder<PaginateGetMaintenanceWorkController,
                    PaginationBlocState>(
                  builder: (context, state) {
                    return PaginateGetMaintenanceWorkView(
                      paginatedLst: (list) => SmartRefresherApp<
                          PaginateGetMaintenanceWorkController>(
                        controller: BlocProvider.of<
                            PaginateGetMaintenanceWorkController>(context),
                        list: list,
                      ),
                      child: (entity) => RowItem(data: entity),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
