import 'package:flutter/material.dart';

class AppColorsLight implements AppColors {
  static AppColorsLight get instance => AppColorsLight();
  @override
  Color get primaryColorBlack => Colors.black;

  @override
  Color get primaryColorBlue => const Color(0xff0C3F61);

  @override
  Color get primaryColorBrownDark => const Color(0xff8F734A);

  @override
  Color get primaryColorBrownDark2 => const Color(0xff8E754C);

  @override
  Color get primaryColorBrownLight => const Color(0xffF7ECDC);

  @override
  Color get primaryColorBrownLight1 => const Color(0xffF4F1EC);

  @override
  Color get primaryColorGrey => const Color(0xffCCCCCC);

  @override
  Color get primaryColorWhite => const Color(0xffFFFFFF);

  @override
  Color get primaryColorWhite0 => const Color(0xffF4F8FB);

  // static Color primaryColorBlue = const Color(0xff0C3F61);
  // static Color primaryColorBrownDark = const Color(0xff8F734A);
  // static Color primaryColorBrownLight = const Color(0xffF7ECDC);
  // static Color primaryColorBrownLight1 = const Color(0xffF4F1EC);
  // static Color primaryColorGrey = const Color(0xffCCCCCC);
  // static Color primaryColorWhite = const Color(0xffFFFFFF);
  // static Color primaryColorWhite0 = const Color(0xffF4F8FB);
  // static Color primaryColorBlack = Colors.black;
  // static Color primaryColorBrownDark2 = const Color(0xff8E754C);
}

abstract class AppColors {
  Color get primaryColorBlue;
  Color get primaryColorBrownDark;
  Color get primaryColorBrownLight;
  Color get primaryColorBrownLight1;
  Color get primaryColorGrey;
  Color get primaryColorWhite;
  Color get primaryColorWhite0;
  Color get primaryColorBlack;
  Color get primaryColorBrownDark2;
}
