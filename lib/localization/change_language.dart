// ignore_for_file: unused_element

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
enum Lang { ar, en }

class TLang {
  static ar(BuildContext context) async {
    context.setLocale(Locale(Lang.ar.name));
    await Jiffy.setLocale(Lang.ar.name);
  }
  static en(BuildContext context) async {
    context.setLocale(Locale(Lang.en.name));
    await Jiffy.setLocale(Lang.en.name);
  }

  static isEnglish(BuildContext context) =>
      getCurrentLocale(context) == Lang.en;

  static Lang getDeviceLocal(BuildContext context) {
    return context.locale.languageCode == Lang.ar.name ? Lang.ar : Lang.en;
  }

  static Lang getCurrentLocale(BuildContext context) {
    return context.locale.languageCode == Lang.ar.name ? Lang.ar : Lang.en;
  }

  static bool isArabic(BuildContext context) {
    return getCurrentLocale(context) == Lang.ar;
  }

  static void toggleLang(BuildContext context) {
    if (isArabic(context)) {
      en(context);
      return;
    }
    if (isEnglish(context)) {
      ar(context);
    }
  }

  static void changeLangByOne(BuildContext context, {Lang? lang}) {
    if (lang != null) {
      if (lang == Lang.en) {
        en(context);
        return;
      }
      if (lang == Lang.ar) {
        ar(context);
        return;
      }
    }
  }

  void toDLang(BuildContext context) {
    context.resetLocale();
  }
}

extension trk on String {
  String get tre => tr(this);
  bool get isKey => trExists(this);
}
