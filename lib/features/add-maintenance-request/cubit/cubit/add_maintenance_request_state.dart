part of 'add_maintenance_request_cubit.dart';

@freezed
class AddMaintenanceRequestState with _$AddMaintenanceRequestState {
  const factory AddMaintenanceRequestState.initial() = _Initial;
  const factory AddMaintenanceRequestState.loading() = _Loading;
  const factory AddMaintenanceRequestState.getMalfunctions() = _GetMalfunctions;
  const factory AddMaintenanceRequestState.selectMalfunction(
      List<BaseIdNameModelString>? keys) = _SelectMalfunction;

  const factory AddMaintenanceRequestState.getTypesOfElevators() =
      _GetTypesOfElevators;
  const factory AddMaintenanceRequestState.selectTypeOfElevator(
     BaseIdNameModelString? key) = _SelectTypesOfElevator;
  const factory AddMaintenanceRequestState.selectDaT(DateTime? dateTime) =
      _selectDaT;

  const factory AddMaintenanceRequestState.submitRequest() = _SubmitRequest;
}
