import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/app_bottom_navigation_bar.dart';
import '../../../widgets/app_page.dart';
import 'cubit/main_bg_cubit.dart';

// main_bg_page
class MainBgPage extends AppScaffold<MainBgCubit> {
  const MainBgPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBgCubit, MainBgState>(
      bloc: cubit,
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () {
            if (!cubit.isInHome) {
              cubit.toHome();
            }
            return Future.value(false);
          },
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 600),
            child: SafeArea(
              key: ValueKey(cubit.currantNavIndex),
              child: Scaffold(
                body: cubit.currentPage,
                bottomNavigationBar: AppBottomNavigationBar(
                  currentIndex: cubit.currantNavIndex,
                  onChange: cubit.setNavIndex,
                ),
              ),
            ),
            transitionBuilder: (Widget child, Animation<double> animate) =>
                FadeTransition(
              opacity: animate,
              child: child,
            ),
          ),
        );
      },
    );
  }
}
