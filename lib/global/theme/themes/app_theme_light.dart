import 'dart:math';

import 'package:flutter/material.dart';

import '../app-colors/app_colors_light.dart';
import '../app-text-styles/app_text_styles.dart';

ThemeData lightThemeData = ThemeData(
  brightness: Brightness.light,

  listTileTheme: ListTileThemeData(
    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(7),
    ),
    iconColor: AppColorsLight.instance.primaryColorBrownDark,
    style: ListTileStyle.list,
    titleTextStyle: AppTextStyle.text14Reg
        .copyWith(color: AppColorsLight.instance.primaryColorBlack),
    selectedColor: AppColorsLight.instance.primaryColorBlue,
    tileColor: AppColorsLight.instance.primaryColorWhite0,
  ),
  dropdownMenuTheme: DropdownMenuThemeData(
    menuStyle: MenuStyle(
      backgroundColor: MaterialStateProperty.all(
        AppColorsLight.instance.primaryColorGrey,
      ),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 72,
      ),
      backgroundColor: AppColorsLight.instance.primaryColorBlue,
      alignment: Alignment.center,
      textStyle: AppTextStyle.text16Reg.copyWith(
        color: AppColorsLight.instance.primaryColorWhite,
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
  primaryColor: AppColorsLight.instance.primaryColorBlue,
  highlightColor: AppColorsLight.instance.primaryColorBrownDark2,
  primarySwatch:
      generateMaterialColor(AppColorsLight.instance.primaryColorBlue),
  shadowColor: AppColorsLight.instance.primaryColorGrey,
  focusColor: AppColorsLight.instance.primaryColorBrownDark,
  dividerColor: AppColorsLight.instance.primaryColorBlack,
  hintColor: AppColorsLight.instance.primaryColorBrownLight,
  hoverColor: AppColorsLight.instance.primaryColorWhite0,
  // primaryColorDark: AppColorsLight.instance.primaryColorBlue ,
  // primaryColorLight:  AppColorsLight.instance.primaryColorBrownDark,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: AppColorsLight.instance.primaryColorBlue,
    selectedIconTheme: IconThemeData(
      color: AppColorsLight.instance.primaryColorBrownDark,
      size: 26,
    ),
    unselectedIconTheme: IconThemeData(
      color: AppColorsLight.instance.primaryColorWhite,
      size: 24,
    ),
    selectedItemColor: AppColorsLight.instance.primaryColorBrownDark,
    unselectedItemColor: AppColorsLight.instance.primaryColorWhite,
    selectedLabelStyle: AppTextStyle.text16Reg,
    unselectedLabelStyle: AppTextStyle.text14Reg,
    type: BottomNavigationBarType.fixed,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColorsLight.instance.primaryColorBrownDark,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(320))),
  scaffoldBackgroundColor: AppColorsLight.instance.primaryColorWhite,
  textTheme: TextTheme(
    bodySmall: AppTextStyle.text12Reg.copyWith(
      color: AppColorsLight.instance.primaryColorBrownDark,
    ),
    bodyMedium: AppTextStyle.text14Reg.copyWith(
      color: AppColorsLight.instance.primaryColorBrownDark,
    ),
    bodyLarge: AppTextStyle.text18Reg.copyWith(
      color: AppColorsLight.instance.primaryColorBrownDark,
    ),
    headlineSmall: AppTextStyle.text14Reg.copyWith(
      color: AppColorsLight.instance.primaryColorBlue,
    ),
    headlineMedium: AppTextStyle.text16Reg.copyWith(
      color: AppColorsLight.instance.primaryColorBlue,
    ),
    labelLarge: AppTextStyle.text16Reg.copyWith(
      color: AppColorsLight.instance.primaryColorBrownDark,
    ),
    displaySmall: AppTextStyle.text12Reg.copyWith(
      color: AppColorsLight.instance.primaryColorBlue,
    ),
    displayMedium: AppTextStyle.text20Mid.copyWith(
      color: AppColorsLight.instance.primaryColorWhite,
    ),
    displayLarge: AppTextStyle.text14Reg.copyWith(
      color: AppColorsLight.instance.primaryColorWhite,
    ),
    headlineLarge: AppTextStyle.text14Bold.copyWith(
      color: AppColorsLight.instance.primaryColorBlue,
    ),
    labelSmall: AppTextStyle.text14Bold.copyWith(
      color: AppColorsLight.instance.primaryColorBrownDark,
    ),
    labelMedium: AppTextStyle.text12SimBold.copyWith(
      color: AppColorsLight.instance.primaryColorBlue,
    ),
    titleLarge: AppTextStyle.text30SimBold.copyWith(
      color: AppColorsLight.instance.primaryColorBlue,
    ),
    titleMedium:   AppTextStyle.text18SimBold.copyWith(
      color: AppColorsLight.instance.primaryColorBlue,
    )
  ),
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(
      color: AppColorsLight.instance.primaryColorBrownDark,
    ),
    centerTitle: true,
    backgroundColor: AppColorsLight.instance.primaryColorWhite,
    actionsIconTheme: const IconThemeData(),
    elevation: 0,
    titleTextStyle: AppTextStyle.text18Reg.copyWith(
      color: AppColorsLight.instance.primaryColorBlue,
      fontWeight: FontWeight.w600,
    ),
  ),
);

MaterialColor generateMaterialColor(Color color) {
  return MaterialColor(color.value, {
    50: tintColor(color, 0.9),
    100: tintColor(color, 0.8),
    200: tintColor(color, 0.6),
    300: tintColor(color, 0.4),
    400: tintColor(color, 0.2),
    500: color,
    600: shadeColor(color, 0.1),
    700: shadeColor(color, 0.2),
    800: shadeColor(color, 0.3),
    900: shadeColor(color, 0.4),
  });
}

int tintValue(int value, double factor) =>
    max(0, min((value + ((255 - value) * factor)).round(), 255));

Color tintColor(Color color, double factor) => Color.fromRGBO(
    tintValue(color.red, factor),
    tintValue(color.green, factor),
    tintValue(color.blue, factor),
    1);

int shadeValue(int value, double factor) =>
    max(0, min(value - (value * factor).round(), 255));

Color shadeColor(Color color, double factor) => Color.fromRGBO(
    shadeValue(color.red, factor),
    shadeValue(color.green, factor),
    shadeValue(color.blue, factor),
    1);
