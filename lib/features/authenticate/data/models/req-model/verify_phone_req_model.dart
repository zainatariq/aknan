// verify_phone_req_model
import '../base_phone_req_model.dart';

class VerifyPhoneReqModel {
  BasePhoneReqModel phoneReqModel;
  String phoneConfirmationToken;
  VerifyPhoneReqModel({
    required this.phoneReqModel,
    required this.phoneConfirmationToken,
  });

  Map<String, dynamic> toJson() {
    return {
      ...phoneReqModel.toJson(),
      'phone_confirmation_token': phoneConfirmationToken,
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
