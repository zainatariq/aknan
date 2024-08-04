// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:aknan_user_app/helpers/cache_helper.dart';
import 'package:aknan_user_app/main.dart' show isJustUiTest;
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../../helpers/helper.dart';
import '../../../../../helpers/navigation.dart';
import '../../../../../route/paths.dart';
import '../../../data/models/base_phone_req_model.dart';
import '../../../data/models/req-model/login_with_otp_model.dart';
import '../../../data/models/req-model/verify_phone_req_model.dart';
import '../../../domain/use-cases/auth_cases.dart';
import '../../../enums/auth_enums.dart';

part 'verfictaion_screen_state.dart';

class VerificationScreenCubit extends Cubit<VerificationScreenState> {
  VerificationScreenCubit(this.authCases) : super(VerificationScreenInitial()) {
    initVerificationScreen();
  }

  final AuthCases authCases;

  @override
  Future<void> close() {
    disposeVerificationScreen();
    return super.close();
  }

  /// [VerificationScreen]

  String updateVerificationCode = '';

  bool _isVerificationIsLoading = false;
  bool get isVerificationIsLoading => _isVerificationIsLoading;
  bool _isVisibleBtn = false;
  bool get isVisibleBtn => _isVisibleBtn;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  changeLoading(bool state) {
    _isVerificationIsLoading = state;
    emit(VerificationScreenLoadState(loadState: state));
  }

  changeTime(String min, String second) {
    emit(VerificationScreenTimerState(min: min, second: second));
  }

  changeViewStateTime() {
    emit(VerificationScreenTimerViewState(viewState: isCounting));
  }

  changeViewStateBtn(String text) {
    if (text.length == 4) {
      _isVisibleBtn = true;
      emit(
        VerificationScreenSendBtnViewState(viewState: _isVisibleBtn),
      );
    } else {
      if (!isVisibleBtn) {
        return;
      } else {
        _isVisibleBtn = false;
        emit(
          VerificationScreenSendBtnViewState(viewState: _isVisibleBtn),
        );
      }
    }
  }

  String min = '00';
  String second = '00';
  bool _isCounting = false;
  bool get isCounting => _isCounting;

  Timer? countdownTimer;
  Duration waitingDuration = const Duration(seconds: 59);
  TextEditingController otpCodeController = TextEditingController();

  void disposeVerificationScreen() {
    countdownTimer?.cancel();
    waitingDuration = const Duration(seconds: 59);
    _isCounting = false;
    changeLoading(false);
    otpCodeController.dispose();
    emit(VerificationScreenResendBtnState(reSendBtnState: _isCounting));
  }

  void initVerificationScreen() {
    otpCodeController = TextEditingController();
    countdownTimer?.cancel();
    waitingDuration = const Duration(seconds: 59);
    startTimer();
    _isVisibleBtn = false;
    changeLoading(false);
  }

