import 'dart:developer';

import 'package:aknan_user_app/localization/change_language.dart';
import 'package:aknan_user_app/localization/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../bases/pagination/state/pagination_bloc_state.dart';
import '../../../../../bases/pagination/typedef/page_typedef.dart';
import '../../../../../bases/pagination/widgets/paginations_widgets.dart';
import '../../../../../helpers/navigation.dart';
import '../../../../../widgets/app_back_btn.dart';
import '../../../../../widgets/app_notification_widget.dart';
import '../../../../../widgets/app_page.dart';
import '../../../../elevator-more-info-page/page/elevator_more_info_page.dart';
import '../../../main-bg-page/cubit/main_bg_cubit.dart';
import '../cubit/profile_cubit.dart';
import '../pagenate/model/get_user_elevetors_req_model.dart';
import '../pagenate/use-case/get_user_electors_use_case.dart';
import 'widget/elevator_widget.dart';
import 'widget/profile_widget_item_data.dart';

class ProfileSubScreen extends AppScaffold<ProfileCubit> {
  const ProfileSubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    log('');

    return Scaffold(
      appBar: AppBar(
        title:  Text(LocaleKeys.my_profile.tre),
        leading: AppBackBtn(
          onTap: () {
            MainBgCubit.get(context).toHome();
          },
        ),
        actions: const [
          AppNotificationWidget(),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const ProfileWidgetItemData(),
          const SizedBox(height: 10),
          Expanded(
            child: BlocProvider(
              create: (context) => PaginateGetUserElectorsController(
                GetUserElectorsUseCase(GetUserElevetorsReqModel(1)),
              )..startInitData(),
              child: BlocBuilder<PaginateGetUserElectorsController,
                  PaginationBlocState>(
                builder: (context, state) {
                  return PaginateGetUserElectorsView(
                    paginatedLst: (list) =>
                        SmartRefresherApp<PaginateGetUserElectorsController>(
                      // controller:paginateGetElevatorsByIdController!,
                      controller:
                          BlocProvider.of<PaginateGetUserElectorsController>(
                              context),
                      list: list,
                    ),
                    child: (entity) {
                      return ElevatorWidget(
                        data: entity,
                        isMinSize: true,
                        onTap: () {
                          context.push(
                            ElevatorMoreInfoPage(
                              data: entity,
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}



