import 'dart:convert';

import 'package:aknan_user_app/helpers/navigation.dart';
import 'package:aknan_user_app/route/paths.dart';
import 'package:flutter/material.dart';

import '../../../bases/base_mixns/state_mapper.dart';
import '../../../bases/base_state/base_cubit_state.dart';
import '../../../injection_container.dart';
import '../model/new_maintenance_show_res.dart';
import '../repo/elevator_more_info_repo.dart';
import '../../../bases/base_view_cubit/base_cubit.dart';

class ElevatorMoreInfoCubit extends ICubit<NewMaintenanceShowRes>
    with UiState<NewMaintenanceShowRes> {
  final ElevatorMoreInfoRepo _repo;
  ElevatorMoreInfoCubit(
    this._repo,
  );
  static ElevatorMoreInfoCubit get instance => sl<ElevatorMoreInfoCubit>();

  NewMaintenanceShowRes? newMaintenanceShowRes;
  void toEditElevatorPage(
      BuildContext context, String elevatorId, String elevatorCode) {
    Map<String, dynamic> args = {};
    args["id"] = newMaintenanceShowRes!.data!.id!;
    args["data"] = json.encode(
      newMaintenanceShowRes?.data!
          .toEditModel(elevatorId, elevatorCode)
          .toMap(),
    );

    context.pushReplacementNamed(
      AppPaths.addMaintenanceRequestPage,
      arguments: args,
    );
  }

  bool isEditElevatorPage = false;

  getNewMaintenanceShowRes(String id) async {
    isEditElevatorPage = false;
    emit(const ICubitState.loading());
    final response = await _repo.getNewMaintenanceShowRes(id);
    final state = mapNetworkState(response);
    emit(state);
    state.whenOrNull(
      success: (data) {
        newMaintenanceShowRes = data;
        isEditElevatorPage = newMaintenanceShowRes!.data != null;
      },
    );
  }
}
