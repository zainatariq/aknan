import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/validator.dart';
import '../../../../global/app-assets/assets.dart';
import '../../../../localization/change_language.dart';
import '../../../../localization/locale_keys.g.dart';
import '../../../../widgets/app_back_btn.dart';
import '../../../../widgets/app_page.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_text_field.dart';
import 'cubit/forgot_password_cubit.dart';

class ForgotPasswordScreen extends AppScaffold<ForgotPasswordCubit> {
  ForgotPasswordScreen({super.key}) {
    cubit.initForgetPassScreen();
  }

  String get _getTittle =>
      LocaleKeys.forgot_password.tre.replaceAll("?", "").replaceAll("؟", "");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackBtn(),
        title: Text(
          _getTittle,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Form(
          key: cubit.forgetPasswordValidateKey,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Image.asset(Assets.imagesPngsLogo)),
              SizedBox(height: MediaQuery.sizeOf(context).height / 4),
              Center(
                child: Text(
                  "your phone",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              const SizedBox(height: 20),
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
                // countryDialCode: cubit.forgetSelectCountry.dialCode,
                prefixIcon: Assets.imagesSvgsPhone1,
                controller: cubit.forgetPasswordPhoneController,
                inputAction: TextInputAction.next,
                // onCountryChanged: (_) => cubit.loginSelectCountry,
              ),
              const SizedBox(height: 20),
              BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
                bloc: cubit,
                builder: (context, state) {
                  return CustomButton(
                    buttonText: LocaleKeys.Verify.tre,
                    isLoading: cubit.isForgetPassLoading,
                    onPressed: () {
                      cubit.forgetPassClick(context);
                    },
                    radius: 50,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
