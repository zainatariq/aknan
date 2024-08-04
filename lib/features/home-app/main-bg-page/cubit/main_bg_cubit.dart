import 'package:one_context/one_context.dart';

import '../../../../injection_container.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../chat/chat_screen.dart';
import '../../pages/Settings/ui/widget/settings_screen.dart';
import '../../pages/home/cubit/cubit/home_sub_screen_cubit.dart';
import '../../pages/home/ui/home_sub_screen.dart';
import '../../pages/profile/ui/profile_sub_screen.dart';

part 'main_bg_state.dart';

class MainBgCubit extends Cubit<MainBgState> {
  MainBgCubit() : super(MainBgInitialState());

  final List<Widget> _pages = const [
    HomeSubScreen(),
    ChatScreen(),
    ProfileSubScreen(),
    SettingsSubScreen()
  ];

  static MainBgCubit get(context) => sl<MainBgCubit>();
  List<Widget> get pages => _pages;

  Widget get currentPage => _pages[_currantNavIndex];

  int _currantNavIndex = 0;
  int get currantNavIndex => _currantNavIndex;

  bool reloadHome = false;

  setNavIndex(int index) {
    _currantNavIndex = index;
    emit(MainBgChangeNavIndex(index: _currantNavIndex));
  }


bool get isInHome =>_currantNavIndex==0;
  toHome() async {
    setNavIndex(0);
    // await BlocProvider.of<HomeNetSubScreenCubit>(homeContext!).getHome();
  }

  toHomeWithoutUpdateUi() {
    _currantNavIndex = 0;
  }

  toChat() {
    setNavIndex(1);
  }

  toProfile() {
    setNavIndex(2);
  }

  toSettings() {
    setNavIndex(3);
  }
}
