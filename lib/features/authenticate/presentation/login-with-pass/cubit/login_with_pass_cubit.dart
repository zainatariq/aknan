import 'package:bloc/bloc.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../../helpers/cache_helper.dart';
import '../../../../../helpers/helper.dart';
import '../../../../../helpers/navigation.dart';
import '../../../../../main.dart' show isJustUiTest;
import '../../../../../route/paths.dart';
import '../../../data/models/base_phone_req_model.dart';
import '../../../data/models/req-model/login_with_pass_req_model.dart';
import '../../../data/models/res-models/user_model.dart';
import '../../../domain/use-cases/auth_cases.dart';
import '../../../enums/auth_enums.dart';

part 'login_with_pass_state.dart';

class LoginWithPassCubit extends Cubit<LoginWithPassState> {
  LoginWithPassCubit(this.authCases) : super(LoginWithPassInitial()) {
    initLoginWithPassScreen();
  }
  @override
  Future<void> close() {
    disposeLogin();
    return super.close();
  }

  final AuthCases authCases;

  /// [SignInScreen]

  TextEditingController loginPhoneController = TextEditingController();
  TextEditingController loginPassController = TextEditingController();
  CountryCode loginSelectCountry = CountryCode.fromDialCode("+966");
  GlobalKey<FormState> loginWithPassKey =
      GlobalKey<FormState>(debugLabel: "loginWithPassKey");

  void initLoginWithPassScreen() async {
    loginPhoneController = TextEditingController();
    loginPassController = TextEditingController();
  }

  bool isLoginWithPassLoading = false;
  // RxBool isLoginRememberMe = false.obs;
  void loginWithPass(BuildContext context) async {
    if (_validate()) {
      if (isJustUiTest) {
        toHomeScreen(context);
        return;
      }

      // isLoginWithPassLoading(true);
      emit(LoginWithPassLoading());
      await Future.delayed(const Duration(seconds: 1));
      var req = LoginWithPassReqModel(
          password: loginPassController.text,
          phoneReqModel: BasePhoneReqModel(
            phone: loginPhoneController.text,
            phoneCode: loginSelectCountry.dialCode!,
          ));
      final res = await authCases.loginWithPassword(req);

      checkStatus(
        res,
        onError: (error) {
          if (error?.data?.status?.toInt() == 403) {
            _toVerificationScreen(
              context,
              loginPhoneController.text,
              loginSelectCountry.dialCode!,
              OtpState.loginWithOtp,
            );
          }
          // TODO:: 408 go to commplete data screen 
          if (error?.data?.status?.toInt() == 403) {
            _toVerificationScreen(
              context,
              loginPhoneController.text,
              loginSelectCountry.dialCode!,
              OtpState.loginWithOtp,
            );
          }

          emit(LoginWithPassError(error?.message ?? ""));
        },
        onSuccess: (res) async {
          emit(const LoginWithPassSuccess());
          final UserAuthModel user = res!.user!;

          await authCases.setUserDate(user);

          toHomeScreen(context);
        },
      );
    }
  }

  bool _validate() => loginWithPassKey.currentState!.validate();

  Future<dynamic>? _toVerificationScreen(
      BuildContext context, String phone, String poneCode, OtpState state) {
    Map<String, dynamic> args = {};
    args["nums"] = phone;
    args["countryCode"] = poneCode;
    args["otpState"] = state.name;
    context.pushReplacementNamed(
      AppPaths.verificationScreen,
      arguments: args,
    );
    return null;
  }

  // toggleRememberMe() {
  //   isLoginRememberMe.value = isLoginRememberMe.toggle().value;
  // }

  void disposeLogin() {
    for (var element in [loginPhoneController, loginPassController]) {
      element.dispose();
    }
  }

  toForgetPassScreen(BuildContext context) {
    context.pushNamed(AppPaths.forgetPassword);
  }

  toOtpLoginScreen(BuildContext context) {
    context.pushNamed(AppPaths.loginWithOtp);
  }

  static String authKey = "authKey";

  static bool get isAuthed => CacheHelper.getValue(kay: authKey) ?? false;
  toHomeScreen(BuildContext context) {
    CacheHelper.setValue(kay: authKey, value: true).whenComplete(
      () => context.pushNamedAndRemoveUntil(
        AppPaths.homeScreen,
        predicate: (route) => false,
      ),
    );
  }

  toSignUpScreen(BuildContext context) {
    context.pushNamed(AppPaths.signUp);
  }
}
