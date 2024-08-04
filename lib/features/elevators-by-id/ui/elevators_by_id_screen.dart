import 'dart:math';

import '../../../global/theme/app-colors/app_colors_dark.dart';
import '../../../global/theme/app-colors/app_colors_light.dart';
import '../../../helpers/navigation.dart';

import '../../../bases/base-models/elevator_model.dart';
import '../../../widgets/app_notification_widget.dart';
import '../pagnaintion/model/get_elevators_by_id_req_model.dart';
import '../../../injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bases/pagination/controller/pagination_controller.dart';
import '../../../bases/pagination/state/pagination_bloc_state.dart';
import '../../../bases/pagination/typedef/page_typedef.dart';
import '../../../bases/pagination/widgets/paginations_widgets.dart';
import '../../../localization/change_language.dart';
import '../../../localization/locale_keys.g.dart';
import '../../../widgets/app_back_btn.dart';
import '../../home-app/pages/home/ui/widget/elevator_view_item.dart';
import '../pagnaintion/use-case/get_elevators_by_id_use_case.dart';

// elevators_by_id_screen
class ElevatorsByIdScreen extends StatelessWidget {
  final ElevatorModel elevatorModel;
  const ElevatorsByIdScreen({super.key, required this.elevatorModel});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(elevatorModel.name ?? ""),
          leading: const AppBackBtn(),
          actions: const [AppNotificationWidget()],
        ),
        body: BlocProvider(
          create: (context) => PaginateGetElevatorsByIdController(
            GetElevatorsByIdUseCase(
              GetElevatorsByIdReqModel(1, elevatorModel.id!),
            ),
          )..startInitData(),
          child: BlocBuilder<PaginateGetElevatorsByIdController,
              PaginationBlocState>(
            builder: (context, state) {
              return PaginateGetElevatorsByIdView(
                paginatedLst: (list) =>
                    SmartRefresherApp<PaginateGetElevatorsByIdController>(
                  // controller:paginateGetElevatorsByIdController!,
                  controller:
                      BlocProvider.of<PaginateGetElevatorsByIdController>(
                          context),
                  list: list,
                ),
                child: (entity) => ElevatorsByIdItemWidget(data: entity),
              );
            },
          ),
        ),
      ),
    );
  }
}

class ElevatorsByIdItemWidget extends PaginationViewItem<ElevatorModel> {
  const ElevatorsByIdItemWidget({super.key, required super.data});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push(
          ElevatorDetailsPage(
            item: data,
          ),
        );
      },
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: Theme.of(context).hoverColor,
        ),
        child: Text(
          data.name ?? "",
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(color: AppColorsLight.instance.primaryColorBlue),
        ),
      ),
    );
  }
}
