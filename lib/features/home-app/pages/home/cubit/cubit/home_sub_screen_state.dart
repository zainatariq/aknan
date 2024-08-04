part of 'home_sub_screen_cubit.dart';

@freezed
class HomeSubScreenState with _$HomeSubScreenState {
  const factory HomeSubScreenState.initial() = _Initial;
  const factory HomeSubScreenState.loading() = _Loading;
  const factory HomeSubScreenState.changeBanarIndex(int index) =
      _ChangeBanarIndex;
      
}
