// info_app_page
import 'package:aknan_user_app/global/app-assets/assets.dart';
import 'package:aknan_user_app/localization/change_language.dart';
import 'package:aknan_user_app/widgets/app_back_btn.dart';
import 'package:aknan_user_app/widgets/app_notification_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class InfoAppPage extends StatelessWidget {
  final String title;

  final Widget? body;

  const InfoAppPage({
    super.key,
    required this.title,
    this.body,
  });

  factory InfoAppPage.contactUs({
    required String title,
    required String email,
    required String phone,
  }) {
    return InfoAppPage(
      title: title,
      body: Center(
        child: Builder(builder: (context) {
          return Container(
              height: 315.h,
              width: 368.w,
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: Theme.of(context).hoverColor,
                borderRadius: BorderRadius.circular(7),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(child: Image.asset(Assets.imagesPngsLogo)),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(Assets.imagesSvgsIcoCallContUs),
                      const SizedBox(width: 5),
                      Text(phone),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(Assets.imagesSvgsWhatsapp),
                      const SizedBox(width: 5),
                      Text(phone),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(Assets.imagesSvgsMailContantUs),
                      const SizedBox(width: 5),
                      Text(email),
                    ],
                  ),
                ],
              ));
        }),
      ),
    );
  }

  factory InfoAppPage.htmlBody({
    required String title,
    required String htmlBody,
  }) {
    return InfoAppPage(
      title: title,
      body: SingleChildScrollView(
        child: HtmlWidget(htmlBody),
      ),
    );
  }
  factory InfoAppPage.bodyText({
    required String title,
    required String body,
  }) {
    return InfoAppPage(
      title: title,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Builder(builder: (context) {
          return Column(
            children: [
              Text(
                body,
                style: Theme.of(context).textTheme.bodyMedium,
              )
            ],
          );
        }),
      ),
    );
  }

  bool _checkForHtml(String input) {
    RegExp htmlRegExp = RegExp(r'<[^>]*>');

    return htmlRegExp.hasMatch(input);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title.tre),
        leading: const AppBackBtn(),
        actions: const [
          AppNotificationWidget(),
        ],
      ),
      body: body,
    );
  }
}
