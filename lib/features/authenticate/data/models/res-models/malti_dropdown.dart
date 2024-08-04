import '../../../../../bases/base-models/base_id_value_model.dart';
import '../base_model.dart';

// malti_dropdown
class MaltiDropdown extends BaseResModel<List<BaseIdNameModelString>> {
  List<BaseIdNameModelString>? _data;
  MaltiDropdown(
    this._data, {
    super.message,
    super.status,
  });

  @override
  List<BaseIdNameModelString>? get data => _data;

  @override
  int get statusNumber =>status!;

  factory MaltiDropdown.fromJson(Map<String, dynamic> map) {
    return MaltiDropdown(
      map['data'] != null ? List<BaseIdNameModelString>.from(map['data']?.map((x) => BaseIdNameModelString.fromMap(x))) : null,
      message: map['message'],
      status: map['status'],
    );
  }
  factory MaltiDropdown.fromJsonTr(Map<String, dynamic> map) {
    return MaltiDropdown(
      map['data'] != null ? List<BaseIdNameModelString>.from(map['data']?.map((x) => BaseIdNameModelString.fromMapTr(x))) : null,
      message: map['message'],
      status: map['status'],
    );
  }
  factory MaltiDropdown.fromJson2(Map<String, dynamic> map) {
    return MaltiDropdown(
      map['data'] != null ? List<BaseIdNameModelString>.from(map['data']?.map((x) => BaseIdNameModelString.fromMap2(x))) : null,
      message: map['message'],
      status: map['status'],
    );
  }


}
