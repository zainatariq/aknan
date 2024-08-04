import '../../../../bases/base-models/elevator_model.dart';
import '../../../../networking/api_service.dart';

import '../../../../bases/pagination/model/pagination_api_model.dart';
import '../../../../bases/pagination/use-case/main_paginate_list_use_case.dart';
import '../../../../helpers/data_state.dart';
import '../../../../injection_container.dart';
import '../model/get_elevators_by_id_req_model.dart';

// get_notifications_use_case

// get_elevators_by_id_use_case
class GetElevatorsByIdUseCase  implements
    NetWorkPaginateListUseCase<ElevatorModel, GetElevatorsByIdReqModel>
{
  GetElevatorsByIdUseCase(this.req);

  @override
  GetElevatorsByIdReqModel? req;

  setReq(GetElevatorsByIdReqModel req) {
    this.req = req;
  }

  @override
  Future<DataState<(PaginationApiModel, List<ElevatorModel>)>> invoke(
      {GetElevatorsByIdReqModel? parm}) async {
    assert(req != null, "Request should not be null");
    final state = await sl<ApiService>().getElevatorsById(
      req!.toMap(),
    );

    return state.whenOrNull(success: (data) {
          // print('data {}');

          List<ElevatorModel> list = data.data!;

          return DataSuccess((data.meta!, list));
        }, error: (error, _) {
          return DataFailedErrorMsg(error!, null);
        }) ??
        const DataFailedErrorMsg("error", null);
  }

  @override
  GetElevatorsByIdReqModel setPage(int page) {
    req!.page = page;
    req!.reqPage = page;
    return req!;
  }
}
