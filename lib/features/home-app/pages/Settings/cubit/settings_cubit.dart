import '../../../../../bases/base_state/base_cubit_state.dart';
import '../../../../../bases/base_view_cubit/base_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../bases/base_mixns/state_mapper.dart';
import '../../../../../global/app-assets/assets.dart';
import '../../../../../helpers/cache_helper.dart';
import '../../../../../helpers/navigation.dart';
import '../../../../../injection_container.dart';
import '../../../../../localization/change_language.dart';
import '../../../../../localization/locale_keys.g.dart';
import '../../../../../main.dart' show isJustUiTest;
import '../../../../../route/paths.dart';
import '../../../../../widgets/app_bottom_sheet.dart';
import '../../../../../widgets/app_dilog.dart';
import '../../../../../widgets/info_app_page.dart';
import '../../../../authenticate/presentation/login-with-pass/cubit/login_with_pass_cubit.dart';
import '../../../main-bg-page/cubit/main_bg_cubit.dart';
import '../model/setting_model.dart';
import '../repo/settings_repo.dart';

part 'settings_cubit.freezed.dart';
part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const SettingsState.initial());

  final List<SettingModel> _drawerItems = [
    SettingModel(
      localSvgPath: Assets.imagesSvgsNotificationsInSetting,
      title: LocaleKeys.notification,
      functionCallback: (BuildContext context) {
        // changeNotificationState();
      },
    ),
    SettingModel(
      localSvgPath: Assets.imagesSvgsLanguage,
      title: LocaleKeys.change_language,
      functionCallback: (BuildContext context) {},
    ),
    SettingModel(
      localSvgPath: Assets.imagesSvgsLayer14,
      title: LocaleKeys.change_password,
      functionCallback: (BuildContext context) async {
        await showModalBottomSheet(
          context: context,
          showDragHandle: true,
          enableDrag: true,
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), // Adjust as needed
              topRight: Radius.circular(20.0), // Adjust as needed
            ),
          ),
          builder: (context) {
            return AppBottomSheet.changePassword(
              onYesTap: () {
                Map<String, dynamic> args = {};
                args['fromChangePassword'] = true;
                context.pushNamed(AppPaths.changePassScreen, arguments: args);
              },
            );
          },
        );
      },
    ),
    SettingModel(
      localSvgPath: Assets.imagesSvgsTheme,
      title: LocaleKeys.theme,
      functionCallback: (BuildContext context) {},
    ),
    SettingModel(
      localSvgPath: Assets.imagesSvgsAboutUs,
      title: LocaleKeys.about_us,
      functionCallback: (BuildContext context) {
        context.push(
          InfoAppPage.htmlBody(
            title: LocaleKeys.about_us.tre,
            htmlBody: SettingsNetCubit
                    .instance.aboutUsRes?.data?.about?.description ??
                "",
          ),
        );
      },
    ),
    SettingModel(
      localSvgPath: Assets.imagesSvgsContactUs,
      title: LocaleKeys.contact_us,
      functionCallback: (BuildContext context) {
        context.push(
          InfoAppPage.contactUs(
            title: LocaleKeys.contact_us.tre,
            email: SettingsNetCubit.instance.aboutUsRes?.data?.email ?? "",
            phone: SettingsNetCubit.instance.aboutUsRes?.data?.phone ?? "",
          ),
        );
      },
    ),
    SettingModel(
      localSvgPath: Assets.imagesSvgsPoliciesAndPrivacy,
      title: LocaleKeys.policies_and_privacy,
      functionCallback: (BuildContext context) {
        context.push(
          InfoAppPage.htmlBody(
            title: LocaleKeys.policies_and_privacy.tre,
            htmlBody: SettingsNetCubit
                    .instance.aboutUsRes?.data?.policy?.description ??
                "",
          ),
        );
      },
    ),
    SettingModel(
      localSvgPath: Assets.imagesSvgsIconSignOut,
      title: LocaleKeys.log_out,
      functionCallback: (BuildContext context) async {
        if (true) {
          if (await showDialog(
            context: context,
            builder: (context) {
              return AppDialog.logOut();
            },
          )) {
            CacheHelper.setValue(kay: LoginWithPassCubit.authKey, value: false)
                .whenComplete(
              () {
                MainBgCubit.get(context).toHomeWithoutUpdateUi();
                context.pushReplacementNamed(AppPaths.loginWithPass);
              },
            );
          }
        }
      },
    ),
  ];

  int notificationIndex = 0;
  int lightThemeIndex = 3;
  bool isNotification(int index) => index == notificationIndex;
  bool isTheme(int index) => index == lightThemeIndex;

  bool isSwitch(int index) => isNotification(index) || isTheme(index);

  bool isDropDown(int index) => index == 1;

  List<SettingModel> get drawerItems => _drawerItems;
  bool _notificationState = true;
  bool get notificationState => _notificationState;
  bool get lightThemeState => false;

  void changeNotificationState() {
    _notificationState = !_notificationState;
    emit(SettingsState.switchNotificationState(notificationState));
  }
}

class SettingsNetCubit extends ICubit<AboutUsRes> with UiState<AboutUsRes> {
  final SettingsRepo _repo;
  SettingsNetCubit(
    this._repo,
  ) {
    getAboutUs();
  }

  AboutUsRes? aboutUsRes;
  static SettingsNetCubit get instance => sl<SettingsNetCubit>();
  getAboutUs() async {
    if (aboutUsRes != null) {
      return;
    }
    emit(const ICubitState.loading());
    final response = await _repo.getAboutUs();
    final state = mapNetworkState(response);
    emit(state);
    state.whenOrNull(success: (data) {
      aboutUsRes = data;
    });
  }
}
