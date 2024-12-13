import 'package:asset_tracker_app/localization/strings.dart';

mixin ValidationMixin {
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return LocalStrings.enterEmail;
    }
    if (!value.contains('@')) {
      return LocalStrings.enterValidEmail;
    }
    return null;
  }

  String? validatePassword(String? value) {
    const int minPasswordLength = 6;

    if (value == null || value.isEmpty) {
      return LocalStrings.enterPassword;
    }
    if (value.length < minPasswordLength) {
      return LocalStrings.atLeast6characters;
    }
    return null;
  }
}
