import '../../../bases/pagination/model/pagination_api_model.dart';

import '../../../bases/base-models/base_id_value_model.dart';
import '../../authenticate/data/models/base_model.dart';

class UserElevatorsList extends BaseResModel<List<ElevatorModelInList>> {
  List<ElevatorModelInList>? _data;

  UserElevatorsList(
    this._data, {
    super.message,
    super.status,
    super.meta,
  });

  @override
  int get statusNumber => status!;

  factory UserElevatorsList.fromJson(Map<String, dynamic> map) {
    return UserElevatorsList(
      map['data'] != null
          ? List<ElevatorModelInList>.from(
              map['data']?.map(
                (x) => ElevatorModelInList.fromMap(x),
              ),
            )
          : null,
      message: map['message'],
      status: map['status'],
      meta:
          map['meta'] != null ? PaginationApiModel.fromJson(map['meta']) : null,
    );
  }
  @override
  List<ElevatorModelInList>? get data => _data;
}

class ElevatorModelInList {
  String? id;
  String? elevatorFullName;
  String? elevatorName;
  DateTime? startDate;
  DateTime? endDate;
  String? elevatorCode;
  int? remainingMaintenance;
  int? periodicMaintenances;
  int? complaintMaintenances;
  int? emergencyMaintenances;
  String? contractType;

  ElevatorModelInList({
    this.id,
    this.elevatorFullName,
    this.elevatorName,
    this.startDate,
    this.endDate,
    this.elevatorCode,
    this.remainingMaintenance,
    this.periodicMaintenances,
    this.complaintMaintenances,
    this.emergencyMaintenances,
    this.contractType,
  });

  factory ElevatorModelInList.fromMap(Map<String, dynamic> json) =>
      ElevatorModelInList(
        id: json["id"],
        contractType: json["contract_type"],
        elevatorFullName: json["elevator_full_name"],
        elevatorName: json["elevator_name"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        elevatorCode: json["elevator_code"],
        remainingMaintenance: json["remaining_maintenance"],
        periodicMaintenances: json["periodic_maintenances"],
        complaintMaintenances: json["complaint_maintenances"],
        emergencyMaintenances: json["emergency_maintenances"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "elevator_full_name": elevatorFullName,
        "elevator_name": elevatorName,
        "start_date":
            "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        "elevator_code": elevatorCode,
        "remaining_maintenance": remainingMaintenance,
        "periodic_maintenances": periodicMaintenances,
        "complaint_maintenances": complaintMaintenances,
        "emergency_maintenances": emergencyMaintenances,
      };

  BaseIdNameModelString toBaseIdNameModelString() {
    print('elevatorCode??"" ${elevatorCode ?? ""}');

    return BaseIdNameModelString(id, elevatorFullName,
        data: elevatorCode ?? "");
  }
}
