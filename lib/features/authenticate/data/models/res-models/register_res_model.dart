import 'dart:convert';

import '../base_model.dart';
import 'user_model.dart';

abstract class RegisterResModel {}

class AKnanAuthorizedResModel extends BaseResModel<AKnanAuthorizedResModel>
    implements RegisterResModel {
  UserAuthModel? user;

  AKnanAuthorizedResModel(
    this.user, {
    super.message,
    super.status,
  });

  factory AKnanAuthorizedResModel.fromJson(Map<String, dynamic> json) {
    return AKnanAuthorizedResModel(
      json["data"] != null ? UserAuthModel.fromMap(json["data"]) : null,
      message: json["message"],
      status: json['status'],
    );
  }

  Map<String, dynamic> toMap() => {"data": user?.toMap()};

  String toJson() => json.encode(toMap());

  @override
  AKnanAuthorizedResModel? get data => this;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AKnanAuthorizedResModel && other.user == user;
  }

  @override
  int get hashCode => user.hashCode;

  @override
  String toString() => 'HOODAuthorizedResModel(user: $user)';

  bool get isSuccess => user != null && status == 200;

  @override
  int get statusNumber => status!;
}
