import '../../../../../bases/pagination/model/main_paginate_request_entity_model.dart';

class GetMaintenanceWorkReqModel extends MainPaginateRequestEntityModel {
  GetMaintenanceWorkReqModel(
    super.page,
    {
  required  this.id,
    }
  );

  String id;




  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = super.toMap();
    data['id'] = this.id;
    return data;
  }
}
