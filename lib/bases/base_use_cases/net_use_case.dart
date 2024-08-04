// AppUseCase

import 'package:aknan_user_app/bases/base_use_cases/app_use_case.dart';

abstract class NetUseCase<T, R> implements AppUseCase<T, R> {
  const NetUseCase();

  bool get isConnectedToInternet;
  @override
  Future<T> invoke(R param);
}
