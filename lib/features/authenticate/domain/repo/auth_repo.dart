import '../../../../helpers/data_state.dart';
import '../../data/models/base_model.dart';
import '../../data/models/base_phone_req_model.dart';
import '../../data/models/req-model/change_password_req_model.dart';
import '../../data/models/req-model/complete_data_req_model.dart';
import '../../data/models/req-model/login_with_otp_model.dart';
import '../../data/models/req-model/login_with_pass_req_model.dart';
import '../../data/models/req-model/register_req_model.dart';
import '../../data/models/req-model/update_password_req_model.dart';
import '../../data/models/req-model/verify_phone_req_model.dart';
import '../../data/models/res-models/register_res_model.dart';
import '../../data/models/res-models/user_model.dart';

abstract class AuthRepo {
  Future<DataState<AKnanAuthorizedResModel>> register(
      AknanRegisterReqModel req);

  Future<DataState<AKnanAuthorizedResModel>> loginWithPassword(
    LoginWithPassReqModel loginWithPassReqModel,
  );

  Future<DataState<AKnanAuthorizedResModel>> loginWithOtp(
    LoginWithOtpReqModel loginWithOtpModel,
  );

  Future<DataState<AKnanAuthorizedResModel>> completeData(
    CompleteDataReqModel completeDataReqModel,
  );

  Future<DataState<AKnanAuthorizedResModel>> verifyPhone(
    VerifyPhoneReqModel verifyPhoneReqModel,
  );

  Future<DataState<MsgModel>> sendOtp(
    BasePhoneReqModel sendOtpReqModel,
  );

  Future<DataState<MsgModel>> checkOtpCode(LoginWithOtpReqModel req);

  Future<DataState<MsgModel>> forgetPassword(
    BasePhoneReqModel sendOtpReqModel,
  );

  Future<DataState<MsgModel>> updatePassword(
    UpdatePasswordReqModel updatePasswordReqModel,
  );

  Future<DataState<MsgModel>> changePass(ChangePasswordReqModel req);

  Future<bool?> setUserDate(UserAuthModel? user);

  Future<UserAuthModel?> getUserData();

  Future<bool> isAuthenticated();

  // Future<LoginWithPassReqModel?> getAuthUserData();

  // Future<void> saveAuthUserData(LoginWithPassReqModel? loginWithPassReqModel);

  // Future<bool> isContainsAuthUserData();
  Future logout();
  Future deleteAcc();
}
