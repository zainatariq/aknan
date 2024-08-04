import 'package:flutter/material.dart';

import '../app-colors/app_colors_dark.dart';
import '../app-colors/app_colors_light.dart';
import '../app-text-styles/app_text_styles.dart';
import 'app_theme_light.dart';

// TODO:
ThemeData darkThemeData = ThemeData(
  bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppColorsDark.instance.primaryColorBlack),
  brightness: Brightness.dark,
  listTileTheme: ListTileThemeData(
    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(7),
    ),
    iconColor: AppColorsDark.instance.primaryColorBrownDark,
    style: ListTileStyle.list,
    titleTextStyle: AppTextStyle.text14Reg
        .copyWith(color: AppColorsDark.instance.primaryColorBlack),
    selectedColor: AppColorsDark.instance.primaryColorBlue,
    tileColor: AppColorsDark.instance.primaryColorWhite0,
  ),
  dropdownMenuTheme: DropdownMenuThemeData(
    menuStyle: MenuStyle(
      backgroundColor: MaterialStateProperty.all(
        AppColorsDark.instance.primaryColorGrey,
      ),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 72,
      ),
      backgroundColor: AppColorsDark.instance.primaryColorWhite,
      alignment: Alignment.center,
      textStyle: AppTextStyle.text16Reg.copyWith(
        color: AppColorsDark.instance.primaryColorBlue,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  ),
  switchTheme: SwitchThemeData(
    // trackColor: MaterialStatePropertyAll(Color(0xffE6E5E5)),
    trackColor: MaterialStateProperty.all(const Color(0xffE6E5E5)),
    thumbColor: MaterialStateProperty.resolveWith((state) {
      if (state.contains(MaterialState.selected)) {
        return const Color(0xff0C3F61);
      } else if (state.contains(MaterialState.disabled)) {
        return Colors.white;
      }
      return null;
    }),
  ),
  primaryColor: AppColorsDark.instance.primaryColorWhite,
  highlightColor: AppColorsDark.instance.primaryColorBrownDark2,
  primarySwatch: generateMaterialColor(AppColorsDark.instance.primaryColorBlue),
  shadowColor: AppColorsDark.instance.primaryColorGrey,
  focusColor: AppColorsDark.instance.primaryColorBrownDark,
  dividerColor: AppColorsDark.instance.primaryColorBlack,
  hintColor: AppColorsDark.instance.primaryColorBrownLight,
  hoverColor: AppColorsDark.instance.primaryColorWhite0,
  // primaryColorDark: AppColorsDark.instance.primaryColorBlue ,
  // primaryColorLight:  AppColorsDark.instance.primaryColorBrownDark,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: AppColorsDark.instance.primaryColorBlue,
    selectedIconTheme: IconThemeData(
      color: AppColorsDark.instance.primaryColorBrownDark,
      size: 26,
    ),
    unselectedIconTheme: IconThemeData(
      color: AppColorsDark.instance.primaryColorWhite,
      size: 24,
    ),
    selectedItemColor: AppColorsDark.instance.primaryColorBrownDark,
    unselectedItemColor: AppColorsDark.instance.primaryColorWhite,
    selectedLabelStyle: AppTextStyle.text16Reg,
    unselectedLabelStyle: AppTextStyle.text14Reg,
    type: BottomNavigationBarType.fixed,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColorsDark.instance.primaryColorBrownDark,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(320))),
  scaffoldBackgroundColor: AppColorsDark.instance.primaryColorBlack,
  textTheme: TextTheme(
      bodySmall: AppTextStyle.text12Reg.copyWith(
        color: AppColorsDark.instance.primaryColorBrownDark,
      ),
      bodyMedium: AppTextStyle.text14Reg.copyWith(
        color: AppColorsDark.instance.primaryColorBrownDark,
      ),
      bodyLarge: AppTextStyle.text18Reg.copyWith(
        color: AppColorsDark.instance.primaryColorBrownDark,
      ),
      headlineSmall: AppTextStyle.text14Reg.copyWith(
        color: AppColorsDark.instance.primaryColorWhite,
      ),
      headlineMedium: AppTextStyle.text16Reg.copyWith(
        color: AppColorsDark.instance.primaryColorWhite,
      ),
      labelLarge: AppTextStyle.text16Reg.copyWith(
        color: AppColorsDark.instance.primaryColorBrownDark,
      ),
      displaySmall: AppTextStyle.text12Reg.copyWith(
        color: AppColorsDark.instance.primaryColorWhite,
      ),
      displayMedium: AppTextStyle.text20Mid.copyWith(
        color: AppColorsDark.instance.primaryColorWhite,
      ),
      displayLarge: AppTextStyle.text14Reg.copyWith(
        color: AppColorsDark.instance.primaryColorWhite,
      ),
      headlineLarge: AppTextStyle.text14Bold.copyWith(
        color: AppColorsDark.instance.primaryColorWhite,
      ),
      labelSmall: AppTextStyle.text14Bold.copyWith(
        color: AppColorsDark.instance.primaryColorBrownDark,
      ),
      labelMedium: AppTextStyle.text12SimBold.copyWith(
        color: AppColorsDark.instance.primaryColorWhite,
      ),
      titleLarge: AppTextStyle.text30SimBold.copyWith(
        color: AppColorsDark.instance.primaryColorWhite,
      ),
      titleMedium: AppTextStyle.text18SimBold.copyWith(
        color: AppColorsDark.instance.primaryColorWhite,
      )),
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(
      color: AppColorsDark.instance.primaryColorBrownDark,
    ),
    centerTitle: true,
    backgroundColor: AppColorsDark.instance.primaryColorBlack,
    actionsIconTheme: const IconThemeData(),
    elevation: 0,
    titleTextStyle: AppTextStyle.text18Reg.copyWith(
      color: AppColorsDark.instance.primaryColorWhite,
      fontWeight: FontWeight.w600,
    ),
  ),
);
