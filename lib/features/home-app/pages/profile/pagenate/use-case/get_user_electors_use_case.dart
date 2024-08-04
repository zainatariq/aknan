import '../model/get_user_elevetors_req_model.dart';
import '../../../../../../helpers/data_state.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../../../bases/pagination/model/pagination_api_model.dart';
import '../../../../../../bases/pagination/use-case/main_paginate_list_use_case.dart';
import '../../../../../../injection_container.dart';
import '../../../../../../networking/api_service.dart';
import '../../../../../add-maintenance-request/model/user_elevators_list_res_model.dart';

class GetUserElectorsUseCase
    implements
        NetWorkPaginateListUseCase<ElevatorModelInList,
            GetUserElevetorsReqModel> {
  GetUserElectorsUseCase(this.req);

  @override
  GetUserElevetorsReqModel? req = GetUserElevetorsReqModel(1);

  @override
  Future<DataState<(PaginationApiModel, List<ElevatorModelInList>)>> invoke(
      {GetUserElevetorsReqModel? parm}) async {
    assert(req != null, "Request should not be null");

    final state = await sl<ApiService>().getUserElevatorsList(
      isPaginate: true,
      queryParams: req!.toMap(),
    );

    return state.whenOrNull(success: (data) {
          List<ElevatorModelInList> list = data.data!;
          return DataSuccess((data.meta!, list));
        }, error: (error, _) {
          return DataFailedErrorMsg(error!, null);
        }) ??
        const DataFailedErrorMsg("error", null);
  }

  @override
  GetUserElevetorsReqModel setPage(int page) {
    req!.page = page;
    req!.reqPage = page;
    return req!;
  }
}
