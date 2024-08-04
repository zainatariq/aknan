import '../base_phone_req_model.dart';

abstract class RegisterReqModel {}

class AknanRegisterReqModel extends RegisterReqModel {
  String name;
  String email;
  BasePhoneReqModel phoneReqModel;
  String password;
  String governorateId;
  String cityId;
  String districtId;
  AknanRegisterReqModel({
    required this.name,
    required this.email,
    required this.phoneReqModel,
    required this.password,
    required this.governorateId,
    required this.cityId,
    required this.districtId,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      ...phoneReqModel.toJson(),
      'password': password,
      'password_confirmation': password,
      'governorate_id': governorateId,
      'city_id': cityId,
      'district_id': districtId,
    };
  }
}
