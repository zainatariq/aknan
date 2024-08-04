import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../features/authenticate/data/models/base_model.dart';

import '../pagination/model/pagination_api_model.dart';

class ElevatorsModel extends BaseResModel<List<ElevatorModel>> {
  final List<ElevatorModel>? _data;

  ElevatorsModel(
    this._data, {
    super.status,
    super.message,
    super.meta,
  });
  @override
  // TODO: implement data
  List<ElevatorModel>? get data => _data;

  @override
  // TODO: implement statusNumber
  int get statusNumber => throw UnimplementedError();

  factory ElevatorsModel.fromMap(Map<String, dynamic> map) {
    return ElevatorsModel(
      map['data'] != null
          ? List<ElevatorModel>.from(
              map['data'].map((x) => ElevatorModel.fromAPiMap(x)))
          : null,
      status: map['status'],
      meta:
          map['meta'] != null ? PaginationApiModel.fromJson(map['meta']) : null,
      message: map['message'],
    );
  }

  // String toJson() => json.encode(toMap());

  factory ElevatorsModel.fromJson(String source) =>
      ElevatorsModel.fromMap(json.decode(source));
}

class ElevatorModel {
  String? id;
  String? name;
  String? dic;
  List<String>? images;
  num? price;
  ElevatorModel({
    this.id,
    this.name,
    this.dic,
    this.images,
    this.price,
  });

  String get img =>
      "https://dfstudio-d420.kxcdn.com/wordpress/wp-content/uploads/2019/06/digital_camera_photo-980x653.jpg";
  factory ElevatorModel.dummy() {
    return ElevatorModel(
      id: "id",
      name: "name",
      dic: "dic",
      price: 0,
      images: [
        "https://dfstudio-d420.kxcdn.com/wordpress/wp-content/uploads/2019/06/digital_camera_photo-980x653.jpg",
        "https://dfstudio-d420.kxcdn.com/wordpress/wp-content/uploads/2019/06/digital_camera_photo-980x653.jpg",
        "https://dfstudio-d420.kxcdn.com/wordpress/wp-content/uploads/2019/06/digital_camera_photo-980x653.jpg",
        "https://dfstudio-d420.kxcdn.com/wordpress/wp-content/uploads/2019/06/digital_camera_photo-980x653.jpg",
      ],
    );
  }

  String get viewImg => images!.first;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'dic': dic,
      'imgs': images,
      'price': price,
    };
  }

  factory ElevatorModel.fromMap(Map<String, dynamic> map) {
    return ElevatorModel(
      id: map['id'],
      name: map['name'],
      dic: map['dic'],
      images: List<String>.from(map['imgs']),
      price: map['price'],
    );
  }
  factory ElevatorModel.fromAPiMap(Map<String, dynamic> map) {
    return ElevatorModel(
      id: map['id'],
      name: map['name'],
      dic: map['desc'],
      images: map.containsKey("imgs") && (map['imgs'] as List).isNotEmpty
          ? List<String>.from(
              (map['imgs'] as Iterable<dynamic>).map((e) => e["url"])).toList()
          : [],
      price: map['price'],
    );
  }
  factory ElevatorModel.fromSingleMap(Map<String, dynamic> map) {
    return ElevatorModel(
      id: map['id'],
      name: map['name'],
      // dic: map['dic'],
      images: [map['img']],
      // price: map['price'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ElevatorModel.fromJson(String source) =>
      ElevatorModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ElevatorModel(id: $id, name: $name, dic: $dic, images: $images, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ElevatorModel &&
        other.id == id &&
        other.name == name &&
        other.dic == dic &&
        listEquals(other.images, images) &&
        other.price == price;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        dic.hashCode ^
        images.hashCode ^
        price.hashCode;
  }

  ElevatorModel copyWith({
    String? id,
    String? name,
    String? dic,
    List<String>? images,
    num? price,
  }) {
    return ElevatorModel(
      id: id ?? this.id,
      name: name ?? this.name,
      dic: dic ?? this.dic,
      images: images ?? this.images,
      price: price ?? this.price,
    );
  }
}
