
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:one_context/one_context.dart';

import '../global/theme/themes/app_theme_dark.dart';
import '../global/theme/themes/app_theme_light.dart';
import '../global/theme/themes/cubit/theme_cubit_cubit.dart';
import '../injection_container.dart';
import '../localization/cubit/localization_cubit.dart';
import '../route/route_pages.dart';
class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<ThemeCubitCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<LocalizationCubit>(),
        ),
      ],
      child: BlocBuilder<LocalizationCubit, LocalizationState>(
        bloc: sl<LocalizationCubit>(),
        buildWhen: (previous, current) => current != previous,
        builder: (context, state) {
          return BlocBuilder<ThemeCubitCubit, ThemeCubitState>(
            bloc: sl<ThemeCubitCubit>(),
            builder: (context, state) {
              ThemeCubitCubit th = sl<ThemeCubitCubit>();

              return MaterialApp(
                theme: lightThemeData,
                darkTheme: darkThemeData,
                navigatorObservers: [
                  ChuckerFlutter.navigatorObserver,
                ],
                navigatorKey: OneContext().navigator.key,
                themeMode: th.current,
                builder: OneContext().builder,
                debugShowCheckedModeBanner: false,
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,

                onGenerateRoute: AppRouteManger.onGenerateRoutes,
                initialRoute: AppRouteManger.initial,
                // home: MaintenanceWorkPage(id: "gvcjgc"),
              );
            },
          );
        },
      ),
    );
  }
}