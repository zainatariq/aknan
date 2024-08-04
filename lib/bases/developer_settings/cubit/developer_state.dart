import '../../../networking/api_constants.dart';

class DeveloperState {
  final List<String> mockedEndpoints;
  final bool mockAllEndpoints;
  final String? altBaseUrl;
  
  
  DeveloperState({
    required this.mockedEndpoints,
    required this.mockAllEndpoints,
    this.altBaseUrl = APiConstants.BASE_DEV_URL_With_User,
  
  });

  factory DeveloperState.initial() {
    return DeveloperState(
      mockedEndpoints: [],
      mockAllEndpoints: false,

    );
  }

  DeveloperState copyWith({
    List<String>? mockedEndpoints,
    bool? mockAllEndpoints,
    String? altBaseUrl,
    bool? showScanToPay,



  }) {
    return DeveloperState(
      mockedEndpoints: mockedEndpoints ?? this.mockedEndpoints,
      mockAllEndpoints: mockAllEndpoints ?? this.mockAllEndpoints,
      altBaseUrl: altBaseUrl ?? this.altBaseUrl,
   
    );
  }
}
