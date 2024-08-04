import '../../../../bases/pagination/model/pagination_api_model.dart';
import '../../../../bases/pagination/use-case/main_paginate_list_use_case.dart';
import '../../../../helpers/data_state.dart';
import '../../../../injection_container.dart';
import '../../../../networking/api_service.dart';
import '../../model/notification_model.dart';
import '../model/get_notification_req_model.dart';

// get_notifications_use_case
class GetNotificationsUseCase
    implements
        NetWorkPaginateListUseCase<NotificationModel, GetNotificationReqModel> {
  GetNotificationsUseCase(this.req);

  @override
  GetNotificationReqModel? req = GetNotificationReqModel(1);

  @override
  Future<DataState<(PaginationApiModel, List<NotificationModel>)>> invoke(
      {GetNotificationReqModel? parm}) async {
    // // final res = await DioUtilNew.dio!.get(
    // //   AppConstants.getNotification,
    // //   queryParameters: req?.toMap(),
    // // );

    // var res;
    // if (res.data['status'] == 200) {
    //   List<NotificationModel> list = [];
    //   for (Map<String, dynamic> element in res.data['data']) {
    //     list.add(NotificationModel.fromMap(element));
    //   }

    //   PaginationApiModel paginationApiModel =
    //       PaginationApiModel.fromJson(res.data['meta']);
    //   return DataSuccess((paginationApiModel, list));
    // } else {
    //   String msg = res.data['message'];
    //   return DataFailedErrorMsg(msg, null);
    // }

    assert(req != null, "Request should not be null");
    final state = await sl<ApiService>().getNotifications(
      req!.toMap(),
    );

    return state.whenOrNull(success: (data) {
          // print('data {}');

          List<NotificationModel> list = data.data!;

          return DataSuccess((data.meta!, list));
        }, error: (error, _) {
          return DataFailedErrorMsg(error!, null);
        }) ??
        const DataFailedErrorMsg("error", null);
 
 
  }

  @override
  GetNotificationReqModel setPage(int page) {
    req!.page = page;
    req!.reqPage = page;
    return req!;
  }
}
