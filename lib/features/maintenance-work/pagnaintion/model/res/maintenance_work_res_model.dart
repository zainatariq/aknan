import '../../../../../bases/pagination/model/pagination_api_model.dart';
import '../../../../authenticate/data/models/base_model.dart';

// maintenance_work_res_model
class MaintenanceWorkResModel
    extends BaseResModel<List<MaintenanceWorkResData>> {
  @override
  List<MaintenanceWorkResData>? data;

  MaintenanceWorkResModel({
    this.data,
    super.meta,
    super.status,
    super.message,
  });

  factory MaintenanceWorkResModel.fromMap(Map<String, dynamic> json) =>
      MaintenanceWorkResModel(
        data: json["data"] == null
            ? []
            : List<MaintenanceWorkResData>.from(
                json["data"]!.map((x) => MaintenanceWorkResData.fromJson(x))),
        meta: json["meta"] == null
            ? null
            : PaginationApiModel.fromJson(json["meta"]),
        status: json["status"],
        message: json["message"],
      );

  @override
  int get statusNumber => throw UnimplementedError();
}

class MaintenanceWorkResData {
  String? id;
  DateTime? dateTime;
  String? name;
  String? cost;
  String? damageNote;
  List<ExternalBill>? externalBills;

  MaintenanceWorkResData({
    this.id,
    this.dateTime,
    this.name,
    this.cost,
    this.damageNote,
    this.externalBills,
  });

  factory MaintenanceWorkResData.fromJson(Map<String, dynamic> json) =>
      MaintenanceWorkResData(
        id: json["id"],
        dateTime: json["date_time"] == null
            ? null
            : DateTime.parse(json["date_time"]),
        name: json["name"],
        cost: json["cost"],
        damageNote: json["damage_note"],
        externalBills: json["external_bills"] == null
            ? []
            : List<ExternalBill>.from(
                json["external_bills"]!.map((x) => ExternalBill.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date_time": dateTime?.toIso8601String(),
        "name": name,
        "cost": cost,
        "damage_note": damageNote,
        "external_bills": externalBills == null
            ? []
            : List<dynamic>.from(externalBills!.map((x) => x.toJson())),
      };
}

class ExternalBill {
  int? id;
  String? img;

  ExternalBill({
    this.id,
    this.img,
  });

  factory ExternalBill.fromJson(Map<String, dynamic> json) => ExternalBill(
        id: json["id"],
        img: json["img"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "img": img,
      };
}

class Links {
  String? first;
  String? last;
  dynamic prev;
  dynamic next;

  Links({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        first: json["first"],
        last: json["last"],
        prev: json["prev"],
        next: json["next"],
      );

  Map<String, dynamic> toJson() => {
        "first": first,
        "last": last,
        "prev": prev,
        "next": next,
      };
}

// class Meta {
//   int? currentPage;
//   int? from;
//   int? lastPage;
//   List<Link>? links;
//   String? path;
//   int? perPage;
//   int? to;
//   int? total;
//
//   Meta({
//     this.currentPage,
//     this.from,
//     this.lastPage,
//     this.links,
//     this.path,
//     this.perPage,
//     this.to,
//     this.total,
//   });
//
//   factory Meta.fromJson(Map<String, dynamic> json) => Meta(
//         currentPage: json["current_page"],
//         from: json["from"],
//         lastPage: json["last_page"],
//         links: json["links"] == null
//             ? []
//             : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
//         path: json["path"],
//         perPage: json["per_page"],
//         to: json["to"],
//         total: json["total"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "current_page": currentPage,
//         "from": from,
//         "last_page": lastPage,
//         "links": links == null
//             ? []
//             : List<dynamic>.from(links!.map((x) => x.toJson())),
//         "path": path,
//         "per_page": perPage,
//         "to": to,
//         "total": total,
//       };
// }

class Link {
  String? url;
  String? label;
  bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}
