

import '../../../../bases/pagination/model/pagination_api_model.dart';

abstract class BaseResModel<T> {
  String? message;
  int? status;

PaginationApiModel?  meta;
  
  BaseResModel({
    this.message,
    this.status,
    this.meta,
  });
  T? get data;
  int get statusNumber;

  
}

class MsgModel extends BaseResModel<MsgModel> {


  Map<String,dynamic>? stateData;
  MsgModel({

    this.stateData,
  });

 

  MsgModel.fromKMap(Map<String, dynamic> map) {
    message = map['message'];
    status = map['status']?.toInt();
    stateData = map['data'];
  }

  // String toJson() => json.encode(toMap());

  factory MsgModel.fromJson(Map<String, dynamic> map) => MsgModel.fromKMap(map);

  bool get isSuccess => status == 200;
  @override
  MsgModel? get data => this;

  @override
  int get statusNumber => status!;

  @override
  String toString() {
    
    return "MSG( msg $message  status $status)";
  }

  // MsgModel copyWith({
  //   String? massage,
  //   int? status,
  //   Map<String,dynamic>? stateData,
  // }) {
  //   return MsgModel(
  //     massage: massage ?? this.massage,
  //     status: status ?? this.status,
  //     stateData: stateData ?? this.stateData,
  //   );
  // }
}
