import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/dimensions.dart';
import '../../../../config/validator.dart';
import '../../../../global/app-assets/assets.dart';
import '../../../../localization/change_language.dart';
import '../../../../localization/locale_keys.g.dart';
import '../../../../widgets/app_back_btn.dart';
import '../../../../widgets/app_page.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_text_field.dart';
import 'cubit/reset_password_cubit.dart';

/// for ChangePassword foe exsit user we will use token
/// so don't need phone or countryCode or otpCode
class ResetPasswordScreen extends AppScaffold<ResetPasswordCubit> {
  final String? phone;
  final String? countryCode;
  final bool fromChangePassword;
  final String? otpCode;
  ResetPasswordScreen({
    super.key,
    this.fromChangePassword = false,
    this.countryCode,
    this.otpCode,
    this.phone,
  }) {
    cubit.initResetScreen();
  }

  String get buttonText =>
      fromChangePassword ? LocaleKeys.update.tre : LocaleKeys.save.tre;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.change_password.tre),
          leading: const AppBackBtn(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
          child: Form(
            key: cubit.resetKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (fromChangePassword)
                  Padding(
                    padding: const EdgeInsetsDirectional.only(start: 15),
                    child: Text(
                      LocaleKeys.old_password.tre,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                if (fromChangePassword) const SizedBox(height: 10),
                if (fromChangePassword)
                  CustomTextField(
                    hintText: LocaleKeys.old_password.tre,
                    inputType: TextInputType.text,
                    validator: (p0) => TValidator.passwordValidate(
                        value: p0, hint: LocaleKeys.old_password.tre),
                    prefixIcon: Assets.imagesSvgsSignificonLock,
                    isLtr: true,
                    isPassword: true,
                    controller: cubit.resetOldPasswordController,
                    focusNode: cubit.resetOldPasswordFocus,
                    nextFocus: cubit.resetNewPasswordFocusNode,
                    inputAction: TextInputAction.next,
                  ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 15),
                  child: Text(
                    LocaleKeys.new_password.tre,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  isLtr: true,
                  hintText: LocaleKeys.new_password.tre,
                  inputType: TextInputType.text,
                  prefixIcon: Assets.imagesSvgsSignificonLock,
                  validator: (p0) => TValidator.passwordValidate(
                    value: p0,
                    hint: LocaleKeys.new_password.tre,
                  ),
                  isPassword: true,
                  controller: cubit.resetNewPasswordController,
                  focusNode: cubit.resetNewPasswordFocusNode,
                  nextFocus: cubit.resetConfirmPasswordFocusNode,
                  inputAction: TextInputAction.next,
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 15),
                  child: Text(
                    LocaleKeys.confirm_new_password.tre,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  hintText: LocaleKeys.confirm_new_password.tre,
                  isLtr: true,
                  inputType: TextInputType.text,
                  validator: (p0) => TValidator.confirmPasswordValidate(
                    value: p0,
                    comparePassword: cubit.resetNewPasswordController.text,
                    hint: LocaleKeys.confirm_new_password.tre,
                  ),
                  prefixIcon: Assets.imagesSvgsSignificonLock,
                  controller: cubit.resetConfirmPasswordController,
                  focusNode: cubit.resetConfirmPasswordFocusNode,
                  inputAction: TextInputAction.done,
                  onFieldSubmitted: (text) => cubit.onPressBtn(
                    context,
                    fromChangePassword,
                    countryCode,
                    otpCode,
                    phone,
                  ),
                  isPassword: true,
                ),
                const SizedBox(height: 10),
                BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
                  bloc: cubit,
                  builder: (context, state) {
                    return CustomButton(
                      buttonText: buttonText,
                      isLoading: state is ResetPasswordLoading,
                      onPressed: () {
                        cubit.onPressBtn(
                          context,
                          fromChangePassword,
                          countryCode,
                          otpCode,
                          phone,
                        );
                      },
                      radius: 50,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
