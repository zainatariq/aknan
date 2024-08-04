import '../localization/change_language.dart';

class TValidator {
  static String mustWrite = 'MustWrite';
  static const String tMustHaveValue = 'must have value';

  static const String tWrongEmail = 'Wrong Email';
  static const String tWrongConfirmedPassword = 'wrong confirmed password';
  static const String tMustChoose = "Must Choose";

  static const String tThePasswordMustBeAtLeast8CharactersLong =
      "The password must be at least 8 characters long";

  static const String tTheNationalIdMustBeAtLeast10CharactersLong =
      "The National Id Must Be At Least 10 Characters Long";

  static const String tTheSaudiNumberMustBeAtLeast9CharactersLong =
      "The Saudi Number Must Be At Least 9 Characters Long";
  static Map<String, dynamic> arV = {
    tWrongConfirmedPassword: 'كلمة مرور مؤكدة خاطئة',
    tWrongEmail: "بريد الكترونى خاطئي",
    "MustWrite": " من فضلك إكتب",
    "must have value": "يجب أن يكون لها قيمة",
    tThePasswordMustBeAtLeast8CharactersLong: "يجب لا يقل الباسورد عن ٨ خانات",
    tTheNationalIdMustBeAtLeast10CharactersLong:
        "يجب ان يكون رقم الهويه مكون من 10  خانات ",
    tTheSaudiNumberMustBeAtLeast9CharactersLong:
        " يجب ان يكون الرقم الهاتف من 9 خانات "
  };

  static Map<String, dynamic> enV = {
    tWrongEmail: "Wrong Email",
    tWrongConfirmedPassword: 'wrong confirmed password',
    "MustWrite": "You Must Write",
    "must have value": "You Must Write",
    tThePasswordMustBeAtLeast8CharactersLong:
        "The password must be at least 8 characters long",
    tTheNationalIdMustBeAtLeast10CharactersLong:
        tTheNationalIdMustBeAtLeast10CharactersLong,
    tTheSaudiNumberMustBeAtLeast9CharactersLong:
        tTheSaudiNumberMustBeAtLeast9CharactersLong
  };

  static String? normalValidator(
    String? value, {
    String? hint,
    bool Function(String)? validate,
  }) {
    bool showValidate = false;
    if (validate != null) {
      showValidate = validate(value!);
    }
    if (value == null || value.isEmpty) {
      return "${mustWrite.tre} ${hint!}";
    } else if (showValidate) {
      return hint ?? tMustHaveValue.tre;
    } else {
      return null;
    }
  }

  static String? confirmPasswordValidate(
      {required String? value,
      required String comparePassword,
      required String? hint}) {
    if (value == null || value.isEmpty) {
      return "${mustWrite.tre} ${hint!}";
    } else if (!(value == comparePassword)) {
      return tWrongConfirmedPassword.tre;
    } else {
      return null;
    }
  }

  static String? email(
    String? value,
    String? hint,
  ) {
    if (value == null || value.isEmpty) {
      return null;
      // return "${mustWrite.tre} ${hint!}";
    } else if (!RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(value)) {
      return tWrongEmail.tre;
    } else {
      return null;
    }
  }

  static String? dropDown(
    String? value,
    String? hint,
  ) {
    if (value == null || value.isEmpty) {
      return "${tMustChoose.tre} ${hint!}";
    } else {
      return null;
    }
  }

  static passwordValidate({required String? value, required String? hint}) {
    if (value == null || value.isEmpty) {
      return "${mustWrite.tre} ${hint!}";
    } else if (!(value.length >= 8)) {
      return tThePasswordMustBeAtLeast8CharactersLong.tre;
    } else {
      return null;
    }
  }

  static nationalId({required String? value, required String? hint}) {
    if (value == null || value.isEmpty) {
      return "${mustWrite.tre} ${hint!}";
    } else if ((value.length != 11)) {
      return tTheNationalIdMustBeAtLeast10CharactersLong.tre;
    } else {
      return null;
    }
  }

  static saudiNumber({required String? value, required String? hint}) {
    value = "+966$value";
    if (value.isEmpty) {
      return "${mustWrite.tre} ${hint!}";
    } else if ((value.length != 13)) {
      return tTheSaudiNumberMustBeAtLeast9CharactersLong.tre;
    } else {
      return null;
    }
  }
}
