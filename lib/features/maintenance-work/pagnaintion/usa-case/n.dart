import '../../../../bases/pagination/model/pagination_api_model.dart';
import '../../../../bases/pagination/use-case/main_paginate_list_use_case.dart';
import '../../../../helpers/data_state.dart';
import '../../../../injection_container.dart';
import '../../../../networking/api_service.dart';

import '../model/req/get_maintenance_work_req_model.dart';
import '../model/res/maintenance_work_res_model.dart';

// get_notifications_use_case
class GetMaintenanceWorkUseCase
    implements
        NetWorkPaginateListUseCase<MaintenanceWorkResData,
            GetMaintenanceWorkReqModel> {
  GetMaintenanceWorkUseCase(this.req);

  @override
  GetMaintenanceWorkReqModel? req;

  @override
  Future<DataState<(PaginationApiModel, List<MaintenanceWorkResData>)>> invoke(
      {GetMaintenanceWorkReqModel? parm}) async {
    // // final res = await DioUtilNew.dio!.get(
    // //   AppConstants.getNotification,
    // //   queryParameters: req?.toMap(),
    // // );

    // var res;
    // if (res.data['status'] == 200) {
    //   List<MaintenanceWorkResData> list = [];
    //   for (Map<String, dynamic> element in res.data['data']) {
    //     list.add(MaintenanceWorkResData.fromMap(element));
    //   }

    //   PaginationApiModel paginationApiModel =
    //       PaginationApiModel.fromJson(res.data['meta']);
    //   return DataSuccess((paginationApiModel, list));
    // } else {
    //   String msg = res.data['message'];
    //   return DataFailedErrorMsg(msg, null);
    // }

    assert(req != null, "Request should not be null");
    final state = await sl<ApiService>().getMaintenanceWorkOfElevator(
      req!.toMap(),
    );

    return state.whenOrNull(success: (data) {
          // print('data {}');

          List<MaintenanceWorkResData> list = data.data!;

          return DataSuccess((data.meta!, list));
        }, error: (error, _) {
          return DataFailedErrorMsg(error!, null);
        }) ??
        const DataFailedErrorMsg("error", null);
  }

  @override
  GetMaintenanceWorkReqModel setPage(int page) {
    req!.page = page;
    req!.reqPage = page;
    return req!;
  }
}
