// elevator_view_item
import 'package:aknan_user_app/global/theme/app-colors/app_colors_dark.dart';
import 'package:aknan_user_app/global/theme/app-colors/app_colors_light.dart';
import 'package:aknan_user_app/helpers/navigation.dart';
import 'package:aknan_user_app/localization/change_language.dart';
import 'package:aknan_user_app/route/paths.dart';
import 'package:aknan_user_app/widgets/app_back_btn.dart';
import 'package:aknan_user_app/widgets/app_notification_widget.dart';
import 'package:aknan_user_app/widgets/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

import '../../../../../../bases/base-models/elevator_model.dart';
import '../../../../../../localization/locale_keys.g.dart';

class ElevatorViewItem extends StatelessWidget {
  final ElevatorModel item;
  const ElevatorViewItem({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(
          AppPaths.elevatorsByIdScreen,
          arguments: item.toMap(),
        );
      },
      child: Container(
        height: 120.h,
        width: 368.w,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).hoverColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(7),
              child: CustomImage(
                image: item.viewImg,
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              item.name ?? "",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: AppColorsLight.instance.primaryColorBlue,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class ElevatorDetailsPage extends StatelessWidget {
  final ElevatorModel item;
  const ElevatorDetailsPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    bool isHtml(String input) {
      RegExp htmlRegExp = RegExp(r'<[^>]*>');
      return htmlRegExp.hasMatch(input);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(item.name!),
        leading: const AppBackBtn(),
        actions: const [AppNotificationWidget()],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (item.images != null && item.images!.isNotEmpty)
            SizedBox(
              height: 200.h,
              child: ListView.separated(
                itemCount: item.images!.length,
                padding: const EdgeInsetsDirectional.only(start: 10),
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(width: 10),
                itemBuilder: (BuildContext context, int index) {
                  var img = item.images![index];
                  return CustomImage(
                    image: img,
                    height: 200,
                    width: 150,
                    fit: BoxFit.contain,
                  );
                },
              ),
            ),
          const SizedBox(height: 20),
          DefaultTextStyle(
            style: Theme.of(context).textTheme.headlineMedium!,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(LocaleKeys.price.tre),
                  const Spacer(),
                  Text(item.price.toString()),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: isHtml(item.dic ?? "")
                ? HtmlWidget(item.dic ?? "")
                : Text(item.dic ?? ""),
          ),
        ],
      ),
    );
  }
}
