import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../bases/developer_settings/cubit/developer_cubit.dart';

class MockupInterceptor extends Interceptor {
  final DeveloperCubit developerCubit;
  MockupInterceptor(this.developerCubit);

  bool get _isAllEndpointMocked => developerCubit.state.mockAllEndpoints;

  bool _isEndpointMocked(String endpoint) =>
      developerCubit.state.mockedEndpoints.contains(endpoint);

  void _setMockUrl(RequestOptions options) {
    options.baseUrl = "";
  }

  void _handleMockedEndpoints(RequestOptions options) {
    if (_isAllEndpointMocked) {
      _setMockUrl(options);
    } else if (developerCubit.state.mockedEndpoints.isNotEmpty) {
      if (_isEndpointMocked(options.path)) {
        _setMockUrl(options);
      }
    } else {
      _changeBaseUrl(options);
    }
  }

  void _changeBaseUrl(RequestOptions options) {
    if (developerCubit.state.altBaseUrl != null) {
      options.baseUrl = developerCubit.state.altBaseUrl!;
    }
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    try {
      _handleMockedEndpoints(options);
      // _changeBaseUrl(options);
    } catch (e) {
      if (kDebugMode) {
        debugPrint(e.toString());
      }
    }

    super.onRequest(options, handler);
  }



    @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
   // handel all imgages from local server to dummy img url
    if (response.data is Map) {
      if (response.data.containsKey('data')) {
        if (response.data['data'] is Map) {
          // if (response.data['data'].containsKey('data')) {
            if (response.data['data']['data'] is List) {
              response.data['data']['data'].forEach((element) {
                if (element.containsKey('img')) {
                  element['img'] =
                      'https://www.w3schools.com/w3css/img_lights.jpg';
                }
              });
            // }
          }
        }
      }
    }

    super.onResponse(response, handler);
  }
}
