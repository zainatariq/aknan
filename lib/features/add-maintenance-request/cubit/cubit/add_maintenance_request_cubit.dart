// ignore_for_file: unnecessary_getters_setters

import 'package:aknan_user_app/localization/change_language.dart';
import 'package:one_context/one_context.dart';

import '../../../../localization/locale_keys.g.dart';
import '../../../authenticate/data/models/base_model.dart';
import '../../repo/add_maintenance_request_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../bases/base-models/base_id_value_model.dart';
import '../../../../bases/base_mixns/state_mapper.dart';
import '../../../../bases/base_state/base_cubit_state.dart';
import '../../../../helpers/navigation.dart';
import '../../../../injection_container.dart';
import '../../../authenticate/data/models/res-models/malti_dropdown.dart';
import '../../../home-app/pages/Settings/model/setting_model.dart';
import '../../../../bases/base_view_cubit/base_cubit.dart';

import '../../model/req/post_maintenance_req_model.dart';
import '../../model/user_elevators_list_res_model.dart';

part 'add_maintenance_request_cubit.freezed.dart';
part 'add_maintenance_request_state.dart';

class AddMaintenanceRequestCubit extends Cubit<AddMaintenanceRequestState> {
  static AddMaintenanceRequestCubit get instance =>
      sl<AddMaintenanceRequestCubit>();
  AddMaintenanceRequestCubit()
      : super(const AddMaintenanceRequestState.initial());

  DateTime? _selectedDate;

  DateTime? get selectedDate => _selectedDate;

  String? _maintenanceTypeId;

  PostMaintenanceReqModel? postReq;

  set maintenanceTypeId(String? id) {
    _maintenanceTypeId = id;
  }

  String? get maintenanceTypeId => _maintenanceTypeId;

  bool? _isEdit;

  set isEdit(bool? id) {
    _isEdit = id;
  }

  bool? get isEdit => _isEdit;

  makeEdit(PostMaintenanceReqModel? req) {
    if (req == null) {
      return;
    }
    postReq = req;
    isEdit = true;
    _maintenanceTypeId = req.maintenanceTypeId;

    if (allMalfunctions.isEmpty) {
      AddMaintenanceRequestNetCubit.instance.getMalfunctionsList();
    }

    if (allTypesOfElevator.isEmpty) {
      AddMaintenanceRequestNetCubit.instance.getElevatorsList();
    }

    List<BaseIdNameModelString> selectedMalfunctions = [];

    if ((req.malfunctions != null && (req.malfunctions?.isNotEmpty ?? false))) {
      for (var i = 0; i < req.malfunctions!.length; i++) {
        var item = req.malfunctions![i];

        var sortItem = allMalfunctions.firstWhere(
          (element) => element.id == item,
          orElse: () => BaseIdNameModelString.defaultItem(),
        );
        if (sortItem != BaseIdNameModelString.defaultItem()) {
          selectedMalfunctions.add(sortItem);
        }
      }
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // executes after build
        selectMalfunction(selectedMalfunctions);
      });
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // executes after build
      selectTypeOfElevator(
        allTypesOfElevator.firstWhere(
          (element) {
            return element.id == req.contractId;
          },
        ),
      );
    });

    commentController.text = req.damageNote ?? "";
    _selectedDate = req.dateTime;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // executes after build
      emit(AddMaintenanceRequestState.selectDaT(_selectedDate!));
    });
  }

  selectDateAndTime(BuildContext context) async {
    DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100, 7),
      helpText: 'Select a date',
    );

    if (newDate == null) {
    } else {
// Call when you want to show the time picker
      final TimeOfDay? newTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (newTime == null) {
      } else {
        newDate = newDate.copyWith(
          hour: newTime.hour,
          minute: newTime.minute,
        );
        if (kDebugMode) {
          print(" newDate $newDate ");
        }
        _selectedDate = newDate;
        emit(AddMaintenanceRequestState.selectDaT(_selectedDate!));
      }
    }
  }

  List<BaseIdNameModelString> _allMalfunctions = [
    // ...List.generate(6, (index) => "Malfunctions $index")
  ];

  set allMalfunctions(List<BaseIdNameModelString> value) {
    _allMalfunctions = value;
    emit(const AddMaintenanceRequestState.selectMalfunction([]));
  }

  List<BaseIdNameModelString> get allMalfunctions => _allMalfunctions;

  List<BaseIdNameModelString> _selectedMalfunctions = [];
  List<BaseIdNameModelString> get selectedMalfunctions => _selectedMalfunctions;

  void selectMalfunction(List<BaseIdNameModelString> keys) {
    if (keys.isEmpty) {
      _selectedMalfunctions = [];
      emit(const AddMaintenanceRequestState.selectMalfunction(null));
      return;
    }
    _selectedMalfunctions = [];
    emit(AddMaintenanceRequestState.selectMalfunction(_selectedMalfunctions));
    _selectedMalfunctions = keys;
    emit(AddMaintenanceRequestState.selectMalfunction(_selectedMalfunctions));
  }

  List<BaseIdNameModelString> _allTypesOfElevator = [];
  List<BaseIdNameModelString> get allTypesOfElevator => _allTypesOfElevator;
  set allTypesOfElevator(List<BaseIdNameModelString> value) {
    _allTypesOfElevator = value;
    emit(const AddMaintenanceRequestState.selectMalfunction([]));
  }

  BaseIdNameModelString? _selectedTypesOfElevator;
  BaseIdNameModelString? get selectedTypesOfElevator =>
      _selectedTypesOfElevator;

  void selectTypeOfElevator(BaseIdNameModelString? key) {
    print('key ${key?.toMap()}');

    _selectedTypesOfElevator = key;
    postReq?.elevatorCode = key?.data.toString();
    emit(AddMaintenanceRequestState.selectTypeOfElevator(
        _selectedTypesOfElevator));
  }

  void submitRequest(BuildContext context) {
    if (validate(context)) {
      if (isEdit == true) {
        postReq = postReq!.copyWith(
          contractId: _selectedTypesOfElevator!.id,
          dateTime: _selectedDate,
          damageNote: _commentController.text,
          maintenanceTypeId: _maintenanceTypeId,
          malfunctions:
              _selectedMalfunctions.map((e) => e.id.toString()).toList(),
        );

        AddMaintenanceRequestNetCubit.instance.updateMaintenance(
          postReq!,
          () {
            initPage();
            context.pop();
          },
        );
      } else {
        postReq = PostMaintenanceReqModel(
          contractId: _selectedTypesOfElevator!.id,
          dateTime: _selectedDate,
          damageNote: _commentController.text,
          maintenanceTypeId: _maintenanceTypeId,
          malfunctions:
              _selectedMalfunctions.map((e) => e.id.toString()).toList(),
        );
        AddMaintenanceRequestNetCubit.instance.addMaintenance(postReq!, () {
          initPage();
          context.pop();
        });
      }
    }
  }

  void deleteRequest(BuildContext context) {
    AddMaintenanceRequestNetCubit.instance.deleteMaintenance(
      postReq!.editId!,
      () {
        initPage();
        context.pop();
      },
    );
  }

  initPage() {
    _selectedDate = null;
    maintenanceTypeId = null;
    isEdit = false;
    _commentController.clear();

    selectMalfunction([]);
    selectTypeOfElevator(null);
    emit(const AddMaintenanceRequestState.selectDaT(null));
  }

  final TextEditingController _commentController = TextEditingController();
  TextEditingController get commentController => _commentController;

  bool validate(BuildContext context) {
    if (_selectedMalfunctions.isEmpty) {
      context.showError(LocaleKeys.select_faults.tre);
      return false;
    }
    if (_selectedTypesOfElevator == null) {
      context.showError(LocaleKeys.select_elevator_type.tre);
      return false;
    }
    if (_selectedDate == null) {
      context.showError(LocaleKeys.select_date.tre);
      return false;
    }
    if (_commentController.text.trim().isEmpty) {
      context.showError(LocaleKeys.write_notes.tre);
      return false;
    }
    return true;
  }
}

