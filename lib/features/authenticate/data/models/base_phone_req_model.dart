import 'dart:convert';

class BasePhoneReqModel {
  BasePhoneReqModel({
    required this.phone,
    this.phoneCode = '+966',
  }) {
    phone = phone.replaceFirst(phoneCode, "");
  }

  String phone;
  String phoneCode;

  Map<String, dynamic> toJson() {
    return {
      // "phone_code": phoneCode,
      "phone": phone,
    };
  }

  factory BasePhoneReqModel.froMap(Map<String, dynamic> map) {
    return BasePhoneReqModel(
      phone: map['phone'],
      phoneCode: map.containsKey('phone_code') ? map['phone_code'] : '+966',
     );
  }

  String toL() => jsonEncode(toJson());

  factory BasePhoneReqModel.fromL(String str) =>
      BasePhoneReqModel.froMap(jsonDecode(str));

  @override
  String toString() {
    return " phone: $phone, phoneCode: $phoneCode";
  }
}
