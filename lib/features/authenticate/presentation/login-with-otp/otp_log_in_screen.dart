import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:one_context/one_context.dart';

import '../../../../config/validator.dart';
import '../../../../global/app-assets/assets.dart';
import '../../../../localization/change_language.dart';
import '../../../../localization/locale_keys.g.dart';
import '../../../../widgets/app_back_btn.dart';
import '../../../../widgets/app_page.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_text_field.dart';
import '../login-with-pass/sign_in_screen.dart';
import 'cubit/otp_log_in_screen_cubit.dart';

class OtpLoginScreen extends AppScaffold<OtpLogInScreenCubit> {
  // final bool? isFromlogin;
  OtpLoginScreen({super.key, }) {
    cubit.initOtpScreen();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // title: Text(LocaleKeys.sign_up.tre),
          leading: const AppBackBtn(),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: cubit.otpScreenKey,
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
                      // countryDialCode: cubit.otpSelectCountry.dialCode,
                      controller: cubit.phoneControllerForOTPLogInScreen,
                      inputAction: TextInputAction.next,
                      prefixIcon: Assets.imagesSvgsPhone1,

                      // onCountryChanged: (_) => cubit.loginSelectCountry,
                    ),
                    const SizedBox(height: 20),
                    BlocBuilder<OtpLogInScreenCubit, OtpLogInScreenState>(
                      bloc: cubit,
                      builder: (context, state) {
                        return Center(
                          child: CustomButton(
                            showBorder: true,
                            borderWidth: 1,
                            transparent: true,
                            isLoading: cubit.otpLoginIsLoading,
                            buttonText: LocaleKeys.sign_up.tre,
                            onPressed: () => cubit.sendOtp(context),
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
                      buttonText: LocaleKeys.login.tre,
                      onPressed: () {
                        cubit.toLoginScreen(context);
                      },
                      radius: 50,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
