import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'DioClient.dart';
import 'network_state.dart';

// network_service
class NetworkService {
  final DioClient _dioClient;

  NetworkService(this._dioClient);

  Future<Response> _httpMethodHandler({
    required String endpoint,
    required HttpMethods method,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? data,
    String? mockupResponsePath,
    bool? isFormData,
  }) async {
    switch (method) {
      case HttpMethods.get:
        return await _dioClient.getRequest(
          endpoint: endpoint,
          queryParams: queryParams,
          mockupResponsePath: mockupResponsePath,
        );
      case HttpMethods.post:
        return await _dioClient.postRequest(
          endpoint: endpoint,
          queryParams: queryParams,
          data: data!,
          isFormData: isFormData,
          mockupResponsePath: mockupResponsePath,
        );
      case HttpMethods.put:
        return await _dioClient.putRequest(
          endpoint: endpoint,
          queryParams: queryParams,
          data: data!,
        );
      case HttpMethods.delete:
        return await _dioClient.deleteRequest(
          endpoint: endpoint,
          queryParams: queryParams,
          data: data,
        );
    }
  }

  Future<NetworkState<T>> invokeRequest<T>({
    required String endpoint,
    required HttpMethods method,
    required T Function(dynamic) converter,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? data,
    bool? isFormData,
    String? mockupResponsePath,
    bool? isMockupRequest,
  }) async {
    if (isMockupRequest == true) {
      await Future.delayed(
        const Duration(
          seconds: 3,
        ),
      );

      String jsonString = await rootBundle.loadString(mockupResponsePath!);
      Map<String, dynamic> jsonData = jsonDecode(jsonString);
      return NetworkState<T>.success(data: converter(jsonData));
    }

    try {
      final response = await _httpMethodHandler(
        endpoint: endpoint,
        method: method,
        data: data,
        queryParams: queryParams,
        isFormData: isFormData,
        mockupResponsePath: mockupResponsePath,
      );

      if (response.data['status'] == 200) {
        return NetworkState<T>.success(data: converter(response.data));
      } else {
        print('error status ${response.data['status']} ');

        return NetworkState<T>.error(
          message: response.data?['message'],
          errorList: [response.data?['message']],
        );
      }
    } on SocketException catch (e) {
      // FirebaseCrashlytics.instance.recordError(e, stack);

      return NetworkState<T>.error(
        message: e.message,
        errorList: ['connection_time_out'],
      );
    } on DioException catch (e) {
      debugPrint(e.toString());
      // FirebaseCrashlytics.instance.recordError(e, stack);

      final networkErrorState = await _handleError<T>(
        e,
        onTokenExpired: null,
        //  () {
        // final tokenRefreshed = await _handleRefreshToken<T>(
        //   endpoint: endpoint,
        //   method: method,
        //   mockupRequest: mockupRequest,
        //   mockupResponsePath: mockupResponsePath,
        //   queryParams: queryParams,
        //   converter: converter,
        //   data: data,
        // );
        // if (tokenRefreshed != null) {
        //   return tokenRefreshed;
        // } else {
        //   return null;
        // }
        // },
      );

      return networkErrorState;
    } catch (e) {
      debugPrint(e.toString());
      // FirebaseCrashlytics.instance.recordError(e, stack);
      return NetworkState<T>.error(
        message: e.toString(),
      );
    }
  }

  // Future<NetworkState<T>?> _handleRefreshToken<T>({
  //   required String endpoint,
  //   required HttpMethod method,
  //   required T Function(dynamic) converter,
  //   Map<String, dynamic>? queryParams,
  //   Map<String, dynamic>? data,
  //   String? mockupResponsePath,
  //   bool? mockupRequest,
  // }) async {
  //   final userDataStore = Modular.get<UserDataStore>();
  //   final result = await Modular.get<RefreshTokenUseCase>().invoke(
  //     RefreshTokenRequest(
  //       accessToken: userDataStore.accessToken,
  //       refreshToken: userDataStore.refreshToken,
  //       accessTokenExpirationTime: userDataStore.accessTokenExpirationTime,
  //     ),
  //   );
  //   final refreshTokenData =
  //       result.mapOrNull(success: (value) => value.data.data);

  //   if (refreshTokenData == null) {
  //     return null;
  //   } else {
  //     await userDataStore.setAccessToken(
  //       refreshTokenData.accessToken,
  //     );
  //     await userDataStore.setRefreshToken(
  //       refreshTokenData.refreshToken,
  //     );
  //     await userDataStore.setAccessTokenExpiration(
  //       refreshTokenData.accessTokenExpirationTime,
  //     );
  //     return await invokeRequest(
  //       endpoint: endpoint,
  //       method: method,
  //       data: data,
  //       queryParams: queryParams,
  //       mockupResponsePath: mockupResponsePath,
  //       converter: converter,
  //     );
  //   }
  // }
}

Future<NetworkState<T>> _handleError<T>(DioException dioException,
    {Future<NetworkState<T>?> Function()? onTokenExpired}) async {
  // String contentType =
  //     dioException.response?.headers['content-type']?.first ?? 'unknown';

  // if (contentType == 'application/jose') {
  //   final dncryptedData =
  //       await EncryptionUtil.makeDecryptOfJson(dioException.response?.data);
  //   dioException.response?.data = dncryptedData;
  // }

  if (dioException.type == DioExceptionType.connectionTimeout ||
      dioException.type == DioExceptionType.receiveTimeout) {
    return NetworkState<T>.error(
      message: 'connection_time_out',
    );
  } else if (dioException.response == null) {
    return NetworkState<T>.error(
        message: 'Something went wrong please, Try Again');
  } else if (dioException.response?.statusCode == 401) {
    // final tokenRefreshed = await onTokenExpired();
    // if (tokenRefreshed != null) {
    //   return tokenRefreshed;
    // } else {
    //   showToast(
    //     'Session Time out Login Again',
    //     dismissOtherToast: true,
    //   );
    //   Modular.to.navigate(
    //     AuthenticationModule.authenticationRoute,
    //   );
    // }
    return NetworkState<T>.error(message: 'unAuthorized');
  } else if (dioException.response?.statusCode == 502) {
    return NetworkState<T>.error(message: 'Bad Gateway');
  } else if (dioException.response?.statusCode == 500) {
    return NetworkState<T>.error(message: 'Server Error Try Again Later');
  } else if (dioException.response?.statusCode == 404) {
    return NetworkState<T>.error(message: '404');
  } else if (dioException.response?.statusCode == 400) {
    return NetworkState<T>.error(
      message: dioException.response?.data['message'] ?? 'Something went wrong',
      errorList: (dioException.response?.data?['errorList'] as List?)
          ?.map((e) => e.toString())
          .toList(),
    );
  } else if (dioException.response?.data == null) {
    return NetworkState<T>.error(
        message: 'Something went wrong please, Try Again');
  } else {
    return NetworkState<T>.error(
        message: 'Something went wrong please, Try Again');
  }
}

enum HttpMethods {
  get,
  post,
  put,
  delete,
}
