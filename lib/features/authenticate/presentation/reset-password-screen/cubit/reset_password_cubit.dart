import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../../helpers/helper.dart';
import '../../../../../helpers/navigation.dart';
import '../../../../../main.dart' show isJustUiTest;
import '../../../../../widgets/app_dilog.dart';
import '../../../data/models/base_phone_req_model.dart';
import '../../../data/models/req-model/change_password_req_model.dart';
import '../../../data/models/req-model/update_password_req_model.dart';
import '../../../domain/use-cases/auth_cases.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit(this.authCases) : super(ResetPasswordInitial()) {
    initResetScreen();
  }

  final AuthCases authCases;

  @override
  Future<void> close() {
    disposeResetScreen();
    return super.close();
  }

  /// [ResetPasswordScreen]

  TextEditingController resetOldPasswordController = TextEditingController();
  TextEditingController resetNewPasswordController = TextEditingController();
  TextEditingController resetConfirmPasswordController =
      TextEditingController();

  FocusNode resetOldPasswordFocus = FocusNode();
  FocusNode resetNewPasswordFocusNode = FocusNode();
  FocusNode resetConfirmPasswordFocusNode = FocusNode();

  bool resetPassScreenIsLoading = false;

  initResetScreen() {
    resetOldPasswordController = TextEditingController();
    resetNewPasswordController = TextEditingController();
    resetConfirmPasswordController = TextEditingController();

    resetOldPasswordFocus = FocusNode();
    resetNewPasswordFocusNode = FocusNode();
    resetConfirmPasswordFocusNode = FocusNode();

    resetPassScreenIsLoading = false;
  }

  void disposeResetScreen() {
    resetOldPasswordController.dispose();
    resetNewPasswordController.dispose();
    resetConfirmPasswordController.dispose();
    resetOldPasswordFocus.dispose();
    resetNewPasswordFocusNode.dispose();
    resetConfirmPasswordFocusNode.dispose();
  }

  final GlobalKey<FormState> resetKey = GlobalKey<FormState>();

  void resetPass(
    BuildContext context,
    String countryCode,
    String otpCode,
    String phone,
  ) async {

    emit(ResetPasswordLoading());
    final req = UpdatePasswordReqModel(
      forgetPasswordCode: otpCode,
      password: resetConfirmPasswordController.text,
      phoneReqModel: BasePhoneReqModel(phone: phone, phoneCode: countryCode),
    );
    final res = await authCases.updatePassword(req);

    checkStatus(
      res,
      onSuccess: (res) {
        _toSignInScreen(context);
        showDialog(
          context: context,
          barrierColor: const Color.fromRGBO(50, 56, 77, 0.76),
          builder: (context) {
            return AppDialog.changePass();
          },
        );
        emit(const ResetPasswordSuccess());
      },
      onError: (error) {
        emit(ResetPasswordError(error?.message ?? ""));
      },
    );
  }

  _toSignInScreen(BuildContext context) {
    context.pop();
  }

  changePass(
    BuildContext context,
  ) async {
    emit(ResetPasswordLoading());
    final req = ChangePasswordReqModel(
      oldPass: resetOldPasswordController.text,
      newPass: resetConfirmPasswordController.text,
    );

    final res = await authCases.changePass(req);

    checkStatus(
      res,
      onSuccess: (res) async {


        if (context.canPop) {
          context.pop();
        }

        showDialog(
          context: context,
          barrierColor: const Color.fromRGBO(50, 56, 77, 0.76),
          builder: (context) {
            return AppDialog.changePass();
          },
        );
        emit(const ResetPasswordSuccess());
      },
      onError: (error) {
        emit(ResetPasswordError(error?.message ?? ""));
      },
    );
  }

  onPressBtn(
    BuildContext context,
    bool fromChangePassword,
    String? countryCode,
    String? otpCode,
    String? phone,
  ) async {
    if (resetKey.currentState!.validate()) {
      if (fromChangePassword) {
        await changePass(context);
      } else {
        resetPass(context, countryCode!, otpCode!, phone!);
      }
    }
  }
}
