import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:one_context/one_context.dart';

import '../../../bases/pagination/model/pagination_api_model.dart';
import '../../../bases/pagination/use-case/main_paginate_list_use_case.dart';
import '../../../helpers/data_state.dart';
import '../../../injection_container.dart';
import '../../../networking/DioClient.dart';
import '../../../networking/api_constants.dart';
import '../../../networking/api_service.dart';
import '../constants/chat_constant.dart';
import '../controller/chat_controller.dart';
import '../controller/cubit/chat_cubit_cubit.dart';
import '../models/req/get_chat_msgs_req_model.dart';
import '../models/res/msg_chat_res_model_item.dart';

class GetChatMsgsUseCase
    implements
        NetWorkPaginateListUseCase<MsgChatResModelItem, GetChatMsgsReqModel> {
  @override
  GetChatMsgsReqModel? req;
  BuildContext context;
  GetChatMsgsUseCase(this.req, this.context);

  @override
  Future<DataState<(PaginationApiModel, List<MsgChatResModelItem>)>> invoke(
      {GetChatMsgsReqModel? parm}) async {
    final state = await sl<ApiService>().getListOfMsgsInChat(
      _getAPILink,
      req!.toMap(),
    );

    return state.whenOrNull(success: (data) {
          List<MsgChatResModelItem> list = data.data.first.messages ?? [];

          BlocProvider.of<ChatCubitCubit>(context)
              .setChatStatus(data.data.first.canChat);

          return DataSuccess((PaginationApiModel(), list));
        }, error: (error, _) {
          if ((error?.contains("No Data Found") ?? false)) {
            List<MsgChatResModelItem> list = [];

            BlocProvider.of<ChatCubitCubit>(context).setChatStatus(false);

            return DataSuccess((PaginationApiModel(), list));
          }

          return DataFailedErrorMsg(error!, null);
        }) ??
        const DataFailedErrorMsg("error", null);

/*

  var controller = Get.find<ChatController>();
          controller.orderId.value = list.first.order?.id;

          controller.canChat(
            list.first.order?.canChatInOrder ?? true,
          );

 */
  }

  String get _getAPILink {
    if (req!.isInOrder) {
      return ChatConstant.getChatByOrder(req!.orderId!);
    }
    return "${ChatConstant.postSendMsg}/${req!.chatId}";
  }

  @override
  GetChatMsgsReqModel setPage(int page) {
    req!.reqPage = page;
    return req!;
  }
}
