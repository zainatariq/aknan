import 'dart:convert';

import '../../localization/change_language.dart';
import 'package:one_context/one_context.dart';

abstract class BaseIdValueModel<T, N> {
  String? id;
  T? value;
  N? data;
  BaseIdValueModel(this.id, this.value, {this.data});
}

class BaseIdNameModelString extends BaseIdValueModel<String, dynamic> {
  BaseIdNameModelString(
    super.id,
    super.value,
    {
super.data,
    }
  );






  factory BaseIdNameModelString.fromMap(Map<String, dynamic> map) {
    return BaseIdNameModelString(
      map['id'].toString(),
      map['name'].toString(),
    );
  }
  factory BaseIdNameModelString.fromMapTr(Map<String, dynamic> map) {
    String langKey = TLang.getCurrentLocale(OneContext().context!).name;

    return BaseIdNameModelString(
      map['id'].toString(),
      map['name'][langKey].toString(),
    );
  }
  factory BaseIdNameModelString.fromMap2(Map<String, dynamic> map) {
    return BaseIdNameModelString(
      map['id'].toString(),
      map['title'].toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": value,
      "data":data
    };
  }

  Map<String, dynamic> toMap2() {
    return {
      "id": id,
      "title": value,
    };
  }

  @override
  String toString() => toMap().toString();
  String toString2() => toMap2().toString();
  factory BaseIdNameModelString.defaultItem() {
    return BaseIdNameModelString(
      "null",
      "1",
    );
  }

  factory BaseIdNameModelString.defaultItemFrom(int index) {
    return BaseIdNameModelString(
      "null",
      "$index",
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BaseIdNameModelString &&
        other.id == id &&
        other.value == value;
  }

  @override
  int get hashCode => id.hashCode ^ value.hashCode;
}

class BaseIdNameTRModelString extends BaseIdValueModel<TR, Null> {
  BaseIdNameTRModelString(
    super.id,
    super.value,
  );

  factory BaseIdNameTRModelString.fromMap(Map<String, dynamic> map) {
    return BaseIdNameTRModelString(
      map['id'].toString(),
      TR.fromMap(map['name']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": value?.toMap(),
    };
  }

  @override
  String toString() => toMap().toString();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BaseIdNameTRModelString &&
        other.id == id &&
        other.value == value;
  }

  @override
  int get hashCode => id.hashCode ^ value.hashCode;
}

class BaseIdNameImgModelString extends BaseIdValueModel<String, String> {
  String? thirdKey;

  BaseIdNameImgModelString(super.id, super.value, {super.data});
  factory BaseIdNameImgModelString.fromImgMap(
    Map<String, dynamic> map,
  ) {
    return BaseIdNameImgModelString(
      map['id'].toString(),
      map['name'].toString(),
      data: map["img"].toString(),
    )..thirdKey = "img";
  }

  factory BaseIdNameImgModelString.fromMalfunctionsList(
    Map<String, dynamic> map,
  ) {
    return BaseIdNameImgModelString(
      map['id'].toString(),
      map['title'].toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": value,
      if (thirdKey != null) ...{thirdKey!: data}
    };
  }

  factory BaseIdNameImgModelString.defaultItem() {
    return BaseIdNameImgModelString(
      "null",
      "1",
    );
  }

  factory BaseIdNameImgModelString.defaultItemFrom(int index) {
    return BaseIdNameImgModelString(
      "null",
      "$index",
    );
  }

  @override
  String toString() => value ?? '';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BaseIdNameImgModelString &&
        other.id == id &&
        other.value == value;
  }

  @override
  int get hashCode => id.hashCode ^ value.hashCode;
}

class TR {
  String ar;
  String en;
  String ur;
  TR({
    required this.ar,
    required this.en,
    required this.ur,
  });

  Map<String, dynamic> toMap() {
    return {
      'ar': ar,
      'en': en,
      'ur': ur,
    };
  }

  factory TR.fromMap(Map<String, dynamic> map) {
    return TR(
      ar: map['ar'] ?? '',
      en: map['en'] ?? '',
      ur: map['ur'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TR.fromJson(String source) => TR.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TR && other.ar == ar && other.en == en && other.ur == ur;
  }

  @override
  int get hashCode => ar.hashCode ^ en.hashCode ^ ur.hashCode;

  String get toCurrantLang {
    String lang = TLang.getCurrentLocale(OneContext().context!).name;
    return toMap()[lang];
  }
}
