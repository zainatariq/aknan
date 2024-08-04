part of 'complete_data_cubit.dart';

@freezed
class CompleteDataState with _$CompleteDataState {
  const factory CompleteDataState.initial() = _Initial;
  const factory CompleteDataState.loading(bool inBtn) = Loading;
  const factory CompleteDataState.error(String message) = Error;
  const factory CompleteDataState.success() = Success;
 
  const factory CompleteDataState.selectGovernment() = _SelectGovernment;
  const factory CompleteDataState.getGovernment(MaltiDropdown data) = GetGovernment;

   const factory CompleteDataState.selectCity() = _SelectCity;
  const factory CompleteDataState.getCity(MaltiDropdown data) = GetCity;

  const factory CompleteDataState.selectDistrict() = _SelectDistrict;
  const factory CompleteDataState.getDistrict(MaltiDropdown data) = GetDistrict;

  
}
