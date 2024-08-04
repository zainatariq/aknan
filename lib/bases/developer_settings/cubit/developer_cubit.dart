

import 'developer_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeveloperCubit extends Cubit<DeveloperState> {
  DeveloperCubit() : super(DeveloperState.initial());

  bool isEndpointSelected(String endpoint) =>
      state.mockedEndpoints.contains(endpoint) || isAllEndpointsMocked;

  void markEndpointToMock(String endpoint, bool value) {
    final newMockupList = List<String>.from(state.mockedEndpoints);
    if (value) {
      newMockupList.add(endpoint);
    } else {
      newMockupList.remove(endpoint);
    }
    final newState = state.copyWith(mockedEndpoints: newMockupList);
    emit(newState);
  }

  bool get isAllEndpointsMocked => state.mockAllEndpoints;

  void mockAllEndpointToMock(bool value) {
    final newState = state.copyWith(mockAllEndpoints: value);
    emit(newState);
  }

  void changeBaseUrl(String url) => emit(state.copyWith(altBaseUrl: url));

  


}
