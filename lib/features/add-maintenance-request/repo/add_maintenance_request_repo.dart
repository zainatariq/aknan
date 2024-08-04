import '../../../networking/api_service.dart';

import '../../../networking/network_state.dart';
import '../../authenticate/data/models/base_model.dart';
import '../../authenticate/data/models/res-models/malti_dropdown.dart';
import '../model/req/post_maintenance_req_model.dart';
import '../model/user_elevators_list_res_model.dart';

class AddMaintenanceRequestRepo {
  final ApiService _api;
  AddMaintenanceRequestRepo(this._api);

  Future<NetworkState<MaltiDropdown>> getMalfunctionsList() {
    return _api.getMalfunctionsList();
  }

  Future<NetworkState<UserElevatorsList>> getElevatorsList() {
    return _api.getUserElevatorsList();
  }

  Future<NetworkState<MsgModel>> addMaintenance(
    PostMaintenanceReqModel reqModel,
  ) {
    return _api.addMaintenance(reqModel.toApiMap());
  }

  Future<NetworkState<MsgModel>> updateMaintenance(
    PostMaintenanceReqModel reqModel,
    String maintenanceId,
  ) {
    return _api.updateMaintenance(
      id: maintenanceId,
      body: reqModel.toApiMap(),
    );
  }

  Future<NetworkState<MsgModel>> deleteMaintenance(String maintenanceId) {
    return _api.deleteMaintenance(id: maintenanceId);
  }
}
