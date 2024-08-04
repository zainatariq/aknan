import '../../../../../networking/api_service.dart';
import '../../../../../networking/network_state.dart';
import '../model/setting_model.dart';

class SettingsRepo {

  final ApiService _apiService;
  SettingsRepo(
   this._apiService,
  );


  //GET ABOUT US
  Future<NetworkState<AboutUsRes>> getAboutUs() async {
    return  _apiService.getAboutUs();
  }

  
}
