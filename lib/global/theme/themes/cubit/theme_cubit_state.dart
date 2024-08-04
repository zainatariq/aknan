part of 'theme_cubit_cubit.dart';

@freezed
class ThemeCubitState with _$ThemeCubitState {
  const factory ThemeCubitState.initial() = _Initial;
  const factory ThemeCubitState.getCurrent() = _Current;
  const factory ThemeCubitState.toLight() = _ToLight;
  const factory ThemeCubitState.toDark() = _ToDark;
}
