import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../global/app-assets/assets.dart';
import '../../../../helpers/cache_helper.dart';
import '../../../../helpers/navigation.dart';
import '../../../../localization/locale_keys.g.dart';
import '../../../../route/paths.dart';
import '../../model/onboard_model.dart';

part 'on_boarding_controller_state.dart';

class OnBoardingControllerCubit extends Cubit<OnBoardingState> {
  OnBoardingControllerCubit() : super(OnBoardingInitial());

  static OnBoardingControllerCubit get(context) =>
      BlocProvider.of<OnBoardingControllerCubit>(context);

  List<OnboardingModel> tabs = [
    OnboardingModel(
      Assets.imagesPngsOnBoraeding1,
      LocaleKeys.choose_your_elevator,
      LocaleKeys.elevator_company_intro,
    ),
    OnboardingModel(
      Assets.imagesPngsOnBoraeding2,
      LocaleKeys.maintenance_service,
      LocaleKeys.elevator_company_intro_2,
    ),
    OnboardingModel(
      Assets.imagesPngsOnBoraeding3,
      LocaleKeys.spare_parts,
      LocaleKeys.elevator_company_intro_3,
    ),
  ];

  final pageController = PageController();

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  bool get isLastPage => _currentIndex == tabs.length - 1;
  onPageChanged(value) {
    _currentIndex = value;
    // pageController.animateToPage(
    //   value,
    //   duration: const Duration(milliseconds: 300),
    //   curve: Curves.bounceInOut,
    // );
    emit(OnBoardingChangePage(index: _currentIndex));
  }

  void toLastPage() {
    int lastIndex = tabs.length - 1;

    pageController.animateToPage(
      lastIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.bounceInOut,
    );
    onPageChanged(lastIndex);

  }

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }

  static String get onBordKey => "onBordKey";

  static bool get isPassedOnbord =>
      CacheHelper.getValue(kay: onBordKey) ?? false;

  onGetStart(BuildContext context) async {
    CacheHelper.setValue(kay: onBordKey, value: true).whenComplete(
        () => context.pushReplacementNamed(AppPaths.loginWithPass));
  }
}
