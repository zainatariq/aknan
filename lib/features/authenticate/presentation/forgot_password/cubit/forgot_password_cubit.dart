import 'package:bloc/bloc.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../../helpers/helper.dart';
import '../../../../../helpers/navigation.dart';
import '../../../../../main.dart' show isJustUiTest;
import '../../../../../route/paths.dart';
import '../../../data/models/base_phone_req_model.dart';
import '../../../domain/use-cases/auth_cases.dart';
import '../../../enums/auth_enums.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit(this.authCase) : super(ForgotPasswordInitial()) {
    initForgetPassScreen();
  }

  @override
  Future<void> close() {
    disposeForgetPassScreen();
    return super.close();
  }

  TextEditingController forgetPasswordPhoneController = TextEditingController();
  FocusNode forgetPasswordPhoneNode = FocusNode();
  CountryCode forgetSelectCountry = CountryCode.fromDialCode("+966");
  final GlobalKey<FormState> forgetPasswordValidateKey =
      GlobalKey<FormState>(debugLabel: "forgetPasswordValidateKey");

  AuthCases authCase;

  void disposeForgetPassScreen() {
    forgetPasswordPhoneController.dispose();
    forgetPasswordPhoneNode.dispose();
  }

  initForgetPassScreen() {
    forgetPasswordPhoneController = TextEditingController();
    forgetPasswordPhoneNode = FocusNode();
  }

  bool get isForgetPassLoading => state is ForgotPasswordLoading;

  forgetPassClick(BuildContext context) async {
    if (!forgetPasswordValidateKey.currentState!.validate()) {
      // showCustomSnackBar(Strings.phoneIsRequired.tr);
      return;
    } else {
      if (isJustUiTest) {
        _toVerificationScreen(context);
        return;
      }
      // isForgetPassLoading(true);
      emit(ForgotPasswordLoading());

      BasePhoneReqModel req = BasePhoneReqModel(
        phoneCode: forgetSelectCountry.dialCode!,
        phone: forgetPasswordPhoneController.text,
      );

      final res = await authCase.forgetPassword(req);
      // isForgetPassLoading(false);

      checkStatus(
        res,
        onSuccess: (res) {
          emit(const ForgotPasswordSuccess());
          _toVerificationScreen(context);
        },
        onError: (res) {
          emit(ForgotPasswordError(res?.message ?? ""));
        },
      );
    }
  }

  _toVerificationScreen(BuildContext context) {
    Map<String, dynamic> args = {};
    args["nums"] = forgetPasswordPhoneController.text;
    args["countryCode"] = forgetSelectCountry.dialCode.toString();
    args["otpState"] = OtpState.forgetPassword.name;
    context.pushReplacementNamed(
      AppPaths.verificationScreen,
      arguments: args,
    );
  }
}
