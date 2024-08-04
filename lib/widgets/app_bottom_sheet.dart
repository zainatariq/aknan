// app_bottom_sheet
import 'package:aknan_user_app/global/app-assets/assets.dart';
import 'package:aknan_user_app/helpers/button_styles.dart';
import 'package:aknan_user_app/localization/change_language.dart';
import 'package:aknan_user_app/localization/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../global/theme/app-colors/app_colors_light.dart';

class AppBottomSheet extends StatelessWidget {
  final Function() onYesTap;
  final String line;
  final String icoPath;
  const AppBottomSheet({
    super.key,
    required this.onYesTap,
    required this.line,
    required this.icoPath,
  });

  factory AppBottomSheet.changeLanguage({required Function() onYesTap}) {
    return AppBottomSheet(
      onYesTap: onYesTap,
      line: LocaleKeys.change_language_confirmation.tre,
      icoPath: Assets.imagesSvgsLanguageIcon,
    );
  }
  factory AppBottomSheet.changePassword({required Function() onYesTap}) {
    return AppBottomSheet(
      onYesTap: onYesTap,
      line: LocaleKeys.change_password_confirmation.tre,
      icoPath: Assets.imagesSvgsSignificonLock,
    );
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 325.h,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              icoPath,
              height: 50,
              width: 50,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                line,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColorsLight.instance.primaryColorBlue,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle the second button action
                          Navigator.pop(context, false);
                        },
                        style: const ButtonStyle().white.copyWith(
                              padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 20,
                                ),
                              ),
                            ),
                        child: Text(
                          LocaleKeys.no.tre,
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context, true);
                          onYesTap.call();
                        },
                        style: const ButtonStyle().blue.copyWith(
                              padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 20,
                                ),
                              ),
                            ),
                        child: Text(LocaleKeys.yes.tre),
                      ),
                    ),
                  ),
                  // const SizedBox(width: 8.0), // Add spacing between buttons
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
