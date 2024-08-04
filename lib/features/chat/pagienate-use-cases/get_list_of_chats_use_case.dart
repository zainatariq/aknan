import '../../../bases/pagination/model/pagination_api_model.dart';
import '../../../bases/pagination/use-case/main_paginate_list_use_case.dart';
import '../../../helpers/data_state.dart';
import '../../../injection_container.dart';
import '../../../networking/api_service.dart';
import '../models/req/get_chat_req_model.dart';
import '../models/res/msg_chat_res_model_item.dart';

// get_list_of_chats_use_case
class GetListOfChatsUseCase
    implements
        NetWorkPaginateListUseCase<MsgChatResModelItem, GetChatReqModel> {
  @override
  GetChatReqModel? req = GetChatReqModel(1);
  GetListOfChatsUseCase(this.req);

  @override
  Future<DataState<(PaginationApiModel, List<MsgChatResModelItem>)>> invoke({
    GetChatReqModel? parm,
  }) async {
    assert(req != null, "Request should not be null");
    final state = await sl<ApiService>().getListOfChat(
      req!.toMap(),
    );

    return state.whenOrNull(success: (data) {
          List<MsgChatResModelItem> list = data.data;

          return DataSuccess((data.meta!, list));
        }, error: (error, _) {
          return DataFailedErrorMsg(error!, null);
        }) ??
        const DataFailedErrorMsg("error", null);
 
 
  }

  @override
  GetChatReqModel setPage(int page) {
    req!.reqPage = page;
    return req!;
  }
}
