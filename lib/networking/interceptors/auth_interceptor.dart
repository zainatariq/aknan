import '../../localization/change_language.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:one_context/one_context.dart';
import 'package:restart_app/restart_app.dart';

import '../../features/authenticate/data/models/res-models/user_model.dart';
import '../../features/authenticate/domain/use-cases/auth_cases.dart';
import '../../injection_container.dart';
import '../../localization/cubit/localization_cubit.dart';

 class AuthInterceptor extends InterceptorsWrapper {
  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // if (true) {
    if (await sl<AuthCases>().isAuthenticated()) {
      // if (false) {
      UserAuthModel? user = await sl<AuthCases>().getUserData();
      if (kDebugMode) {
        print(" token ::: ${user?.token} , url ::: ${options.uri}");
      }
      options.headers.addAll({
        "Accept": "application/json",
        "X-Authorization": "Bearer ${user?.token}",
        "Accept-Language": TLang.getCurrentLocale(OneContext().context!).name
      });
    }
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (response.statusCode == 405) {
      if (await sl<AuthCases>().isAuthenticated()) {
        sl<AuthCases>().setUserDate(null);
        Restart.restartApp();
      }
    }

    super.onResponse(response, handler);
  }
}
