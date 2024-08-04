import '../../../networking/api_service.dart';
import '../../../networking/network_state.dart';
import '../model/new_maintenance_show_res.dart';

class ElevatorMoreInfoRepo {
  final ApiService _apiService;
  ElevatorMoreInfoRepo(
    this._apiService,
  );

  Future<NetworkState<NewMaintenanceShowRes>> getNewMaintenanceShowRes(
      String elevatorId) {
    return _apiService.getNewMaintenanceShowRes(elevatorId: elevatorId);
  }
}
