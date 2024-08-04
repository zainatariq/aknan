import 'package:aknan_user_app/bases/pagination/state/pagination_bloc_state.dart';
import 'package:aknan_user_app/features/chat/message_screen.dart';
import 'package:aknan_user_app/helpers/navigation.dart';
import 'package:aknan_user_app/localization/change_language.dart';
import 'package:aknan_user_app/localization/locale_keys.g.dart';
import 'package:aknan_user_app/widgets/app_back_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bases/pagination/typedef/page_typedef.dart';
import '../../bases/pagination/widgets/paginations_widgets.dart';
import '../home-app/main-bg-page/cubit/main_bg_cubit.dart';
import '../notification/pagnaintion/model/get_notification_req_model.dart';
import 'controller/chat_controller.dart';
import 'models/req/get_chat_req_model.dart';
import 'pagienate-use-cases/get_list_of_chats_use_case.dart';
import 'repository/chat_repo.dart';
import 'widget/message_item.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.chats.tre),
        centerTitle: true,
        leading: AppBackBtn(onTap: () {
          MainBgCubit.get(context).toHome();
        }),
        // backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: BlocProvider(
          create: (context) => PaginateGetListOfChatsController(
            GetListOfChatsUseCase(GetChatReqModel(1)),
          )..startInitData(),
          child: BlocBuilder<PaginateGetListOfChatsController,
              PaginationBlocState>(
            builder: (context, state) {
              return PaginateGetListOfChatsView(
                paginatedLst: (list) =>
                    SmartRefresherApp<PaginateGetListOfChatsController>(
                  // controller:paginateGetElevatorsByIdController!,
                  controller: BlocProvider.of<PaginateGetListOfChatsController>(
                      context),
                  list: list,
                ),
                child: (entity) => MessageItem(
                  data: entity,
                  onTap: () {
                    context.push(MessageScreen(
                      maintenanceId: entity.maintenance?.id,
                    ));
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