class AddMaintenanceRequestNetCubit extends ICubit<dynamic>
    with UiState<dynamic> {
  final AddMaintenanceRequestRepo _repo;
  AddMaintenanceRequestNetCubit(
    this._repo,
  ) {
    getMalfunctionsList();

    getElevatorsList();
  }

  MaltiDropdown? malfunctionsList;
  static AddMaintenanceRequestNetCubit get instance =>
      sl<AddMaintenanceRequestNetCubit>();
  getMalfunctionsList() async {
    if (malfunctionsList != null) {
      return;
    }
    emit(const ICubitState.loading());
    final response = await _repo.getMalfunctionsList();
    final state = mapNetworkState(response);
    emit(state);
    state.whenOrNull(success: (data) {
      malfunctionsList = data;
      AddMaintenanceRequestCubit.instance.allMalfunctions =
          malfunctionsList!.data!;
    });
  }

  UserElevatorsList? elevatorsList;
  getElevatorsList() async {
    if (elevatorsList != null) {
      return;
    }
    emit(const ICubitState.loading());
    final response = await _repo.getElevatorsList();
    final state = mapNetworkState(response);
    emit(state);
    state.whenOrNull(success: (data) {
      elevatorsList = data;
      AddMaintenanceRequestCubit.instance.allTypesOfElevator =
          elevatorsList!.data!.map((e) => e.toBaseIdNameModelString()).toList();
    });
  }

  addMaintenance(PostMaintenanceReqModel req, Function() whenSuccess) async {
    emit(const ICubitState.loading());
    final response = await _repo.addMaintenance(req);
    final state = mapNetworkState(response);
    emit(state);
    state.whenOrNull(
      success: (data) {
        OneContext().context?.showSuccess((data as MsgModel).message!);
        whenSuccess.call();
        return null;
      },
      error: (error, _) {},
    );
  }

  updateMaintenance(PostMaintenanceReqModel req, Function() whenSuccess) async {
    emit(const ICubitState.loading());
    final response = await _repo.updateMaintenance(req, req.editId ?? "");
    final state = mapNetworkState(response);
    emit(state);
    state.whenOrNull(
      success: (data) {
        OneContext().context?.showSuccess((data as MsgModel).message!);
        whenSuccess.call();
        return null;
      },
      error: (error, _) {},
    );
  }

  deleteMaintenance(String id, Function() whenSuccess) async {
    emit(const ICubitState.loading());
    final response = await _repo.deleteMaintenance(id);
    final state = mapNetworkState(response);
    emit(state);
    state.whenOrNull(
      success: (data) {
        OneContext().context?.showSuccess((data as MsgModel).message!);
        whenSuccess.call();
        return null;
      },
      error: (error, _) {},
    );
  }
}
