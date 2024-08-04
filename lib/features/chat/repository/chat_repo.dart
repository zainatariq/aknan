import 'package:aknan_user_app/injection_container.dart';
import 'package:aknan_user_app/networking/api_service.dart';
import 'package:dio/dio.dart' as dm;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bases/pagination/model/pagination_api_model.dart';
import '../../../helpers/data_state.dart';
import '../../../networking/network_state.dart';
import '../constants/chat_constant.dart';
import '../controller/chat_controller.dart';
import '../controller/cubit/chat_cubit_cubit.dart';
import '../models/req/send_msg_req_model.dart';
import '../models/res/msg_chat_res_model_item.dart';

class ChatRepo {
  ChatRepo();

  ApiService _apiService = sl<ApiService>();

  Future<NetworkState<MsgChatResModel>> sendMsg(
    SendMsgReqModel req,
  ) async {
    return await _apiService.postNewMsg(await req.toMap());
  }
}
