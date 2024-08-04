import 'package:flutter/material.dart';

import '../global/theme/app-colors/app_colors_light.dart';
import '../global/theme/app-text-styles/app_text_styles.dart';

// button_styles
extension Style on ButtonStyle {
  ButtonStyle get blue => ElevatedButton.styleFrom(
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
      );
  ButtonStyle get white => ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 72,
        ),
        backgroundColor: AppColorsLight.instance.primaryColorWhite,
        alignment: Alignment.center,
        textStyle: AppTextStyle.text16Reg.copyWith(
          color: AppColorsLight.instance.primaryColorBrownDark,
        ),
        
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      );
}
