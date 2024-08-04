import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../change_language.dart';

part 'localization_cubit.freezed.dart';
part 'localization_state.dart';

class LocalizationCubit extends Cubit<LocalizationState> {
  LocalizationCubit() : super(const LocalizationState.initial());

  Lang get currentLang => _currentLang;
  Locale get currentLangLocal => Locale(_currentLang.name);
  Lang _currentLang = Lang.en;

  

  void getCurrentLang(BuildContext context) {
    _currentLang = TLang.getCurrentLocale(context);
    emit(const LocalizationState.getCurrent());
  }

  void toArLang(BuildContext context) {
    _currentLang = Lang.ar;
    TLang.ar(context);
    emit(const LocalizationState.toAr());
  }

  void toEnLang(BuildContext context) {
    _currentLang = Lang.en;
    TLang.en(context);
    emit(const LocalizationState.toEn());
  }

  void toggleLang(BuildContext context, {Lang? lang}) {
    if (lang == Lang.ar) {
      toArLang(context);
      return;
    }
    if (lang == Lang.en) {
      toEnLang(context);
      return;
    }
  }

  void switchLang(BuildContext context) {
    if (kDebugMode) {
      print(" context.locale.countryCode ${context.locale.countryCode} ");
    }
    _currentLang = Lang.values.firstWhere(
      (element) => element.name == context.locale.languageCode,
    );
    if (_currentLang != Lang.ar) {
      toArLang(context);
      return;
    }
    if (_currentLang != Lang.en) {
      toEnLang(context);
      return;
    }
  }
}
