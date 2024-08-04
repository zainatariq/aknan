import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../bases/base_state/base_cubit_state.dart';
import '../../../../../../global/theme/themes/cubit/theme_cubit_cubit.dart';
import '../../../../../../injection_container.dart';
import '../../../../../../localization/cubit/localization_cubit.dart';
import '../../../../../../localization/locale_keys.g.dart';
import '../../../../../../widgets/app_back_btn.dart';
import '../../../../../../widgets/app_bottom_sheet.dart';
import '../../../../../../widgets/app_list_tile.dart';
import '../../../../../../widgets/app_notification_widget.dart';
import '../../../../../../widgets/app_page.dart';
import '../../../../main-bg-page/cubit/main_bg_cubit.dart';
import '../../../home/cubit/cubit/home_sub_screen_cubit.dart';
import '../../cubit/settings_cubit.dart';
import '../../model/setting_model.dart';

class SettingsSubScreen extends AppScaffold<SettingsCubit> {
  const SettingsSubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.settings.tr(context: context)),
        leading: AppBackBtn(
          onTap: () {
            MainBgCubit.get(context).toHome();
          },
        ),
        actions: const [
          AppNotificationWidget(),
        ],
      ),
      body: BlocBuilder<SettingsNetCubit, ICubitState<AboutUsRes>>(
        bloc: SettingsNetCubit.instance,
        builder: (context, state) {
          return ListView.separated(
            itemCount: cubit.drawerItems.length,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 10);
            },
            itemBuilder: (BuildContext context, int index) {
              var item = cubit.drawerItems[index];
              if (cubit.isNotification(index)) {
                return BlocBuilder<SettingsCubit, SettingsState>(
                  bloc: cubit,
                  builder: (context, state) {
                    return AppListTile.switcher(
                      leadingSvgPath: item.localSvgPath,
                      onTap: cubit.changeNotificationState,
                      title: item.title,
                      value: cubit.notificationState,
                      onChange: (value) => cubit.changeNotificationState(),
                    );
                  },
                );
              }
              if (cubit.isTheme(index)) {
                ThemeCubitCubit themeCubit = sl<ThemeCubitCubit>();
                return BlocBuilder<ThemeCubitCubit, ThemeCubitState>(
                  builder: (context, state) {
                    return AppListTile.switcher(
                      leadingSvgPath: item.localSvgPath,
                      onTap: themeCubit.toggleTheme,
                      title: item.title,
                      onChange: (_) => themeCubit.toggleTheme(),
                      value: themeCubit.isDarkTheme,
                    );
                  },
                );
              }

              if (cubit.isDropDown(index)) {
                LocalizationCubit localizationCubit = sl<LocalizationCubit>();
                return BlocBuilder<LocalizationCubit, LocalizationState>(
                  bloc: localizationCubit..getCurrentLang(context),
                  builder: (context, state) {
                    localizationCubit.getCurrentLang(context);
                    return AppListTile.langDropDown(
                      leadingSvgPath: item.localSvgPath,
                      title: item.title,
                      selectedValue: localizationCubit.currentLang,
                      onTap: () => null,
                      onSelectLang: (lang) {
                        if (lang != localizationCubit.currentLang) {
                          showModalBottomSheet(
                            context: context,
                            showDragHandle: true,
                            enableDrag: true,
                            backgroundColor: Colors.white,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft:
                                    Radius.circular(20.0), // Adjust as needed
                                topRight:
                                    Radius.circular(20.0), // Adjust as needed
                              ),
                            ),
                            builder: (context) {
                              return AppBottomSheet.changeLanguage(
                                onYesTap: () {
                                  localizationCubit.toggleLang(
                                    context,
                                    lang: lang,
                                  );
                                  MainBgCubit.get(context).reloadHome = true;
                                },
                              );
                            },
                          );
                        }
                      },
                    );
                  },
                );
              }
              return AppListTile.leadingSvg(
                leadingSvgPath: item.localSvgPath,
                onTap: () => item.functionCallback?.call(context),
                title: item.title,
              );
            },
          );
        },
      ),
    );
  }
}
