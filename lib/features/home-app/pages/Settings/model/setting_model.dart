

import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../../authenticate/data/models/base_model.dart';

class SettingModel {
  String? title;
  String? localSvgPath;
  Function(BuildContext context) ? functionCallback;
  SettingModel({
    this.title,
    this.localSvgPath,
    this.functionCallback,
  });

}


class AboutUsRes extends BaseResModel<AboutUsData> {
AboutUsData? _data;

AboutUsRes(
  this._data,
  
  {

super.message,
super.status,
  }
);



  @override
  AboutUsData? get data => _data;

  @override
  int get statusNumber => throw UnimplementedError();




  Map<String, dynamic> toMap() {
    return {
      '_data': _data?.toMap(),
    };
  }

  factory AboutUsRes.fromMap(Map<String, dynamic> map) {
    return AboutUsRes(
      map['data'] != null ? AboutUsData.fromMap(map['data']) : null,
      message: map['message'],
      status: map['status'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AboutUsRes.fromJson(String source) => AboutUsRes.fromMap(json.decode(source));
}

class AboutUsData {
    About? about;
    About? policy;
    String? phone;
    String? whatsapp;
    String? email;

    AboutUsData({
        this.about,
        this.policy,
        this.phone,
        this.whatsapp,
        this.email,
    });


  Map<String, dynamic> toMap() {
    return {
      'about': about?.toMap(),
      'policy': policy?.toMap(),
      'phone': phone,
      'whatsapp': whatsapp,
      'email': email,
    };
  }

  factory AboutUsData.fromMap(Map<String, dynamic> map) {
    return AboutUsData(
      about: map['about'] != null ? About.fromMap(map['about']) : null,
      policy: map['policy'] != null ? About.fromMap(map['policy']) : null,
      phone: map['phone'],
      whatsapp: map['whatsapp'],
      email: map['email'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AboutUsData.fromJson(String source) => AboutUsData.fromMap(json.decode(source));
}

class About {
    String? title;
    String? description;

    About({
        this.title,
        this.description,
    });


  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
    };
  }

  factory About.fromMap(Map<String, dynamic> map) {
    return About(
      title: map['title'],
      description: map['description'],
    );
  }

  String toJson() => json.encode(toMap());

  factory About.fromJson(String source) => About.fromMap(json.decode(source));
}

