import 'package:aknan_user_app/helpers/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bases/pagination/state/pagination_bloc_state.dart';
import '../../../bases/pagination/typedef/page_typedef.dart';
import '../../../bases/pagination/widgets/paginations_widgets.dart';
import '../../../global/theme/app-colors/app_colors_light.dart';
import '../../../localization/change_language.dart';
import '../../../localization/locale_keys.g.dart';
import '../../../widgets/app_back_btn.dart';
import '../../../widgets/app_notification_widget.dart';
import '../../../widgets/app_page.dart';
import '../../chat/message_screen.dart';
import '../cubit/notification_cubit.dart';
import '../model/notification_model.dart';
import '../pagnaintion/model/get_notification_req_model.dart';
import '../pagnaintion/use-case/get_notifications_use_case.dart';

class NotificationScreen extends AppScaffold<NotificationCubit> {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.notification.tre),
          leading: const AppBackBtn(),
          actions: [
            AppNotificationWidget(
              onTap: () {},
            )
          ],
        ),
        // body: ListView.separated(
        //   physics: const BouncingScrollPhysics(),
        //   padding: const EdgeInsets.symmetric(vertical: 10),
        //   itemCount: 10,
        //   separatorBuilder: (BuildContext context, int index) {
        //     return const SizedBox(height: 10);
        //   },
        //   itemBuilder: (BuildContext context, int index) {
        //     return NotificationItemWidget(
        //       data: NotificationModel(),
        //     );
        //   },
        // ),

        body: BlocProvider(
          create: (context) => PaginateGetNonfictionController(
            GetNotificationsUseCase(GetNotificationReqModel(1)),
          )..startInitData(),
          child:
              BlocBuilder<PaginateGetNonfictionController, PaginationBlocState>(
            builder: (context, state) {
              return PaginateGetNonfictionView(
                paginatedLst: (list) =>
                    SmartRefresherApp<PaginateGetNonfictionController>(
                  // controller:paginateGetElevatorsByIdController!,
                  controller:
                      BlocProvider.of<PaginateGetNonfictionController>(context),
                  list: list,
                ),
                child: (entity) => NotificationItemWidget(data: entity),
              );
            },
          ),
        ),
      ),
    );
  }
}

class NotificationItemWidget extends PaginationViewItem<NotificationModel> {
  const NotificationItemWidget({super.key, required super.data});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (data.maintenanceIdOnChat != null) {
          context.push(MessageScreen(
            maintenanceId: data.maintenanceIdOnChat,
          ));
        }
      },
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: Theme.of(context).hoverColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DefaultTextStyle(
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    color: AppColorsLight.instance.primaryColorBlue,
                  ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(data.date),
                  Text(data.time),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Text(
              data.text,
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColorsLight.instance.primaryColorBlue,
                  ),
              overflow: TextOverflow.visible,
            )
          ],
        ),
      ),
    );
  }
}
