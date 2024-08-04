import 'package:aknan_user_app/features/authenticate/data/models/base_model.dart';
import 'package:easy_localization/easy_localization.dart';

import '../features/chat/models/res/msg_chat_res_model_item.dart';
import '../features/notification/pagnaintion/model/get_notification_req_model.dart';
import '../injection_container.dart';
import 'DioClient.dart';
import 'package:dio/dio.dart';

import '../bases/base-models/base_id_value_model.dart';
import '../features/add-maintenance-request/model/user_elevators_list_res_model.dart';
import '../features/elevator-more-info-page/model/new_maintenance_show_res.dart';
import '../features/maintenance-work/pagnaintion/model/res/maintenance_work_res_model.dart';
import '../features/notification/model/notification_model.dart';
import 'mock_ups_path.dart';

import '../bases/base-models/elevator_model.dart';
import '../features/authenticate/data/models/res-models/malti_dropdown.dart';
import '../features/authenticate/data/models/res-models/register_res_model.dart';
import '../features/home-app/pages/Settings/model/setting_model.dart';
import '../features/home-app/pages/home/models/banners.dart';
import 'api_constants.dart';
import 'network_service.dart';
import 'network_state.dart';

// part 'api_service.g.dart';

// @RestApi(baseUrl: APiConstants.BASE_DEV_URL_With_User)
class ApiService {
  final NetworkService _networkService;
  ApiService(this._networkService);

  Future<NetworkState<MaltiDropdown>> getGovernorate() async {
    return await _networkService.invokeRequest(
        method: HttpMethods.get,
        converter: (json) => MaltiDropdown.fromJsonTr(json),
        endpoint: APiConstants.getGovernorate,
        //  mockupResponsePath:
        isMockupRequest: false);
  }

  Future<NetworkState<MaltiDropdown>> getCities(String governorateId) async {
    return await _networkService.invokeRequest(
        method: HttpMethods.get,
        converter: (json) => MaltiDropdown.fromJsonTr(json),
        endpoint: APiConstants.getCities,
        queryParams: {"id": governorateId}
        //  mockupResponsePath:
        // isMockupRequest:
        );
  }

  Future<NetworkState<MaltiDropdown>> getDistinct(String cityId) async {
    return await _networkService.invokeRequest(
        method: HttpMethods.get,
        converter: (json) => MaltiDropdown.fromJsonTr(json),
        endpoint: APiConstants.getDistinct,
        queryParams: {"id": cityId}
        //  mockupResponsePath:
        // isMockupRequest:
        );
  }

  Future<NetworkState<AKnanAuthorizedResModel>> getProfile() async {
    return await _networkService.invokeRequest(
      method: HttpMethods.get,
      converter: (json) => AKnanAuthorizedResModel.fromJson(json),
      endpoint: APiConstants.getProfile,
      //  mockupResponsePath:
      // isMockupRequest:
    );
  }

  //get home data
  Future<NetworkState<HomeRes>> getHomeData() async {
    return await _networkService.invokeRequest(
      method: HttpMethods.get,
      converter: (json) => HomeRes.fromMap(json),
      endpoint: APiConstants.getHome,
      mockupResponsePath: MockUpsPath.getHome,
      isMockupRequest: false,
    );
  }

  Future<NetworkState<AboutUsRes>> getAboutUs() async {
    return await _networkService.invokeRequest(
      method: HttpMethods.get,
      converter: (json) => AboutUsRes.fromMap(json),
      endpoint: APiConstants.about,
      mockupResponsePath: MockUpsPath.getAboutUs,
      isMockupRequest: false,
    );
  }

  Future<NetworkState<ElevatorsModel>> getElevatorsById(
      Map<String, dynamic>? queryParams) async {
    DioClient dioClient = sl<DioClient>();
    dioClient.setBaseUrl(APiConstants.getENVUrl.replaceAll("/user", ""));
    var res = await _networkService.invokeRequest(
      method: HttpMethods.get,
      converter: (json) => ElevatorsModel.fromMap(json),
      endpoint: APiConstants.elevators,
      mockupResponsePath: MockUpsPath.getElevatorsSubTypeByTypeId,
      queryParams: queryParams,
      isMockupRequest: false,
    );
    dioClient.setBaseUrl(APiConstants.getENVUrl);
    return res;
  }

  Future<NetworkState<NotificationsModel>> getNotifications(
      Map<String, dynamic>? queryParams) async {
    return await _networkService.invokeRequest(
      method: HttpMethods.get,
      converter: (json) => NotificationsModel.fromMap(json),
      endpoint: APiConstants.notifications,
      mockupResponsePath: MockUpsPath.getElevatorsSubTypeByTypeId,
      queryParams: queryParams,
      isMockupRequest: false,
    );
  }

