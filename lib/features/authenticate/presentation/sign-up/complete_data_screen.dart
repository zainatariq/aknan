import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bases/base-models/base_id_value_model.dart';
import '../../../../config/validator.dart';
import '../../../../global/app-assets/assets.dart';
import '../../../../helpers/navigation.dart';
import '../../../../localization/change_language.dart';
import '../../../../localization/locale_keys.g.dart';
import '../../../../widgets/app_back_btn.dart';
import '../../../../widgets/app_page.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_text_field.dart';
import '../../../../widgets/generic_dropdown.dart';
import 'cubit/complete_data_cubit.dart';

// complete_data_screen
class CompleteDataScreen extends AppScaffold<CompleteDataCubit> {
  CompleteDataScreen({super.key}) {
    cubit.initSignUp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.complete_data.tre),
        leading: context.canPop ? const AppBackBtn() : null,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Form(
          key: cubit.signUpKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 15),
                child: Text(
                  LocaleKeys.name.tre,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              const SizedBox(height: 15),
              CustomTextField(
                hintText: LocaleKeys.name.tre,
                isLtr: true,
                isEnabled: true,
                validator: (p0) => TValidator.normalValidator(
                  p0,
                  hint: LocaleKeys.name.tre,
                ),
                inputType: TextInputType.text,
                prefixIcon: Assets.imagesSvgsNameIco,
                controller: cubit.regNameController,
                inputAction: TextInputAction.next,
                // onCountryChanged: (_) => cubit.loginSelectCountry,
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 15),
                child: Text(
                  LocaleKeys.email.tre,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              const SizedBox(height: 15),
              CustomTextField(
                hintText: LocaleKeys.email.tre,
                isLtr: true,
                isEnabled: true,
                validator: (p0) => TValidator.email(
                  p0,
                  LocaleKeys.email.tre,
                ),
                inputType: TextInputType.emailAddress,
                prefixIcon: Assets.imagesSvgsMailSignUp,
                controller: cubit.regEmilController,
                inputAction: TextInputAction.next,
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 15),
                child: Text(
                  LocaleKeys.government.tre,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              const SizedBox(height: 15),
              BlocBuilder<CompleteDataCubit, CompleteDataState>(
                bloc: cubit,
                builder: (context, state) {
                  return GenericDropdown<BaseIdNameModelString>(
                    items: cubit.governments?.data ?? [],
                    hintText: LocaleKeys.government.tre,
                    selectedValue: cubit.selectGovernment,
                    onChanged: cubit.onSelectGovernment,
                    prefixIconPath: Assets.imagesSvgsSignificonHomeActive,
                    itemToString: (p0) => p0.value,
                  );
                },
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 15),
                child: Text(
                  LocaleKeys.city.tre,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              const SizedBox(height: 15),
              BlocBuilder<CompleteDataCubit, CompleteDataState>(
                bloc: cubit,
                builder: (context, state) {
                  return GenericDropdown<BaseIdNameModelString>(
                    items: cubit.cities?.data ?? [],
                    hintText: LocaleKeys.city.tre,
                    selectedValue: cubit.selectCity,
                    onChanged: cubit.onSelectCity,
                    prefixIconPath: Assets.imagesSvgsSignificonHomeActive,
                    itemToString: (p0) => p0.value,
                  );
                },
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 15),
                child: Text(
                  LocaleKeys.district.tre,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              const SizedBox(height: 15),
              BlocBuilder<CompleteDataCubit, CompleteDataState>(
                bloc: cubit,
                builder: (context, state) {
                  return GenericDropdown<BaseIdNameModelString>(
                    items: cubit.district?.data ?? [],
                    hintText: LocaleKeys.district.tre,
                    selectedValue: cubit.selectDistrict,
                    onChanged: cubit.onSelectDistrict,
                    prefixIconPath: Assets.imagesSvgsSignificonHomeActive,
                    itemToString: (p0) => p0.value,
                  );
                },
              ),
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
                controller: cubit.regPassController,
                // onFieldSubmitted: (text) => cubit.loginWithPass(),
                focusNode: null,
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 15),
                child: Text(
                  LocaleKeys.confirm_password.tre,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              const SizedBox(height: 10),
              CustomTextField(
                isLtr: true,
                validator: (p0) => TValidator.confirmPasswordValidate(
                  comparePassword: cubit.regPassController.text,
                  value: p0,
                  hint: LocaleKeys.confirm_password.tre,
                ),
                hintText: LocaleKeys.confirm_password.tre,
                inputType: TextInputType.text,
                prefixIcon: Assets.imagesSvgsSignificonLock,
                prefixHeight: 70,
                inputAction: TextInputAction.done,
                isPassword: true,
                controller: cubit.regNewPassController,
                // onFieldSubmitted: (text) => cubit.loginWithPass(),
                focusNode: null,
              ),
              const SizedBox(height: 20),
              BlocBuilder<CompleteDataCubit, CompleteDataState>(
                bloc: cubit,
                builder: (context, state) {
                  return CustomButton(
                    showBorder: true,
                    borderWidth: 1,
                    transparent: true,
                    isLoading: state is Loading && state.inBtn,
                    // buttonText: Strings.otpLogin.tr,
                    buttonText: LocaleKeys.save.tre,
                    onPressed: () {
                      cubit.signUp(context);
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
