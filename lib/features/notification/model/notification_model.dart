import 'dart:convert';

import '../../../date_converter.dart';
import 'package:intl/intl.dart';

import '../../../bases/pagination/model/pagination_api_model.dart';
import '../../authenticate/data/models/base_model.dart';

class NotificationsModel extends BaseResModel<List<NotificationModel>> {
  final List<NotificationModel>? _data;

  NotificationsModel(
    this._data, {
    super.status,
    super.message,
    super.meta,
  });
  @override
  List<NotificationModel>? get data => _data;

  @override
  int get statusNumber => throw UnimplementedError();

  factory NotificationsModel.fromMap(Map<String, dynamic> map) {
    return NotificationsModel(
      map['data'] != null
          ? List<NotificationModel>.from(
              map['data'].map((x) => NotificationModel.fromMap(x)))
          : null,
      status: map['status'],
      meta:
          map['meta'] != null ?
          PaginationApiModel.fromJson(map['meta']) : null,
      message: map['message'],
    );
  }
}

class NotificationModel {
  final String? id;
  // final Data data;
  final String? img;
  final String? title;
  final String? body;
  final dynamic data;
  final DateTime? readAt;
  final DateTime? createdAt;

  NotificationModel({
    this.id,
    this.title,
    this.body,
    this.data,
    this.readAt,
    this.createdAt,
    this.img,
  });

  String? get maintenanceIdOnChat {
    if (data['notify_type'] != "chat") {
      return null;
    } else {
      return data['maintenance_id'];
    }
  }

  DateTime _parseDateTime(String dateTimeStr) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd hh:mm a");
    return dateFormat.parse(dateTimeStr);
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      img: map['image'],
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      body: map['body'] ?? '',
      data: map['data'],
      readAt: (String dateTimeStr) {
        DateFormat dateFormat = DateFormat("yyyy-MM-dd hh:mm a", "en");
        return dateFormat.parse(dateTimeStr);
      }(map['read_at'].toString()),
      createdAt: (String dateTimeStr) {
        DateFormat dateFormat = DateFormat("yyyy-MM-dd hh:mm a", "en");
        return dateFormat.parse(dateTimeStr);
      }(map['created_at'].toString()),
    );
  }

  factory NotificationModel.fromJson(String source) =>
      NotificationModel.fromMap(json.decode(source));

  // String get time => "10:55";
  // String get date => "5/10/2023";
  // String get text => "Order number #50445632001 will arrive you tomorrow.";

  String get time => DateConverter.convertDateTimeToHM(createdAt!);
  String get date => DateConverter.convertDateTimeToStringDate(createdAt!);
  String get text => body!;
}
