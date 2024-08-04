// To parse this JSON data, do
//
//     final msgChatResModelItem = msgChatResModelItemFromJson(jsonString);

import 'dart:convert';

import 'package:aknan_user_app/features/authenticate/data/models/base_model.dart';
import 'package:aknan_user_app/features/authenticate/domain/use-cases/auth_cases.dart';
import 'package:aknan_user_app/injection_container.dart';

import '../../../../bases/base-models/base_id_value_model.dart';
import '../../../../bases/pagination/model/pagination_api_model.dart';
import '../../../authenticate/data/models/res-models/user_model.dart';
import '../../constants/chat_constant.dart';

MsgChatResModel msgChatResModelItemFromJson(String str) =>
    MsgChatResModel.fromJson(json.decode(str));

String msgChatResModelItemToJson(MsgChatResModel data) =>
    json.encode(data.toJson());

class MsgChatResModel extends BaseResModel<List<MsgChatResModelItem>> {
  @override
  List<MsgChatResModelItem> data;
  int unreadAdminMessagesCount;

  MsgChatResModel({
    required this.data,
    required this.unreadAdminMessagesCount,
    super.message,
    super.meta,
    super.status,
  });

  factory MsgChatResModel.fromJson(Map<String, dynamic> json) {
    if (json["data"] is! List) {
      json["data"] = [json["data"]];
    }
    return MsgChatResModel(
      data: List<MsgChatResModelItem>.from(
          json["data"].map((x) => MsgChatResModelItem.fromJson(x))),
      unreadAdminMessagesCount: json["unread_admin_messages_count"] ?? 0,
      message: json['message'] ?? "",
      meta: json["meta"] != null
          ? PaginationApiModel.fromJson(json["meta"])
          : null,
      status: json["status"],
    );
  }

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "unread_admin_messages_count": unreadAdminMessagesCount,
      };

  @override
  int get statusNumber => throw UnimplementedError();
}

class MsgChatResModelItem {
  String? id;
  dynamic chatType;
  User? user;
  Admin? admin;
  Maintenance? maintenance;
  dynamic lastMsg;
  String? msgType;
  dynamic readAt;
  String? senderType;
  DateTime? createdAt;
  List<MsgChatResModelItem>? messages;

  MsgChatResModelItem({
    this.id,
    this.chatType,
    this.user,
    this.admin,
    this.maintenance,
    this.lastMsg,
    this.msgType,
    this.readAt,
    this.senderType,
    this.createdAt,
    this.messages,
  });

  bool get isMe => senderType == ChatConstant.who;

  bool get canChat {
    return true;
    return maintenance?.status == "on_the_way";
  }

