// To parse this JSON data, do
//
//     final postMaintenanceReqModel = postMaintenanceReqModelFromJson(jsonString);

import 'package:aknan_user_app/date_converter.dart';

class PostMaintenanceReqModel {
  String? editId;
  String? maintenanceTypeId;
  String? contractId;
  String? elevatorCode;
  List<String>? malfunctions;

  DateTime? dateTime;
  String? damageNote;

  PostMaintenanceReqModel({
    required this.maintenanceTypeId,
    required this.contractId,
    required this.malfunctions,
    required this.dateTime,
    required this.damageNote,
    this.editId,
    this.elevatorCode,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};

    data["maintenance_type_id"] = maintenanceTypeId;
    data["contract_id"] = contractId;

    for (var i = 0; i < malfunctions!.length; i++) {
      data["malfunctions[$i]"] = malfunctions![i];
    }

    data["date_time"] = dateTime?.toIso8601String();
    data["damage_note"] = damageNote;
    data["edit_id"] = editId;
    data['elevator_code'] = elevatorCode;

    return data;
  }

  Map<String, dynamic> toApiMap() {
    Map<String, dynamic> data = {};

    for (var i = 0; i < malfunctions!.length; i++) {
      data["malfunctions[$i]"] = malfunctions![i].toString();
      // data["malfunctions[$i]"] = "0";
    }
    data["maintenance_type_id"] = maintenanceTypeId;
    data["contract_id"] = contractId;

    data["date_time"] = DateConverter.dateTimeToSendApi(dateTime!);
    data["damage_note"] = damageNote;

    return data;
  }

  factory PostMaintenanceReqModel.fromJson(Map<String, dynamic> json) =>
      PostMaintenanceReqModel(
        maintenanceTypeId: json["maintenance_type_id"],
        contractId: json["contract_id"],
        malfunctions: _getListFromString(json),
        dateTime: DateTime.parse(json["date_time"]),
        damageNote: json["damage_note"],
        editId: json["edit_id"],
        elevatorCode: json["elevator_code"],
      );

  static List<String> _getListFromString(Map<String, dynamic> json) {
    int index = 0;
    List<String> list = [];

    while (json.containsKey("malfunctions[$index]")) {
      var item = json["malfunctions[$index]"];
      list.add(item);
      index++;
      continue;
    }

    print('list ::: $list');

    return list;
  }

  PostMaintenanceReqModel copyWith({
    String? editId,
    String? maintenanceTypeId,
    String? contractId,
    List<String>? malfunctions,
    DateTime? dateTime,
    String? damageNote,
  }) {
    return PostMaintenanceReqModel(
      editId: editId ?? this.editId,
      maintenanceTypeId: maintenanceTypeId ?? this.maintenanceTypeId,
      contractId: contractId ?? this.contractId,
      malfunctions: malfunctions ?? this.malfunctions,
      dateTime: dateTime ?? this.dateTime,
      damageNote: damageNote ?? this.damageNote,
    );
  }
}
