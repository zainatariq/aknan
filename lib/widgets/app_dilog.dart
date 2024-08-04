import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../global/app-assets/assets.dart';
import '../global/theme/app-colors/app_colors_light.dart';
import '../global/theme/app-text-styles/app_text_styles.dart';
import '../global/theme/themes/cubit/theme_cubit_cubit.dart';
import '../helpers/button_styles.dart';
import '../localization/change_language.dart';
import '../localization/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppDialog extends StatelessWidget {
  final Widget body;
  const AppDialog({
    super.key,
    required this.body,
  });

  factory AppDialog.logOut() {
    return AppDialog(
      body: Builder(builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // SVG picture
            SvgPicture.asset(
              Assets
                  .imagesSvgsIconDrawerSignOut, // Replace with your SVG file path
              height: 50, // Adjust the height as needed
              width: 50, // Adjust the width as needed
            ),

            const SizedBox(height: 16.0),

            Text(
              LocaleKeys.logout_confirmation.tre,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColorsLight.instance.primaryColorBlue,
                    fontSize: 18.sp,
                  ),
            ),

            const SizedBox(height: 20),
            Row(
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
                        // Handle the first button action
                        Navigator.pop(context, true);
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
          ],
        );
      }),
    );
  }

  factory AppDialog.changePass() {
    return AppDialog(
      body: Builder(builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // SVG picture
            SvgPicture.asset(
              Assets.imagesSvgsChangePass, // Replace with your SVG file path
              height: 50, // Adjust the height as needed
              width: 50, // Adjust the width as needed
            ),

            const SizedBox(height: 16.0),

            Text(
              LocaleKeys.password_changed.tre,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColorsLight.instance.primaryColorBlue,
                    fontSize: 22.sp,
                  ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle the first button action
                Navigator.pop(context);
              },
              style: const ButtonStyle().blue.copyWith(
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 100,
                      ),
                    ),
                  ),
              child: Text(LocaleKeys.done.tre),
            ),
          ],
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      backgroundColor: Theme.of(context).hoverColor,
      insetPadding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: body,
      ),
    );
  }
}

class ErrorDialog extends StatelessWidget {
  final String title;
  final String message;
  final void Function() resetState;
  const ErrorDialog({
    super.key,
    required this.title,
    required this.message,
    required this.resetState,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: Text(title)),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      content: Text(
        message.tr(context: context),
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.black),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        ElevatedButton(
          onPressed: resetState,
          child: Text(
            'close'.tr(context: context),
          ),
        ),
      ],
    );
  }
}

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeCubitCubit cubit = ThemeCubitCubit.get(context);
    return Center(
      child: SizedBox(
        width: 100,
        height: 100,
        child: Image.asset(
          cubit.isLightTheme
              ? Assets.imagesGifsLoadingGif
              : Assets.imagesGifsLoadingGif1,
        ),
      ),
    );
  }
}
