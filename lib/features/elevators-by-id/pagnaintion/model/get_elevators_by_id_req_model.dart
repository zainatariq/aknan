import '../../../../bases/pagination/model/main_paginate_request_entity_model.dart';

// get_elevators_by_id_req_model
class GetElevatorsByIdReqModel extends MainPaginateRequestEntityModel {
  String id;

  GetElevatorsByIdReqModel(
    super.page,
    this.id,
  );

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'elevator_type_id': id,
    };
    map.addAll(super.toMap());
    return map;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is GetElevatorsByIdReqModel &&
      other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