  Future<NetworkState<MaltiDropdown>> getMalfunctionsList() async {
    return await _networkService.invokeRequest(
      method: HttpMethods.get,
      converter: (json) => MaltiDropdown.fromJson2(json),
      endpoint: APiConstants.malfunctionsList,
      mockupResponsePath: MockUpsPath.getElevatorsSubTypeByTypeId,
      isMockupRequest: false,
    );
  }

  Future<NetworkState<UserElevatorsList>> getUserElevatorsList({
    bool isPaginate = false,
    Map<String, dynamic>? queryParams,
  }) async {
    return await _networkService.invokeRequest(
      method: HttpMethods.get,
      queryParams: {
        "paginate": isPaginate ? 1 : 0,
      }..addAll(queryParams ?? {}),
      converter: (json) => UserElevatorsList.fromJson(json),
      endpoint: APiConstants.userElevatorsList,
      mockupResponsePath: MockUpsPath.getElevetorsList,
      isMockupRequest: false,
    );
  }

  Future<NetworkState<NewMaintenanceShowRes>> getNewMaintenanceShowRes({
    required String elevatorId,
  }) async {
    return await _networkService.invokeRequest(
      method: HttpMethods.get,
      queryParams: {
        "id": elevatorId,
      },
      converter: (json) => NewMaintenanceShowRes.fromJson(json),
      endpoint: APiConstants.elevatorNewMaintenance,
      mockupResponsePath: MockUpsPath.elevatorNewMaintenance,
      isMockupRequest: false,
    );
  }

  Future<NetworkState<MaintenanceWorkResModel>> getMaintenanceWorkOfElevator(
    Map<String, dynamic>? queryParams,
  ) async {
    return await _networkService.invokeRequest(
      method: HttpMethods.get,
      converter: (json) => MaintenanceWorkResModel.fromMap(json),
      endpoint: APiConstants.endMaintenanceList,
      mockupResponsePath: MockUpsPath.endMaintenanceList,
      queryParams: queryParams,
      isMockupRequest: false,
    );
  }

  Future<NetworkState<MsgModel>> addMaintenance(
      Map<String, dynamic> body) async {
    return await _networkService.invokeRequest(
      method: HttpMethods.post,
      converter: (json) => MsgModel.fromKMap(json),
      endpoint: APiConstants.addMaintenance,
      data: body,
      isFormData: true,
      mockupResponsePath: MockUpsPath.addMaintenance,
      isMockupRequest: false,
    );
  }

  Future<NetworkState<MsgModel>> updateMaintenance({
    required String id,
    required Map<String, dynamic> body,
  }) async {
    return await _networkService.invokeRequest(
      method: HttpMethods.post,
      converter: (json) => MsgModel.fromKMap(json),
      endpoint: "${APiConstants.newMaintenanceEdit}/$id",
      data: body,
      isFormData: true,
      mockupResponsePath: MockUpsPath.addMaintenance,
      isMockupRequest: false,
    );
  }

  Future<NetworkState<MsgModel>> deleteMaintenance({
    required String id,
  }) async {
    return await _networkService.invokeRequest(
      method: HttpMethods.delete,
      converter: (json) => MsgModel.fromKMap(json),
      endpoint: "${APiConstants.newMaintenanceDelete}/$id",
      mockupResponsePath: MockUpsPath.addMaintenance,
      isMockupRequest: false,
    );
  }

  Future<NetworkState<MsgChatResModel>> getListOfChat(
      Map<String, dynamic>? queryParams) async {
    return await _networkService.invokeRequest(
      method: HttpMethods.get,
      converter: (json) => MsgChatResModel.fromJson(json),
      endpoint: APiConstants.chats,
      mockupResponsePath: MockUpsPath.chats,
      queryParams: queryParams,
      isMockupRequest: false,
    );
  }

  Future<NetworkState<MsgChatResModel>> getListOfMsgsInChat(
    String endPoint,
    Map<String, dynamic>? queryParams,
  ) async {
    return await _networkService.invokeRequest(
      method: HttpMethods.get,
      converter: (json) => MsgChatResModel.fromJson(json),
      endpoint: endPoint,
      mockupResponsePath: MockUpsPath.oneChat,
      queryParams: queryParams,
      isMockupRequest: false,
    );
  }

  Future<NetworkState<MsgChatResModel>> postNewMsg(
    Map<String, dynamic> data,
  ) async {
    return await _networkService.invokeRequest(
      method: HttpMethods.post,
      converter: (json) => MsgChatResModel.fromJson(json),
      endpoint: APiConstants.chats,
      mockupResponsePath: MockUpsPath.oneChat,
      data: data,
      isFormData: true,
      isMockupRequest: false,
    );
  }
}
