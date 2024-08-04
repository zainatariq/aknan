import 'dart:convert';

import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bases/base-models/elevator_model.dart';
import '../bases/developer_settings/cubit/developer_cubit.dart';
import '../bases/developer_settings/ui/developer_settings_screen.dart';
import '../bases/pagination/typedef/page_typedef.dart';
import '../features/add-maintenance-request/cubit/cubit/add_maintenance_request_cubit.dart';
import '../features/add-maintenance-request/model/req/post_maintenance_req_model.dart';
import '../features/add-maintenance-request/ui/add_maintenance_request_page.dart';
import '../features/authenticate/domain/use-cases/auth_cases.dart';
import '../features/authenticate/enums/auth_enums.dart';
import '../features/authenticate/presentation/forgot_password/cubit/forgot_password_cubit.dart';
import '../features/authenticate/presentation/forgot_password/forget_password_screen.dart';
import '../features/authenticate/presentation/login-with-otp/cubit/otp_log_in_screen_cubit.dart';
import '../features/authenticate/presentation/login-with-otp/otp_log_in_screen.dart';
import '../features/authenticate/presentation/login-with-pass/cubit/login_with_pass_cubit.dart';
import '../features/authenticate/presentation/login-with-pass/sign_in_screen.dart';
import '../features/authenticate/presentation/reset-password-screen/cubit/reset_password_cubit.dart';
import '../features/authenticate/presentation/reset-password-screen/reset_password_screen.dart';
import '../features/authenticate/presentation/sign-up/complete_data_screen.dart';
import '../features/authenticate/presentation/sign-up/cubit/complete_data_cubit.dart';
import '../features/authenticate/presentation/verfictaion-screen/cubit/verfictaion_screen_cubit.dart';
import '../features/authenticate/presentation/verfictaion-screen/verification_screen.dart';
import '../features/elevators-by-id/pagnaintion/use-case/get_elevators_by_id_use_case.dart';
import '../features/elevators-by-id/ui/elevators_by_id_screen.dart';
import '../features/home-app/main-bg-page/cubit/main_bg_cubit.dart';
import '../features/home-app/main-bg-page/main_bg_page_screen.dart';
import '../features/home-app/pages/Settings/cubit/settings_cubit.dart';
import '../features/home-app/pages/Settings/ui/widget/settings_screen.dart';
import '../features/home-app/pages/home/cubit/cubit/home_sub_screen_cubit.dart';
import '../features/home-app/pages/home/ui/home_sub_screen.dart';
import '../features/home-app/pages/home/ui/widget/elevator_view_item.dart';
import '../features/home-app/pages/profile/cubit/profile_cubit.dart';
import '../features/home-app/pages/profile/ui/profile_sub_screen.dart';
import '../features/notification/cubit/notification_cubit.dart';
import '../features/notification/ui/notification_screen.dart';
import '../features/onboarding/controller/cubit/on_boarding_controller_cubit.dart';
import '../features/onboarding/onboarding.dart';
import '../injection_container.dart';
import '../networking/api_service.dart';
import '../widgets/chucker_flutter_page.dart';
import 'paths.dart';

class AppRouteManger {
  static String get initial {
    // return AppPaths.homeScreen;
    if (!OnBoardingControllerCubit.isPassedOnbord) {
      return AppPaths.onBoardingScreen;
    }

    if (VerificationScreenCubit.isHaveSavedPhone) {
      return AppPaths.signUp;
    }
    if (!LoginWithPassCubit.isAuthed) {
      return AppPaths.loginWithPass;
    } else {
      return AppPaths.homeScreen;
    }
  }

  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case AppPaths.elevatorDetailsPage:
        var args = (settings.arguments ?? {}) as Map<String, dynamic>;
        return _materialRoute(
          ElevatorDetailsPage(
            item: ElevatorModel.fromMap(args['item']),
          ),
        );
      case AppPaths.elevatorsByIdScreen:
        var args = (settings.arguments ?? {}) as Map<String, dynamic>;
        return _materialRoute(
          ElevatorsByIdScreen(
            elevatorModel: ElevatorModel.fromMap(args),
          ),
        );

