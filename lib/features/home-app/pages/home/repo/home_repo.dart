import '../../../../../networking/api_service.dart';

class HomeRepo {
  final ApiService _apiService;
  HomeRepo(
    this._apiService,
  );

  getHomeData() {
    return _apiService.getHomeData();
  }
}
