import 'package:bloc/bloc.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../bases/base-models/base_id_value_model.dart';
import '../../../../../helpers/cache_helper.dart';
import '../../../../../helpers/helper.dart';
import '../../../../../helpers/navigation.dart';
import '../../../../../main.dart' show isJustUiTest;
import '../../../../../networking/api_service.dart';
import '../../../../../route/paths.dart';
import '../../../data/models/base_phone_req_model.dart';
import '../../../data/models/req-model/register_req_model.dart';
import '../../../data/models/res-models/malti_dropdown.dart';
import '../../../data/models/res-models/user_model.dart';
import '../../../domain/use-cases/auth_cases.dart';

part 'complete_data_cubit.freezed.dart';
part 'complete_data_state.dart';

class CompleteDataCubit extends Cubit<CompleteDataState> {
  final ApiService service;
  CompleteDataCubit(this.authCases, this.service)
      : super(const CompleteDataState.initial()) {
    getGovernment();
  }

  final AuthCases authCases;
  TextEditingController regNameController = TextEditingController();
  FocusNode regFirstNameFocusNode = FocusNode();

  TextEditingController regPhoneController = TextEditingController();
  FocusNode regPhoneFocusNode = FocusNode();
  TextEditingController regEmilController = TextEditingController();
  FocusNode regEmilFocusNode = FocusNode();
  TextEditingController regPassController = TextEditingController();
  FocusNode regPasswordFocusNode = FocusNode();
  TextEditingController regNewPassController = TextEditingController();
  FocusNode regNewPassFocusNode = FocusNode();

  CountryCode regSelectCountry = CountryCode.fromDialCode("+966");
  GlobalKey<FormState> signUpKey = GlobalKey<FormState>();

  initSignUp() {
    regNameController = TextEditingController();
    regFirstNameFocusNode = FocusNode();

    regPhoneController = TextEditingController();
    regPhoneFocusNode = FocusNode();
    regEmilController = TextEditingController();
    regEmilFocusNode = FocusNode();

    regPassController = TextEditingController();
    regPasswordFocusNode = FocusNode();

    regNewPassController = TextEditingController();
    regNewPassFocusNode = FocusNode();
  }

  void disposeSignUp() {
    for (var element in [
      regNameController,
      regFirstNameFocusNode,
      regPhoneController,
      regPhoneFocusNode,
      regEmilController,
      regEmilFocusNode,
      regPassController,
      regPasswordFocusNode,
      regNewPassController,
      regNewPassFocusNode,
    ]) {
      element.dispose();
    }
  }

  MaltiDropdown? governments;

  getGovernment() async {
    emit(const CompleteDataState.loading(false));
    final state = await service.getGovernorate();
    state.whenOrNull(
      success: (data) {
        governments = data;
        emit(CompleteDataState.getGovernment(data));
      },
    );
  }

  BaseIdNameModelString? _selectGovernment;
  BaseIdNameModelString? get selectGovernment => _selectGovernment;

  void onSelectGovernment(BaseIdNameModelString? id) {
    _selectGovernment = id;
    emit(const CompleteDataState.selectGovernment());
    getCity(_selectGovernment!.id!);
  }

  MaltiDropdown? cities;
  getCity(String id) async {
    emit(const CompleteDataState.loading(false));
    final state = await service.getCities(id);
    state.whenOrNull(
      success: (data) {
        cities = data;
        _selectCity = null;
        emit(CompleteDataState.getCity(data));
      },
    );
  }

  BaseIdNameModelString? _selectCity;
  BaseIdNameModelString? get selectCity => _selectCity;

  void onSelectCity(BaseIdNameModelString? id) {
    _selectCity = id;
    emit(const CompleteDataState.selectCity());
    getDistrict(_selectCity!.id!);
  }

  MaltiDropdown? district;
  getDistrict(String id) async {
    emit(const CompleteDataState.loading(false));
    final state = await service.getDistinct(id);
    state.whenOrNull(
      success: (data) {
        district = data;
        _selectDistrict = null;
        emit(CompleteDataState.getDistrict(data));
      },
    );
  }

  BaseIdNameModelString? _selectDistrict;
  BaseIdNameModelString? get selectDistrict => _selectDistrict;

  void onSelectDistrict(BaseIdNameModelString? id) {
    _selectDistrict = id;
    emit(const CompleteDataState.selectDistrict());
  }

  bool isLoadingSignUp = false;
  signUp(BuildContext context) async {
    if (isJustUiTest) {
      _toHome(context);
      return;
    }
    if (_validate()) {
      emit(const CompleteDataState.loading(true));
      final phoneData =
          BasePhoneReqModel.fromL(CacheHelper.getValue(kay: "phone"));

      AknanRegisterReqModel reqModel = AknanRegisterReqModel(
        cityId: _selectCity!.id!,
        districtId: _selectDistrict!.id!,
        email: regEmilController.text,
        governorateId: _selectGovernment!.id!,
        phoneReqModel: phoneData,
        name: regNameController.text,
        // lName: regLastNameController.text,
        password: regPassController.text,
      );

      final res = await authCases.register(reqModel);
      // isLoadingSignUp(false);

      checkStatus(
        res,
        onSuccess: (res) {
          CacheHelper.deleteOneValue(kay: "phone");
          UserAuthModel user = res!.data!.user!;
          authCases.setUserDate(user);
          _toHome(context);
          emit(const CompleteDataState.success());
        },
        onError: (res) {
          // Helper.showSnackBar(context, message: res!.message);
          emit(CompleteDataState.error(res?.message ?? ""));
        },
      );
    }
  }

  bool _validate() {
    if (_selectGovernment == null) {
      // TODO:
      // Helper.showSnackBar(context, message: "اختر المنطقة");
      return false;
    }
    if (_selectCity == null) {
      return false;
    }
    if (_selectDistrict == null) {
      return false;
    }

    return signUpKey.currentState!.validate();
  }

  static String authKey = "authKey";

  static bool get isAuthed => CacheHelper.getValue(kay: authKey) ?? false;

  void _toHome(BuildContext context) async {
    CacheHelper.setValue(kay: authKey, value: true)
        .whenComplete(() => context.pushNamedAndRemoveUntil(
              AppPaths.homeScreen,
              predicate: (route) => false,
            ));
  }
}