      case AppPaths.onBoardingScreen:
        // _initDi<OnBoardingControllerCubit>(OnBoardingControllerCubit());
        return _materialRoute(BlocProvider(
          create: (context) => OnBoardingControllerCubit(),
          child: const OnBoardingScreen(),
        ));
      case AppPaths.developerSettingsRoute:
        // _initDi<OnBoardingControllerCubit>(OnBoardingControllerCubit());
        return _materialRoute(BlocProvider(
          create: (context) => DeveloperCubit(),
          child: const DeveloperSettingsScreen(),
        ));
      case AppPaths.loginWithPass:
        return _materialRoute(
          BlocProvider<LoginWithPassCubit>(
            create: (context) => LoginWithPassCubit(sl<AuthCases>()),
            child: SignInScreen(),
          ),
        );
      case AppPaths.forgetPassword:
        return _materialRoute(
          BlocProvider<ForgotPasswordCubit>(
            create: (context) => ForgotPasswordCubit(sl<AuthCases>()),
            child: ForgotPasswordScreen(),
          ),
        );
      case AppPaths.loginWithOtp:
        return _materialRoute(
          BlocProvider<OtpLogInScreenCubit>(
            create: (context) => OtpLogInScreenCubit(sl<AuthCases>()),
            child: OtpLoginScreen(),
          ),
        );
      case AppPaths.addMaintenanceRequestPage:
        var args = (settings.arguments ?? {}) as Map<String, dynamic>;

        return _materialRoute(
          BlocProvider<AddMaintenanceRequestCubit>(
            create: (context) => AddMaintenanceRequestCubit(),
            child: AddMaintenanceRequestPage(
              id: args['id'],
              req: args.containsKey("data")
                  ? PostMaintenanceReqModel.fromJson(jsonDecode(args["data"]))
                  : null,
            ),
          ),
        );
      case AppPaths.signUp:
        return _materialRoute(
          BlocProvider<CompleteDataCubit>(
            create: (context) =>
                CompleteDataCubit(sl<AuthCases>(), sl<ApiService>()),
            child: CompleteDataScreen(),
          ),
        );
      case AppPaths.notificationScreen:
        return _materialRoute(
          BlocProvider<NotificationCubit>(
            create: (context) => NotificationCubit(),
            child: const NotificationScreen(),
          ),
        );
      case AppPaths.homeScreen:
        return _materialRoute(
          MultiBlocProvider(
            providers: [
              BlocProvider<MainBgCubit>.value(
                value: MainBgCubit(),
              ),
              BlocProvider<HomeNetSubScreenCubit>(
                create: (_) => sl<HomeNetSubScreenCubit>(),
                child: const HomeSubScreen(),
              ),
              MultiBlocProvider(
                providers: [
                  BlocProvider<SettingsCubit>(
                    create: (_) => SettingsCubit(),
                  ),
                  BlocProvider<SettingsNetCubit>(
                    create: (_) => sl<SettingsNetCubit>(),
                  ),
                ],
                child: const SettingsSubScreen(),
              ),
              BlocProvider<ProfileCubit>(
                create: (_) => ProfileCubit(),
                child: const ProfileSubScreen(),
              ),
            ],
            child: const MainBgPage(),
          ),
        );
      case AppPaths.verificationScreen:
        var args = (settings.arguments ?? {}) as Map<String, dynamic>;

        return _materialRoute(
          BlocProvider<VerificationScreenCubit>(
            create: (context) => VerificationScreenCubit(sl<AuthCases>()),
            child: VerificationScreen(
              number: args["nums"],
              countryCode: args["countryCode"],
              otpState: OtpState.values
                  .firstWhere((element) => element.name == args["otpState"]),
            ),
          ),
        );
      case AppPaths.changePassScreen:
        var args = (settings.arguments ?? {}) as Map<String, dynamic>;
        return _materialRoute(
          BlocProvider<ResetPasswordCubit>(
            create: (context) => ResetPasswordCubit(sl<AuthCases>()),
            child: ResetPasswordScreen(
              countryCode: args['countryCode'],
              phone: args['phone'],
              fromChangePassword: args['fromChangePassword'],
              otpCode: args['otpCode'],
            ),
          ),
        );

      default:
        return _materialRoute(const Scaffold());
      // return _materialRoute(const MoviesHomeView());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => ChuckerFlutterPage(child: view));
  }
}