  void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
    _isCounting = true;
    emit(VerificationScreenResendBtnState(reSendBtnState: _isCounting));
  }

  void setCountDown() {
    const reduceSecondsBy = 1;
    final seconds = waitingDuration.inSeconds - reduceSecondsBy;
    if (seconds < 0) {
      countdownTimer!.cancel();
      _isCounting = false;

      changeTime(min, second);
      emit(VerificationScreenResendBtnState(reSendBtnState: _isCounting));
    } else {
      waitingDuration = Duration(seconds: seconds);
      _isCounting = true;
    }
    min = waitingDuration.inMinutes.toString().padLeft(2, '0');
    second = waitingDuration.inSeconds.toString().padLeft(2, '0');
    emit(VerificationScreenResendBtnState(reSendBtnState: _isCounting));
    changeTime(min, second);
  }

  reSendMsg(String countryCode, String phone) async {
    waitingDuration = const Duration(seconds: 59);
    countdownTimer?.cancel();

    emit(VerificationScreenResendBtnState(reSendBtnState: _isCounting = false));

    waitingDuration = const Duration(seconds: 59);
    startTimer();
    changeLoading(true);
    var req = BasePhoneReqModel(phoneCode: countryCode, phone: phone);
    final res = await authCases.sendOtp(req);
    changeLoading(false);

    checkStatus(
      res,
      onSuccess: (res) {
        //  showCustomSnackBar(Strings.otpSentSuccessfully.tr, isError: false);
        otpCodeController.clear();
        waitingDuration = const Duration(seconds: 59);
        startTimer();
      },
    );
  }

  checkOtpCode(
    String phone,
    String phoneCode, {
    required Function() onCheckSuccess,
  }) async {
    changeLoading(true);
    final req = LoginWithOtpReqModel(
      phoneReqModel: BasePhoneReqModel(phone: phone, phoneCode: phoneCode),
      otp: otpCodeController.text,
    );

    final res = await authCases.checkOtpCode(req);
    changeLoading(false);
    checkStatus(
      res,
      onSuccess: (res) {
        if (res!.stateData!["status"] == true) {
          emit(const VerificationScreenSuccess());
          onCheckSuccess();
        } else {
          emit(VerificationScreenError(res.message ?? ""));
          //  showCustomSnackBar(Strings.invalidOtp.tr, isError: true);
        }
      },
    );
  }

  void onPressSendBtn(
    BuildContext context,
    OtpState otpState,
    String number,
    String countryCode,
  ) {
    if (_validate()) {
      switch (otpState) {
        // case OtpState.register:
        // verifyPhone(number, countryCode);
        case OtpState.forgetPassword:
          onForgetPasswordCase(number, countryCode, context);
        case OtpState.loginWithOtp:
          // loginWithOtp(number, countryCode, context);
          verifyPhone(number, countryCode, context);
      }
    }
  }

  bool _validate() => formKey.currentState?.validate() ?? false;

  onForgetPasswordCase(
      String number, String countryCode, BuildContext context) {
    if (isJustUiTest) {
      Map<String, dynamic> args = {};
      args['countryCode'] = countryCode;
      args['phone'] = number;
      args['fromChangePassword'] = false;
      args['otpCode'] = updateVerificationCode;
      context.pushReplacementNamed(AppPaths.changePassScreen, arguments: args);
      return;
    }
    checkOtpCode(
      number,
      countryCode,
      onCheckSuccess: () {
        Map<String, dynamic> args = {};
        args['countryCode'] = countryCode;
        args['phone'] = number;
        args['fromChangePassword'] = false;
        args['otpCode'] = otpCodeController.text;
        context.pushReplacementNamed(AppPaths.changePassScreen,
            arguments: args);
      },
    );
  }

  void verifyPhone(String phone, String phoneCode, BuildContext context) async {
    if (isJustUiTest) {
      _toSignUp(context);
      return;
    }

    changeLoading(true);
    final phoneData=BasePhoneReqModel(phone: phone, phoneCode: phoneCode);
    final req = VerifyPhoneReqModel(
      phoneReqModel: phoneData,
      phoneConfirmationToken: otpCodeController.text,
    );
    final res = await authCases.verifyPhone(req);
    changeLoading(false);
    checkStatus(res, onSuccess: (res) async {
      // await authCases.setUserDate(res!.user!);
      _savePhoneToLocal(phoneData);
      emit(const VerificationScreenSuccess());

      _toSignUp(context);
    }, onError: (res) async {
      //  showCustomSnackBar(res!.msg ?? "");
      emit(VerificationScreenError(res?.message ?? ""));
    });
  }

  void _savePhoneToLocal(BasePhoneReqModel phoneData) {
    CacheHelper.setValue(kay: "phone", value: phoneData.toL());
  }

static  bool get isHaveSavedPhone=> CacheHelper.getValue(kay: "phone") != null;

  void loginWithOtp(
      String phone, String phoneCode, BuildContext context) async {
    if (kDebugMode) {
      _toSignUp(context);
      return;
    }

  

    changeLoading(true);
    final req = LoginWithOtpReqModel(
      phoneReqModel: BasePhoneReqModel(phone: phone, phoneCode: phoneCode),
      otp: updateVerificationCode,
    );
    final res = await authCases.loginWithOtp(req);
    changeLoading(false);
    checkStatus(
      res,
      onSuccess: (res) async {
        await authCases.setUserDate(res!.user!);
        _toSignUp(context);
      },
    );
  }

  void _toSignUp(BuildContext context) {
    context.pushReplacementNamed(
      AppPaths.signUp,
    );
  }
}
