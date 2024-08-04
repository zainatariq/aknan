import '../../../injection_container.dart';
import '../../../networking/api_service.dart';

import '../../../helpers/data_state.dart';
import '../model/main_req_entity.dart';
import '../model/pagination_api_model.dart';

abstract class MainPaginateListUseCase<E, P extends MainPaginateRequestEntity?> {
  P? req;

  P setPage(int page);
  MainPaginateListUseCase(this.req);
  Future<DataState<(PaginationApiModel, List<E>)>> invoke({P? parm});
}

abstract class NetWorkPaginateListUseCase<E, P extends MainPaginateRequestEntity?>
// abstract class NetWorkPaginateListUseCase<E, P extends MainPaginateRequestEntity?>
    implements MainPaginateListUseCase<E, P> {
  @override
  P? req;

  @override
  Future<DataState<(PaginationApiModel, List<E>)>> invoke({P? parm}) async {
    return invoke(parm: parm);
    // ActionCenter actionCenter = Get.find<ActionCenter>();
    // bool netState = await actionCenter.execute(() {}, checkConnection: true);
    // if (netState) {
    //   try {
    //     return call(parm: parm);
    //   } catch (e) {
    //     return DataFailedErrorMsg(
    //       "e :: ${e.toString()}",
    //       (PaginationApiModel(), []),
    //     );
    //   }
    // } else {print("e ::  ");
    //   return DataFailedErrorMsg("No internet connection", (PaginationApiModel(), []));
    //       // "No internet connection", (PaginationApiModel(), []));
    // }
  }
}


class T{
    f(){}
}
abstract class Test < Z ,M extends T >{

}
