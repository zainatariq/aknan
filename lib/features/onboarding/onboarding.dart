import 'package:aknan_user_app/global/theme/app-colors/app_colors_light.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../localization/change_language.dart';
import '../../localization/locale_keys.g.dart';
import 'componants/page_view_body.dart';
import 'controller/cubit/on_boarding_controller_cubit.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // backgroundColor: Colors.white,
          leading: const SizedBox(),
          actions: [
            BlocBuilder<OnBoardingControllerCubit, OnBoardingState>(
              builder: (context, state) {
                OnBoardingControllerCubit cubit =
                    OnBoardingControllerCubit.get(context);
                return Visibility(
                  visible: !cubit.isLastPage,
                  child: TextButton(
                    onPressed: cubit.toLastPage,
                    child: Text(
                      "skip",
                      style: TextStyle(
                        color: Theme.of(context).focusColor,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        // backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            BlocBuilder<OnBoardingControllerCubit, OnBoardingState>(
              builder: (context, state) {
                OnBoardingControllerCubit cubit =
                    OnBoardingControllerCubit.get(context);
                return Expanded(
                  child: PageView.builder(
                    controller: cubit.pageController,
                    itemCount: cubit.tabs.length,
                    physics: const PageScrollPhysics(),
                    pageSnapping: false,
                    itemBuilder: (BuildContext context, int index) {
                      var item = cubit.tabs[index];
                      return PageViewBody(
                        image: item.image,
                        title: item.title.tre,
                        subTitle: item.subtitle.tre,
                      );
                    },
                    onPageChanged: cubit.onPageChanged,
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            BlocBuilder<OnBoardingControllerCubit, OnBoardingState>(
              builder: (context, state) {
                var cubit = OnBoardingControllerCubit.get(context);
                return Center(
                  child: DotsIndicator(
                    dotsCount: cubit.tabs.length,
                    position: cubit.currentIndex,
                    decorator: DotsDecorator(
                      color: Theme.of(context).shadowColor,
                      activeColor: Theme.of(context)
                          .bottomNavigationBarTheme
                          .backgroundColor,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            BlocBuilder<OnBoardingControllerCubit, OnBoardingState>(
              builder: (context, state) {
                var cubit = OnBoardingControllerCubit.get(context);
                return Padding(
                  padding: const EdgeInsets.only(bottom: 26),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (cubit.isLastPage) {
                          cubit.onGetStart(context);
                        } else {
                          cubit.pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 102,
                        ),
                      ),
                      child: Text(
                        cubit.isLastPage
                            ? LocaleKeys.get_started.tre
                            : LocaleKeys.next.tre,
                        style: Theme.of(context)
                            .elevatedButtonTheme
                            .style!
                            .textStyle!
                            .resolve({})!.copyWith(
                                color:
                                    AppColorsLight.instance.primaryColorBlue),
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
