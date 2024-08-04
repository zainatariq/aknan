import 'package:bloc/bloc.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../../helpers/helper.dart';
import '../../../../../helpers/navigation.dart';
import '../../../../../main.dart' show isJustUiTest;
import '../../../../../route/paths.dart';
import '../../../data/models/base_model.dart';
import '../../../data/models/base_phone_req_model.dart';
import '../../../domain/use-cases/auth_cases.dart';
import '../../../enums/auth_enums.dart';

part 'otp_log_in_screen_state.dart';

class OtpLogInScreenCubit extends Cubit<OtpLogInScreenState> {
  OtpLogInScreenCubit(this.authCases) : super(OtpLogInScreenInitial()) {
    initOtpScreen();
  }

  @override
  Future<void> close() {
    disposeOtpScreen();
    return super.close();
  }

  TextEditingController phoneControllerForOTPLogInScreen =
      TextEditingController();
  FocusNode nodeForOTPLogInScreen = FocusNode();
  CountryCode otpSelectCountry = CountryCode.fromDialCode("+966");

  bool otpLoginIsLoading = false;
  GlobalKey<FormState> otpScreenKey =
      GlobalKey<FormState>(debugLabel: "otpScreenKey");

  AuthCases authCases;

  initOtpScreen() {
    phoneControllerForOTPLogInScreen = TextEditingController();
    nodeForOTPLogInScreen = FocusNode();
    otpSelectCountry = CountryCode.fromDialCode("+966");

    otpLoginIsLoading = false;
  }

  void disposeOtpScreen() {
    phoneControllerForOTPLogInScreen.dispose();
    nodeForOTPLogInScreen.dispose();
  }

  void sendOtp(BuildContext context) async {
    if (otpScreenKey.currentState!.validate()) {
      if (isJustUiTest) {
        _toVerificationScreen(context);
        return;
      }

      otpLoginIsLoading = true;
      emit(OtpLogInScreenLoading());
      final req = BasePhoneReqModel(
        phoneCode: otpSelectCountry.dialCode!,
        phone: phoneControllerForOTPLogInScreen.text,
      );
      final res = await authCases
          .sendOtp(req)
          .whenComplete(() => otpLoginIsLoading = false);

      checkStatus<MsgModel>(
        showErrorToast: true,
        res,
        onError: (error) {
          // otpLoginIsLoading.value = false;
          emit(OtpLogInScreenError(error?.message ?? ""));
          // showCustomSnackBar(error?.msg ?? "");
        },
        onSuccess: (res) {
          _toVerificationScreen(context);
          emit(const OtpLogInScreenSuccess());
        },
      );
    }
  }

  toLoginScreen(BuildContext context) {
    if (context.canPop) {
      context.pop();
    } else {
      context.pushReplacementNamed(AppPaths.loginWithPass);
    }
  }

  _toVerificationScreen(BuildContext context) {
    Map<String, dynamic> args = {};
    args["nums"] = phoneControllerForOTPLogInScreen.text;
    args["countryCode"] = otpSelectCountry.dialCode.toString();
    args["otpState"] = OtpState.loginWithOtp.name;
    context.pushReplacementNamed(
      AppPaths.verificationScreen,
      arguments: args,
    );
  }
}
