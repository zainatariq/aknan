import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:one_context/one_context.dart';

import '../../../../config/validator.dart';
import '../../../../global/app-assets/assets.dart';
import '../../../../localization/change_language.dart';
import '../../../../localization/locale_keys.g.dart';
import '../../../../widgets/app_page.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_text_field.dart';
import 'cubit/login_with_pass_cubit.dart';

class SignInScreen extends AppScaffold<LoginWithPassCubit> {
  SignInScreen({super.key}) {
    cubit.initLoginWithPassScreen();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: cubit.loginWithPassKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(child: Image.asset(Assets.imagesPngsLogo)),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.06,
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(start: 15),
                        child: Text(
                          LocaleKeys.Phone_number.tre,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                      const SizedBox(height: 15),
                      CustomTextField(
                        hintText: LocaleKeys.Phone_number.tre,
                        isLtr: true,
                        isEnabled: true,
                        validator: (p0) => TValidator.saudiNumber(
                          value: p0,
                          hint: LocaleKeys.Phone_number.tre,
                        ),
                        inputType: TextInputType.number,
                        // countryDialCode: cubit.loginSelectCountry.dialCode
                        prefixIcon: Assets.imagesSvgsPhone1,
                        controller: cubit.loginPhoneController,
                        inputAction: TextInputAction.next,
                        // onCountryChanged: (_) => cubit.loginSelectCountry,
                      ),

                      // K.sizedBoxH0,
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(start: 15),
                        child: Text(
                          LocaleKeys.Password.tre,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),

                      const SizedBox(height: 10),

                      CustomTextField(
                        isLtr: true,
                        validator: (p0) => TValidator.passwordValidate(
                          value: p0,
                          hint: LocaleKeys.Password.tre,
                        ),
                        hintText: LocaleKeys.Password.tre,
                        inputType: TextInputType.text,
                        prefixIcon: Assets.imagesSvgsSignificonLock,
                        prefixHeight: 70,
                        inputAction: TextInputAction.done,
                        isPassword: true,
                        controller: cubit.loginPassController,
                        onFieldSubmitted: (text) =>
                            cubit.loginWithPass(context),
                        focusNode: null,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                //
                                cubit.toForgetPassScreen(context);
                              },
                              child: Text(
                                LocaleKeys.forgot_password.tre,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                          )
                        ],
                      ),
                      BlocBuilder<LoginWithPassCubit, LoginWithPassState>(
                        bloc: cubit,
                        builder: (context, state) {
                          return Center(
                            child: CustomButton(
                              showBorder: true,
                              borderWidth: 1,
                              transparent: true,

                              isLoading: state is LoginWithPassLoading,
                              // buttonText: Strings.otpLogin.tr,
                              buttonText: LocaleKeys.login.tre,
                              onPressed: () {
                                cubit.loginWithPass(context);
                              },
                              radius: 50,
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      const ORRaw(),
                      const SizedBox(height: 10),
                      CustomButton(
                        showBorder: true,
                        borderWidth: 1,
                        transparent: true,
                        isLoading: false,
                        // buttonText: Strings.otpLogin.tr,
                        buttonText: LocaleKeys.sign_up.tre,
                        onPressed: () => cubit.toOtpLoginScreen(context),
                        radius: 50,
                      ),
                      const SizedBox(height: 10),

                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Text(
                      //       '${LocaleKeys.do_not_have_an_account.tre} ',
                      //       style: Theme.of(context).textTheme.bodyMedium,
                      //     ),
                      //     TextButton(
                      //         onPressed: () {
                      //           cubit.toSignUpScreen(context);
                      //         },
                      //         child: Text(
                      //           LocaleKeys.sign_up.tre,
                      //           style: Theme.of(context)
                      //               .textTheme
                      //               .bodyMedium!
                      //               .copyWith(
                      //                   decoration: TextDecoration.underline),
                      //         ))
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ORRaw extends StatelessWidget {
  const ORRaw({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(children: [
        const Expanded(
          child: Divider(
            color: Color(0xff707070),
            thickness: 1,
          ),
        ),
        // K.sizedBoxW0,
        const SizedBox(width: 5),
        Text(
          LocaleKeys.or.tre,
          style: TextStyle(color: Theme.of(context).focusColor),
        ),
        // K.sizedBoxW0,
        const SizedBox(width: 5),
        const Expanded(
          child: Divider(
            color: Color(0xff707070),
            thickness: 1,
          ),
        ),
      ]),
    );
  }
}
