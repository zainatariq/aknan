import 'dart:convert';

import '../../../../../bases/base-models/base_id_value_model.dart';
import '../../../../authenticate/data/models/base_model.dart';

import '../../../../../bases/base-models/elevator_model.dart';
import '../../../../../bases/base-models/maintenance_request_model.dart';
import '../../../../../main.dart';

class Banners {
  final String id;
  final String img;
  final String? link;
  Banners({
    required this.id,
    required this.img,
    this.link,
  });

  bool get isHaveLink => link != null;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'img': img,
      'link': link,
    };
  }

  factory Banners.fromMap(Map<String, dynamic> map) {
  
    
    return Banners(
      id: map['id'] ?? '',
      img: map['img'] ?? '',
      link: map['link'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Banners.fromJson(String source) =>
      Banners.fromMap(json.decode(source));
}

class HomeRes extends BaseResModel<HomeData> {
  HomeData _data;
  HomeRes(
    this._data, {
    super.message,
    super.status,
  });

  @override
  HomeData? get data => _data;

  @override
  int get statusNumber => throw UnimplementedError();

  Map<String, dynamic> toMap() {
    return {
      '_data': _data.toMap(),
    };
  }

  factory HomeRes.fromMap(Map<String, dynamic> map) {
    return HomeRes(
      HomeData.fromMap(map['data']),
      message: map["message"],
      status: map["status"],
    );
  }

  String toJson() => json.encode(toMap());

  factory HomeRes.fromJson(String source) =>
      HomeRes.fromMap(json.decode(source));
}

class HomeData {
  List<Banners> sliders;
  List<BaseIdNameModelString> maintainances;
  List<ElevatorModel> elevatorTypes;
  String notificationCount;
  HomeData({
    required this.sliders,
    required this.maintainances,
    required this.elevatorTypes,
    required this.notificationCount,
  });

  Map<String, dynamic> toMap() {
    return {
      'sliders': sliders.map((x) => x.toMap()).toList(),
      'maintainances': maintainances.map((x) => x.toMap()).toList(),
      'elevatorTypes': elevatorTypes.map((x) => x.toMap()).toList(),
    };
  }

  factory HomeData.fromMap(Map<String, dynamic> map) {
    return HomeData(
      notificationCount: map['notification_count']?.toString() ?? "0",
      sliders:
          List<Banners>.from(map['slider']?.map((x) => Banners.fromMap(x))).toList(),
      maintainances: List<BaseIdNameModelString>.from(
          map['maintainances']?.map((x) => BaseIdNameModelString.fromMap(x))).toList(),
      elevatorTypes: List<ElevatorModel>.from(map['elevator_types']
          ?.map((x) => ElevatorModel.fromSingleMap(x))).toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory HomeData.fromJson(String source) =>
      HomeData.fromMap(json.decode(source));

  List<MaintenanceRequestModel> get reqs {
    return maintainances
        .map((e) => MaintenanceRequestModel(id: e.id, name: e.value))
        .toList();
  }


  }