  factory MsgChatResModelItem.fromJson(Map<String, dynamic> json) {
    Admin? newAdmin =
        json["admin"] != null ? Admin.fromJson(json["admin"]) : null;
    Maintenance? newMaintenance = json["maintenance"] != null
        ? Maintenance.fromJson(json["maintenance"])
        : null;

    User? newUser = json["user"] != null ? User.fromJson(json["user"]) : null;

    return MsgChatResModelItem(
      id: json["id"],
      chatType: json["chat_type"],
      user: newUser,
      admin: newAdmin,
      maintenance: newMaintenance,
      lastMsg: json["last_msg"],
      msgType: json["msg_type"],
      readAt: json["read_at"],
      senderType: json["sender_type"],
      createdAt: DateTime.parse(json["created_at"]),
      messages: json["messages"] != null &&
              json.containsKey("messages") &&
              (json["messages"] as List).isNotEmpty
          ? List<MsgChatResModelItem>.from(
              json["messages"].map(
                (x) => MsgChatResModelItem.fromSingleMap(
                  x,
                  admin: newAdmin,
                  maintenance: newMaintenance,
                  user: newUser,
                ),
              ),
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "chat_type": chatType,
        "user": user?.toJson(),
        "admin": admin?.toJson(),
        "maintenance": maintenance?.toJson(),
        "last_msg": lastMsg,
        "msg_type": msgType,
        "read_at": readAt,
        "sender_type": senderType,
        "created_at": createdAt?.toIso8601String(),
      };

  factory MsgChatResModelItem.fromSingleMap(
    Map<String, dynamic> map, {
    Admin? admin,
    Maintenance? maintenance,
    User? user,
  }) {
/*
           "id": "944bef6c-af6a-4f0b-9595-a0031c0f6a87",
                "msg": "https://aknan-sa.net/AKNAN-Backend/public/storage/files/chat/download_(1).jpeg_aknan_1706084904_@2023.jpg",
                "msg_type": "image",
                "sender_type": "admin",
                "read_at": "2024-01-24 08:32:44",
                "created_at": "2024-01-24 08:28:24"

 */

    return MsgChatResModelItem(
      id: map["id"].toString(),
      lastMsg: map["msg"],
      msgType: map["msg_type"],
      senderType: map["sender_type"],
      readAt: map["read_at"],
      maintenance: maintenance,
      user: user,
      admin: admin,
      createdAt: DateTime.parse(map["created_at"]),
    );
  }

  MsgChatResModelItem copyWith({
    String? id,
    dynamic chatType,
    User? user,
    Admin? admin,
    Maintenance? maintenance,
    String? lastMsg,
    String? msgType,
    dynamic readAt,
    String? senderType,
    DateTime? createdAt,
    List<MsgChatResModelItem>? messages,
  }) {
    return MsgChatResModelItem(
      id: id ?? this.id,
      chatType: chatType ?? this.chatType,
      user: user ?? this.user,
      admin: admin ?? this.admin,
      maintenance: maintenance ?? this.maintenance,
      lastMsg: lastMsg ?? this.lastMsg,
      msgType: msgType ?? this.msgType,
      readAt: readAt ?? this.readAt,
      senderType: senderType ?? this.senderType,
      createdAt: createdAt ?? this.createdAt,
      messages: messages ?? this.messages,
    );
  }
}

class Admin {
  String id;
  String phone;
  String email;
  String img;
  String name;

  Admin({
    required this.id,
    required this.phone,
    required this.email,
    required this.img,
    required this.name,
  });

  factory Admin.fromJson(Map<String, dynamic> json) => Admin(
        id: json["id"],
        phone: json["phone"],
        email: json["email"],
        img: json["img"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "phone": phone,
        "email": email,
        "img": img,
        "name": name,
      };
}

class Maintenance {
  String id;
  bool useSpareParts;
  bool useExternalSpareParts;
  String status;
  DateTime dateTime;
  String paymentType;
  String damageNote;
  String serviceCostPrice;
  String externalBillsPrice;
  String sparePartsPrice;
  String fullPrice;
  Contract contract;
  Elevator elevator;
  User user;
  dynamic admin;
  dynamic technical;
  BaseIdNameTRModelString maintenanceType;

  Maintenance({
    required this.id,
    required this.useSpareParts,
    required this.useExternalSpareParts,
    required this.status,
    required this.dateTime,
    required this.paymentType,
    required this.damageNote,
    required this.serviceCostPrice,
    required this.externalBillsPrice,
    required this.sparePartsPrice,
    required this.fullPrice,
    required this.contract,
    required this.elevator,
    required this.user,
    required this.admin,
    required this.technical,
    required this.maintenanceType,
  });

  factory Maintenance.fromJson(Map<String, dynamic> json) => Maintenance(
        id: json["id"],
        useSpareParts: json["use_spare_parts"],
        useExternalSpareParts: json["use_external_spare_parts"],
        status: json["status"],
        dateTime: DateTime.parse(json["date_time"]),
        paymentType: json["payment_type"],
        damageNote: json["damage_note"],
        serviceCostPrice: json["service_cost_price"],
        externalBillsPrice: json["external_bills_price"],
        sparePartsPrice: json["spare_parts_price"],
        fullPrice: json["full_price"],
        contract: Contract.fromJson(json["contract"]),
        elevator: Elevator.fromJson(json["elevator"]),
        user: User.fromJson(json["user"]),
        admin: json["admin"],
        technical: json["technical"],
        maintenanceType:
            BaseIdNameTRModelString.fromMap(json["maintenance_type"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "use_spare_parts": useSpareParts,
        "use_external_spare_parts": useExternalSpareParts,
        "status": status,
        "date_time": dateTime.toIso8601String(),
        "payment_type": paymentType,
        "damage_note": damageNote,
        "service_cost_price": serviceCostPrice,
        "external_bills_price": externalBillsPrice,
        "spare_parts_price": sparePartsPrice,
        "full_price": fullPrice,
        "contract": contract.toJson(),
        "elevator": elevator.toJson(),
        "user": user.toJson(),
        "admin": admin,
        "technical": technical,
        "maintenance_type": maintenanceType.toMap(),
      };
}

class Contract {
  String id;
  MaintenanceType governorate;
  MaintenanceType city;
  MaintenanceType district;
  MaintenanceType branch;
  User user;
  String type;
  String street;
  String elevatorCode;
  bool status;

  Contract({
    required this.id,
    required this.governorate,
    required this.city,
    required this.district,
    required this.branch,
    required this.user,
    required this.type,
    required this.street,
    required this.elevatorCode,
    required this.status,
  });

  factory Contract.fromJson(Map<String, dynamic> json) => Contract(
        id: json["id"],
        governorate: MaintenanceType.fromJson(json["governorate"]),
        city: MaintenanceType.fromJson(json["city"]),
        district: MaintenanceType.fromJson(json["district"]),
        branch: MaintenanceType.fromJson(json["branch"]),
        user: User.fromJson(json["user"]),
        type: json["type"],
        street: json["street"],
        elevatorCode: json["elevator_code"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "governorate": governorate.toJson(),
        "city": city.toJson(),
        "district": district.toJson(),
        "branch": branch.toJson(),
        "user": user.toJson(),
        "type": type,
        "street": street,
        "elevator_code": elevatorCode,
        "status": status,
      };
}

class MaintenanceType {
  String id;
  String name;

  MaintenanceType({
    required this.id,
    required this.name,
  });

  factory MaintenanceType.fromJson(Map<String, dynamic> json) =>
      MaintenanceType(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class User {
  String id;
  String name;
  String username;
  String email;
  dynamic phoneCode;
  String phone;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    this.phoneCode,
    required this.phone,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
        phoneCode: json["phone_code"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "username": username,
        "email": email,
        "phone_code": phoneCode,
        "phone": phone,
      };

  static Future<User> fromLUserAuthModel() async {
    UserAuthModel? userAuthModel = await sl<AuthCases>().getUserData();
    return User(
      id: userAuthModel!.id!,
      name: userAuthModel.name!,
      username: userAuthModel.username!,
      email: userAuthModel.email!,
      // phoneCode: userAuthModel.phoneCode,
      phone: userAuthModel.phone!,
    );
  }
}

class Elevator {
  String id;
  String name;
  int price;
  List<dynamic> imgs;
  DateTime createdAt;

  Elevator({
    required this.id,
    required this.name,
    required this.price,
    required this.imgs,
    required this.createdAt,
  });

  factory Elevator.fromJson(Map<String, dynamic> json) => Elevator(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        imgs: List<dynamic>.from(json["imgs"].map((x) => x)),
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "imgs": List<dynamic>.from(imgs.map((x) => x)),
        "created_at": createdAt.toIso8601String(),
      };
}
