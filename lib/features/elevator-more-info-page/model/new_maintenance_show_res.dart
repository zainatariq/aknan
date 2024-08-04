import '../../authenticate/data/models/base_model.dart';

import '../../add-maintenance-request/model/req/post_maintenance_req_model.dart';

// new_maintenance_show_res
class NewMaintenanceShowRes extends BaseResModel<Data> {
  @override
  Data? data;

  NewMaintenanceShowRes({
    this.data,
    super.status,
    super.message,
  });

  factory NewMaintenanceShowRes.fromJson(Map<String, dynamic> json) =>
      NewMaintenanceShowRes(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };

  @override
  int get statusNumber => throw UnimplementedError();
}

class Data {
  String? id;
  DateTime? dateTime;
  String? damageNote;
  String? elevator;
  MaintenanceType? maintenanceType;
  List<Malfunction>? malfunctions;

  Data({
    this.id,
    this.dateTime,
    this.damageNote,
    this.elevator,
    this.maintenanceType,
    this.malfunctions,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        dateTime: json["date_time"] == null
            ? null
            : DateTime.parse(json["date_time"]),
        damageNote: json["damage_note"],
        elevator: json["elevator"],
        maintenanceType: json["maintenance_type"] == null
            ? null
            : MaintenanceType.fromJson(json["maintenance_type"]),
        malfunctions: json["malfunctions"] == null ||
                (json["malfunctions"] as List).isEmpty
            ? []
            : List<Malfunction>.from(
                json["malfunctions"]!.map((x) => Malfunction.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date_time": dateTime?.toIso8601String(),
        "damage_note": damageNote,
        "elevator": elevator,
        "maintenance_type": maintenanceType?.toJson(),
        "malfunctions": malfunctions == null
            ? []
            : List<dynamic>.from(malfunctions!.map((x) => x.toJson())),
      };

  PostMaintenanceReqModel toEditModel(String elevatorId,String elevatorCode ) {
    return PostMaintenanceReqModel(
      editId: id,
      maintenanceTypeId: maintenanceType?.id,
      contractId: elevatorId,
      elevatorCode: elevatorCode,
      malfunctions: malfunctions?.map((e) => e.id!).toList(),
      dateTime: dateTime,
      damageNote: damageNote,
    );
  }
}

class MaintenanceType {
  String? id;
  String? name;

  MaintenanceType({
    this.id,
    this.name,
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

class Malfunction {
  String? id;
  String? title;

  Malfunction({
    this.id,
    this.title,
  });

  factory Malfunction.fromJson(Map<String, dynamic> json) => Malfunction(
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
      };
}
