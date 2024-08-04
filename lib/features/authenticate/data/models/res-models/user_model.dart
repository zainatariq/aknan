// To parse this JSON data, do
//
//     final userAuthModel = userAuthModelFromJson(jsonString);

import 'dart:convert';
import 'dart:ui';

import '../../../../../bases/base-models/base_id_value_model.dart';

UserAuthModel userAuthModelFromJson(String str) =>
    UserAuthModel.fromMap(json.decode(str));

String userAuthModelToJson(UserAuthModel data) => json.encode(data.toMap());

typedef BaseIN = BaseIdNameTRModelString?;

BaseIN baseINFromJson(Map<String,dynamic> str)  {
return BaseIN.fromMap(str);
}

class UserAuthModel {
  String? id;
  String? name;
  String? username;
  String? email;
  String? phoneCode;
  String? phone;
  bool? isActive;
  bool? isBanned;
  bool? isDataCompleted;

  BaseIN governorateId;
  BaseIN cityId;
  BaseIN districtId;
  String? token;
  DateTime? createdAt;

  UserAuthModel({
    this.id,
    this.name,
    this.username,
    this.email,
    this.phoneCode,
    this.phone,
    this.isActive,
    this.isBanned,
    this.isDataCompleted,
    this.governorateId,
    this.cityId,
    this.districtId,
    this.token,
    this.createdAt,
  });

  factory UserAuthModel.fromMap(Map<String, dynamic> json) => UserAuthModel(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
        phoneCode: json["phone_code"],
        phone: json["phone"],
        isActive: json["is_active"],
        isBanned: json["is_banned"],
        isDataCompleted: json["is_data_completed"],
        governorateId: json["governorate_id"] != null
            ? baseINFromJson(json["governorate_id"])
            : null,
        cityId: json["city_id"] != null
            ? baseINFromJson(json["city_id"])
            : null,
        districtId: json["district_id"] != null
            ? baseINFromJson(json["district_id"])
            : null,
        token: json["token"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "username": username,
        "email": email,
        "phone_code": phoneCode,
        "phone": phone,
        "is_active": isActive,
        "is_banned": isBanned,
        "is_data_completed": isDataCompleted,
        "governorate_id": governorateId?.toMap(),
        "city_id": cityId?.toMap(),
        "district_id": districtId?.toMap(),
        "token": token,
        "created_at": createdAt?.toIso8601String(),
      };

  factory UserAuthModel.fromJson(String str) =>
      UserAuthModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  String get address =>
      "${districtId?.value?.toCurrantLang ?? ""} - ${governorateId?.value?.toCurrantLang ?? ""} - ${cityId?.value?.toCurrantLang ?? ""}";
}
