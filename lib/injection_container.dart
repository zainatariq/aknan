import 'features/add-maintenance-request/repo/add_maintenance_request_repo.dart';
import 'features/home-app/pages/Settings/repo/settings_repo.dart';
import 'features/home-app/pages/home/repo/home_repo.dart';
import 'package:get_it/get_it.dart';

import 'bases/developer_settings/cubit/developer_cubit.dart';
import 'bases/pagination/controller/pagination_controller.dart';
import 'bases/pagination/typedef/page_typedef.dart';
import 'features/add-maintenance-request/cubit/cubit/add_maintenance_request_cubit.dart';
import 'features/authenticate/data/repo-imp/auth_repo_imp.dart';
import 'features/authenticate/data/services/local/local_auth.dart';
import 'features/authenticate/data/services/remote/remote_auth.dart';
import 'features/authenticate/domain/repo/auth_repo.dart';
import 'features/authenticate/domain/use-cases/auth_cases.dart';
import 'features/authenticate/presentation/forgot_password/cubit/forgot_password_cubit.dart';
import 'features/authenticate/presentation/login-with-otp/cubit/otp_log_in_screen_cubit.dart';
import 'features/authenticate/presentation/login-with-pass/cubit/login_with_pass_cubit.dart';
import 'features/authenticate/presentation/reset-password-screen/cubit/reset_password_cubit.dart';
import 'features/authenticate/presentation/sign-up/cubit/complete_data_cubit.dart';
import 'features/authenticate/presentation/verfictaion-screen/cubit/verfictaion_screen_cubit.dart';
import 'features/elevator-more-info-page/cubit/elevator_more_info_cubit.dart';
import 'features/elevator-more-info-page/repo/elevator_more_info_repo.dart';
import 'features/elevators-by-id/pagnaintion/use-case/get_elevators_by_id_use_case.dart';
import 'features/home-app/main-bg-page/cubit/main_bg_cubit.dart';
import 'features/home-app/pages/Settings/cubit/settings_cubit.dart';
import 'features/home-app/pages/home/cubit/cubit/home_sub_screen_cubit.dart';
import 'features/home-app/pages/profile/cubit/profile_cubit.dart';
import 'features/notification/cubit/notification_cubit.dart';
import 'features/onboarding/controller/cubit/on_boarding_controller_cubit.dart';
import 'global/theme/themes/cubit/theme_cubit_cubit.dart';
import 'helpers/cache_helper.dart';
import 'localization/cubit/localization_cubit.dart';
import 'networking/DioClient.dart';
import 'networking/api_service.dart';
import 'networking/network_service.dart';

final sl = GetIt.instance;

final getIt = sl();

Future<void> initializeDependencies() async {
  CacheHelper.init();

  sl.registerLazySingleton<DeveloperCubit>(() => DeveloperCubit());
  sl.registerSingleton<DioClient>(DioClient());
  sl.registerSingleton<NetworkService>(NetworkService(sl<DioClient>()));
  sl.registerSingleton<ApiService>(ApiService(sl<NetworkService>()));

  // sl.registerLazySingleton<RemoteApiAuth>(
  //     () => RemoteApiAuth(DioClient.instance));
  // sl.registerLazySingleton<ApiService>(() => ApiService(sl<NetworkService>()));

  sl.registerLazySingleton<LocalAuth>(() => LocalAuth());

  sl.registerLazySingleton<AuthRepo>(
    () => AuthRepoImp(
      remoteApiAuth: sl(),
      localAuth: sl(),
    ),
  );

  /// repo

  //UseCases
  sl.registerLazySingleton<AuthCases>(() => AuthCases(sl()));
  sl.registerLazySingleton<GetElevatorsByIdUseCase>(
    () => GetElevatorsByIdUseCase(null),
  );

  //repo
  sl.registerLazySingleton<HomeRepo>(() => HomeRepo(sl<ApiService>()));
  sl.registerLazySingleton<SettingsRepo>(() => SettingsRepo(sl<ApiService>()));
  sl.registerLazySingleton<AddMaintenanceRequestRepo>(
      () => AddMaintenanceRequestRepo(sl<ApiService>()));
  sl.registerLazySingleton<ElevatorMoreInfoRepo>(
      () => ElevatorMoreInfoRepo(sl<ApiService>()));

  // controllers
  sl.registerLazySingleton<OnBoardingControllerCubit>(
      () => OnBoardingControllerCubit());
  sl.registerLazySingleton<LoginWithPassCubit>(
      () => LoginWithPassCubit(sl<AuthCases>()));
  sl.registerLazySingleton<ForgotPasswordCubit>(
      () => ForgotPasswordCubit(sl<AuthCases>()));
  sl.registerLazySingleton<OtpLogInScreenCubit>(
      () => OtpLogInScreenCubit(sl<AuthCases>()));
  sl.registerLazySingleton<CompleteDataCubit>(
      () => CompleteDataCubit(sl<AuthCases>(), sl<ApiService>()));
  sl.registerLazySingleton<ResetPasswordCubit>(
      () => ResetPasswordCubit(sl<AuthCases>()));
  sl.registerLazySingleton<VerificationScreenCubit>(
      () => VerificationScreenCubit(
            sl<AuthCases>(),
          ));

  sl.registerLazySingleton<MainBgCubit>(() => MainBgCubit());
  sl.registerLazySingleton<NotificationCubit>(() => NotificationCubit());
  sl.registerLazySingleton<HomeNetSubScreenCubit>(
    () => HomeNetSubScreenCubit(
      sl<HomeRepo>(),
    ),
  );
  sl.registerLazySingleton<SettingsCubit>(() => SettingsCubit());
  sl.registerLazySingleton<SettingsNetCubit>(
      () => SettingsNetCubit(sl<SettingsRepo>()));
  sl.registerLazySingleton<ElevatorMoreInfoCubit>(
      () => ElevatorMoreInfoCubit(sl<ElevatorMoreInfoRepo>()));

  sl.registerLazySingleton<ProfileCubit>(() => ProfileCubit());
  sl.registerLazySingleton<ThemeCubitCubit>(() => ThemeCubitCubit());
  sl.registerLazySingleton<LocalizationCubit>(() => LocalizationCubit());
  sl.registerLazySingleton<AddMaintenanceRequestCubit>(
      () => AddMaintenanceRequestCubit());
  sl.registerLazySingleton<AddMaintenanceRequestNetCubit>(
      () => AddMaintenanceRequestNetCubit(sl()));
  // sl.registerLazySingleton<PaginateGetElevatorsByIdController>(
  //     () => PaginateGetElevatorsByIdController(sl<GetElevatorsByIdUseCase>()));
}
