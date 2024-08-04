enum ENVIRONMENT {
  DEV,
  QC,
  PROD,
  MOCKUP,
}

class APiConstants {
  static var environment = ENVIRONMENT.DEV;

  static const BASE_DEV_URL =
      "-----";
  static const BASE_DEV_URL_With_User =
      "----";

  static const BASE_QC_URL = "";

  static const BASE_PROD_URL = "";

  static String get getENVUrl {
    var url = BASE_DEV_URL;
    if (environment == ENVIRONMENT.DEV) {
      url = BASE_DEV_URL_With_User;
    } else if (environment == ENVIRONMENT.QC) {
      url = BASE_QC_URL;
    } else if (environment == ENVIRONMENT.PROD) {
      url = BASE_PROD_URL;
    } else if (environment == ENVIRONMENT.MOCKUP) {
      APiConstants.enableMockUp = true;
    }

    return url;
  }

  static const defaultSubStatus = 0;

  static bool enableMockUp = false;

  static const String getGovernorate = "get_governorates";
  static const String getCities = "get_cities";
  static const String getDistinct = "get_distincts";
  static const String getProfile = "profile";
  static const String about = "about";
  static const String getHome = "home";
  static const String elevators = "elevators";
  static const String notifications = "notifications";
  static const String malfunctionsList = "malfunctions_list";
  static const String userElevatorsList = "user_elevators_list";
  static const String elevatorNewMaintenance = "elevator_new_maintenance";
    static const String endMaintenanceList = "end_maintenance_list";
    static const String addMaintenance = "add_maintenance";
    static const String newMaintenanceEdit = "new_maintenance_edit";
    static const String newMaintenanceDelete = "new_maintenance_delete";
    static const String chats = "chats";

}

class ApiErrors {
  static const String badRequestError = "badRequestError";
  static const String noContent = "noContent";
  static const String forbiddenError = "forbiddenError";
  static const String unauthorizedError = "unauthorizedError";
  static const String notFoundError = "notFoundError";
  static const String conflictError = "conflictError";
  static const String internalServerError = "internalServerError";
  static const String unknownError = "unknownError";
  static const String timeoutError = "timeoutError";
  static const String defaultError = "defaultError";
  static const String cacheError = "cacheError";
  static const String noInternetError = "noInternetError";
  static const String loadingMessage = "loading_message";
  static const String retryAgainMessage = "retry_again_message";
  static const String ok = "Ok";
}
