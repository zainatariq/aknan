

class HandleError {
  static handleException({int? response,}) {
    switch (response) {
      case 422:
        // showCustomSnackBar(
        //     isError: false, AppConstants.success.tr, );
        break;
      case 400:
        // showCustomSnackBar(
        //     isError: true, AppConstants.sendFailure.tr,  );
        break;
      case 401:
        // showCustomSnackBar(
        //     isError: true, AppConstants.unauthorized.tr, );
        break;
      case 404:
        // showCustomSnackBar(
        //     isError: true, AppConstants.notFoundUrl.tr, );
        break;
      case 403:
        // showCustomSnackBar(
        //     isError: true, AppConstants.notHasAuthorized.tr, );
        break;
      case 500:
        // showCustomSnackBar(
        //     isError: true, AppConstants.serverFailure.tr,  );
        break;
      case 502:
        // showCustomSnackBar(
        //     isError: true, AppConstants.serverFailure.tr,  );
        break;
    }
  }

  // static handleExceptionDio(DioError dioExceptionType) {
  //   switch (dioExceptionType) {
  //     case DioError.connectionTimeout:
  //       showCustomSnackBar(isError: true, 'connection timeout' );
  //       break;

  //     case DioExceptionType.sendTimeout:
  //       showCustomSnackBar(isError: true, 'send timeout' );
  //       break;
  //     case DioExceptionType.receiveTimeout:
  //       showCustomSnackBar(isError: true, 'receive timeout');
  //       break;
  //     case DioExceptionType.badCertificate:
  //       showCustomSnackBar(isError: true, 'bad certificate');
  //       break;
  //     case DioExceptionType.badResponse:
  //       showCustomSnackBar(isError: true, 'bad response');
  //       break;
  //     case DioExceptionType.cancel:
  //       showCustomSnackBar(isError: true, 'request cancelled');
  //       break;
  //     case DioExceptionType.connectionError:
  //       showCustomSnackBar(isError: true, 'connection error');
  //       break;
  //     case DioExceptionType.unknown:
  //       showCustomSnackBar(isError: true, 'unknown');
  //       break;
  //   }
  // }

}
