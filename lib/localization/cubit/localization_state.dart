part of 'localization_cubit.dart';

@freezed
class LocalizationState with _$LocalizationState {
  const factory LocalizationState.initial() = _Initial;
  const factory LocalizationState.getCurrent() = _GetCurrent;
  const factory LocalizationState.toAr() = _ToAr;
  const factory LocalizationState.toEn() = _ToEn;
}
