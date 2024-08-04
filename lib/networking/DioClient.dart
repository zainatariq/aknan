import 'dart:developer';
import 'dart:io';

import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../bases/developer_settings/cubit/developer_cubit.dart';
import '../injection_container.dart';
import 'api_constants.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/error_interceptor.dart';
import 'mockup_utility.dart';

class DioClient {
  static Dio? _dio;

  DioClient() {
    getInstance();
  }

  setBaseUrl(String url) {
    _dio?.options.baseUrl = url;
  }

  static DioAdapter? dioAdapter;

  static Dio get instance => getInstance();

  static Dio getInstance() {
    if (_dio != null) return _dio!;
    var duration = const Duration(minutes: 1);
    _dio = Dio(BaseOptions(
      baseUrl: APiConstants.getENVUrl,
      persistentConnection: true,
      sendTimeout: duration,
      receiveTimeout: duration,
      connectTimeout: duration,
      contentType: "application/json",
      validateStatus: (statusCode) {
        if (statusCode == null) {
          return false;
        }
        return true;
        if (statusCode == 403 && statusCode == 404 && statusCode == 401) {
          return true;
        }
        if (statusCode == 422) {
          // your http status code
          return true;
        } else {
          return statusCode >= 200 && statusCode < 300;
        }
      },
    ));
    // _dio?.interceptors.add(LogInterceptor());
    _dio?.interceptors.add(AuthInterceptor());
    _dio?.interceptors.add(ErrorInterceptor());
    _dio?.interceptors.add(ChuckerDioInterceptor());

    _dio?.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      request: true,
      responseHeader: true,
      responseBody: true,
      logPrint: (object) {
        log(
          object.toString(),
          name: "PrettyDioLogger :::",
        );
      },
    ));
    if (APiConstants.enableMockUp) {
      dioAdapter = DioAdapter(dio: _dio!);
      _dio!.httpClientAdapter = dioAdapter!;
    }
    // dio?.interceptors.add(
    //   DioCacheManager(CacheConfig(
    //     baseUrl: APiConstants.getENVUrl("v4"),
    //   )).interceptor,
    // );
    return _dio!;
  }

  Future<Response> getRequest({
    required String endpoint,
    Map<String, dynamic>? queryParams,
    String? mockupResponsePath,
  }) async {
    if (APiConstants.enableMockUp) {
      final developerCubit = sl.get<DeveloperCubit>();
      _dio!.httpClientAdapter = IOHttpClientAdapter();
      if (!developerCubit.isEndpointSelected(endpoint)) {
        dioAdapter = DioAdapter(dio: _dio!);
        MockupUtils.mockGetRequest(
          mockResponsePath: mockupResponsePath.toString(),
          requestEndPoint: endpoint,
        );
      }
    }

    return await _dio!.get(
      endpoint,
      queryParameters: queryParams,
    );
  }

  Future<Response> postRequest({
    required String endpoint,
    required Map<String, dynamic> data,
    Map<String, dynamic>? queryParams,
    String? mockupResponsePath,
    bool? isFormData,
  }) async {
    if (APiConstants.enableMockUp) {
      final developerCubit = sl.get<DeveloperCubit>();
      _dio!.httpClientAdapter = IOHttpClientAdapter();
      if (!developerCubit.isEndpointSelected(endpoint)) {
        dioAdapter = DioAdapter(dio: _dio!);
        MockupUtils.mockPostRequest(
          mockResponsePath: mockupResponsePath!,
          requestEndPoint: endpoint,
          requestData: data,
        );
      }
    }

    return await _dio!.post(
      endpoint,
      data: isFormData == true ? FormData.fromMap(data) : data,
      queryParameters: queryParams,
    );
  }

  Future<Response> putRequest({
    required String endpoint,
    required Map<String, dynamic> data,
    Map<String, dynamic>? queryParams,
  }) async {
    return await _dio!.put(
      endpoint,
      data: data,
      queryParameters: queryParams,
    );
  }

  Future<Response> deleteRequest({
    required String endpoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParams,
  }) async =>
      await _dio!.delete(
        endpoint,
        data: data,
        queryParameters: queryParams,
      );
  void setupSslConnection(Dio dioClient) {
    (dioClient.httpClientAdapter as IOHttpClientAdapter).validateCertificate =
        (X509Certificate? cert, String? host, int? port) => true;
  }
}
