import 'dart:convert';

import 'package:flutter/services.dart';

import 'DioClient.dart';


class MockupUtils {
  static mockPostRequest({
    required String mockResponsePath,
    required String requestEndPoint,
    required dynamic requestData,
  }) async {
    String mockedResponse = await rootBundle.loadString(mockResponsePath);
    DioClient.dioAdapter?.onPost(
      requestEndPoint,
      (request) => request.reply(
        200,
        json.decode(mockedResponse),
      ),
      data: requestData,
    );
  }

  static mockGetRequest({
    required String mockResponsePath,
    required String requestEndPoint,
    Map<String, dynamic>? requestData,
  }) async {
    String mockedResponse = await rootBundle.loadString(mockResponsePath);
    DioClient.dioAdapter?.onGet(
      requestEndPoint,
          (request) => request.reply(
        200,
        json.decode(mockedResponse),
      ),
      queryParameters: requestData,
    );
  }

}


