import 'dart:convert';
import 'dart:developer';

import '../../localization/change_language.dart';
import 'package:one_context/one_context.dart';

import '../../global/app-assets/assets.dart';

enum MaintenanceRequestType { periodic, complaint, emergency, none }

extension localImg on MaintenanceRequestType {
  String get getImg {
    if (this == MaintenanceRequestType.complaint) {
      return Assets.imagesSvgsComplaintReq;
    } else if (this == MaintenanceRequestType.periodic) {
      return Assets.imagesSvgsPeriodicReq;
    } else if (this == MaintenanceRequestType.emergency) {
      return Assets.imagesSvgsEmergencyReq;
    } else {
      return "";
    }
  }
}

class MaintenanceRequestModel {
  String? id;
  String? name;
  String? get iconLocalPath => type?.getImg;
  MaintenanceRequestType? get type => _getTypeFromName(name);
  String? img;
  MaintenanceRequestModel({
    this.id,
    this.name,
    this.img,
  }) {
    type;
  }

  bool isEnglish(String input) {
    RegExp englishRegExp = RegExp(r'^[a-zA-Z\s]*$');
    return englishRegExp.hasMatch(input);
  }

  MaintenanceRequestType? _getTypeFromName(name) {
    var type = MaintenanceRequestType.values.firstWhere((element) {

      return (!isEnglish(name)
              ? element.name.tre.toLowerCase()
              : element.name.toLowerCase()) ==
          name.toString().toLowerCase();
    }, orElse: () => MaintenanceRequestType.none);
    if (type == MaintenanceRequestType.none) {
      return null;
    } else {
      return type;
    }
  }

  @override
  String toString() {
    return 'MaintenanceRequestModel(id: $id, name: $name, iconLocalPath: $iconLocalPath, type: $type)';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory MaintenanceRequestModel.fromMap(Map<String, dynamic> map) {
    return MaintenanceRequestModel(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MaintenanceRequestModel.fromJson(String source) =>
      MaintenanceRequestModel.fromMap(json.decode(source));
}
