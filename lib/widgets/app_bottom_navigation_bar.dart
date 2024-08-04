// app_bottom_navigation_bar
import 'package:aknan_user_app/global/app-assets/assets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../features/home-app/main-bg-page/cubit/main_bg_cubit.dart';
import '../localization/locale_keys.g.dart';

class AppBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int index) onChange;
  const AppBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBgCubit, MainBgState>(
      builder: (context, state) {
        return ClipRRect(
          borderRadius: const BorderRadiusDirectional.only(
            topEnd: Radius.circular(20),
            topStart: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                label: LocaleKeys.home.tr(context: context),
                icon: SvgPicture.asset(
                  Assets.imagesSvgsSignificonHome,
                  height: 20,
                  width: 20,
                ),
                activeIcon: SvgPicture.asset(
                  Assets.imagesSvgsSignificonHomeActive,
                  height: 20,
                  width: 20,
                ),
              ),
              BottomNavigationBarItem(
                label: LocaleKeys.chat.tr(context: context),
                icon: SvgPicture.asset(
                  Assets.imagesSvgsMessageHBnvDisActive,
                  height: 20,
                  width: 20,
                ),
                activeIcon: SvgPicture.asset(
                  Assets.imagesSvgsMessageHBnvActive,
                  height: 20,
                  width: 20,
                ),
              ),
              BottomNavigationBarItem(
                label: LocaleKeys.profile.tr(context: context),
                icon: SvgPicture.asset(
                  Assets.imagesSvgsSignificonUserHBnvDisActive,
                  height: 20,
                  width: 20,
                ),
                activeIcon: SvgPicture.asset(
                  Assets.imagesSvgsSignificonUserHBnvActive,
                  height: 20,
                  width: 20,
                ),
              ),
              BottomNavigationBarItem(
                label: LocaleKeys.settings.tr(context: context),
                icon: SvgPicture.asset(
                  Assets.imagesSvgsSettingsHBnvDisActive,
                  height: 20,
                  width: 20,
                ),
                activeIcon: SvgPicture.asset(
                  Assets.imagesSvgsSettingsHBnvActive,
                  height: 20,
                  width: 20,
                ),
              ),
            ],
            currentIndex: currentIndex,
            onTap: onChange,
          ),
        );
      },
    );
  }
}
