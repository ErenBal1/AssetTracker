import 'package:asset_tracker_app/localization/strings.dart';

class FormValidator {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return LocalStrings.enterEmail;
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return LocalStrings.enterValidEmail;
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return LocalStrings.enterPassword;
    }
    if (value.length < 6) {
      return LocalStrings.atLeast6characters;
    }
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return LocalStrings.pleaseEnterYourName;
    }
    if (value.length < 2) {
      return LocalStrings.nameAtLeast2Characters;
    }
    return null;
  }
}
