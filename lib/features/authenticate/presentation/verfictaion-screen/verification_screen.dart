import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../config/dimensions.dart';
import '../../../../global/app-assets/assets.dart';
import '../../../../localization/change_language.dart';
import '../../../../localization/locale_keys.g.dart';
import '../../../../widgets/app_back_btn.dart';
import '../../../../widgets/app_page.dart';
import '../../../../widgets/custom_button.dart';
import '../../enums/auth_enums.dart';
import 'cubit/verfictaion_screen_cubit.dart';

class VerificationScreen extends AppScaffold<VerificationScreenCubit> {
  final String number;
  final String countryCode;
  final OtpState otpState;
  VerificationScreen({
    super.key,
    required this.number,
    required this.otpState,
    required this.countryCode,
  }) {
    cubit.initVerificationScreen();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getTitle),
        leading: const AppBackBtn(),
      ),
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Image.asset(Assets.imagesPngsLogo)),
              SizedBox(height: MediaQuery.sizeOf(context).height / 8),
              Text(
                LocaleKeys.enter_verification_code.tre,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 20),
              Form(
                key: cubit.formKey,
                child: SizedBox(
                  width: 240,
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: PinCodeTextField(
                      length: 4,
                      appContext: context,
                      autoDismissKeyboard: true,
                      keyboardType: TextInputType.number,
                      animationType: AnimationType.slide,
                      controller: cubit.otpCodeController,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.circle,
                        fieldHeight: 40,
                        fieldWidth: 40,
                        borderWidth: 1,
                        borderRadius:
                            BorderRadius.circular(Dimensions.radiusDefault),
                        selectedColor:
                            Theme.of(context).primaryColor.withOpacity(0.2),
                        inactiveFillColor: Theme.of(context).cardColor,
                        inactiveColor: Theme.of(context).hintColor,
                        activeColor: Theme.of(context).hintColor,
                        activeFillColor: Theme.of(context).cardColor,
                      ),
                      animationDuration: const Duration(milliseconds: 300),
                      backgroundColor: Colors.transparent,
                      enableActiveFill: true,
                      validator: (value) => (value != null && value.length < 4)
                          ? " otp required"
                          : null,
                      onChanged: (_) => cubit.changeViewStateBtn(_),
                      beforeTextPaste: (text) => true,
                      textStyle: const TextStyle(),
                      pastedTextStyle: const TextStyle(),
                    ),
                  ),
                ),
              ),
              BlocBuilder<VerificationScreenCubit, VerificationScreenState>(
                bloc: cubit,
                builder: (context, state) {
                  return Visibility(
                    visible: cubit.isCounting,
                    child: Center(
                      child: Text(
                        "${cubit.min}:${cubit.second}",
                        style: const TextStyle(),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    LocaleKeys.did_not_receive_the_code.tre,
                    style: const TextStyle().copyWith(
                        color: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .color!
                            .withOpacity(.6)),
                  ),
                  BlocBuilder<VerificationScreenCubit, VerificationScreenState>(
                    bloc: cubit,
                    builder: (context, state) {
                      return TextButton(
                        onPressed: !cubit.isCounting
                            ? () {
                                cubit.reSendMsg(countryCode, number);
                              }
                            : null,
                        child: Text(
                          LocaleKeys.resend_it.tre,
                          style: const TextStyle().copyWith(
                            color: cubit.isCounting
                                ? Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.3)
                                : Theme.of(context).primaryColor,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      );
                    },
                  ),
                ],
              ),
              BlocBuilder<VerificationScreenCubit, VerificationScreenState>(
                bloc: cubit,
                builder: (context, state) {
                  return Visibility(
                    visible: cubit.isVisibleBtn,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: Dimensions.paddingSizeExtraLarge,
                      ),
                      child: CustomButton(
                        buttonText: LocaleKeys.send.tre,
                        isLoading: cubit.isVerificationIsLoading,
                        radius: 50,
                        onPressed: () {
                          cubit.onPressSendBtn(
                            context,
                            otpState,
                            number,
                            countryCode,
                          );
                        },
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  String get _getTitle {
    switch (otpState) {
      case OtpState.forgetPassword:
      print("""LocaleKeys.forgot_password.tre
            .replaceAll("?", "")
            .replaceAll("؟", "")  ${LocaleKeys.forgot_password.tre
            .replaceAll("?", "")
            .replaceAll("؟", "")}""");
      
        return LocaleKeys.forgot_password.tre
            .replaceAll("?", "")
            .replaceAll("؟", "");
      // case OtpState.loginWithOtp:
      //   return LocaleKeys.otp_login.tre;
      case OtpState.loginWithOtp:
        return LocaleKeys.sign_up.tre;
    }
  }
}
