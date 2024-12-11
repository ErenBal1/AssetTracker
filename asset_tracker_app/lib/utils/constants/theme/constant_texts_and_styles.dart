import 'package:asset_tracker_app/localization/strings.dart';
import 'package:asset_tracker_app/utils/constants/theme/constant_sizes.dart';
import 'package:flutter/material.dart';

class ConstantTextsAndStyles {
  //Splash Screen
  static const Text splashAppLabelText = Text(
    LocalStrings.appLabel,
    style: TextStyle(
      fontSize: ConstantSizes.textXXXL,
      fontWeight: FontWeight.bold,
    ),
  );

  //Onboard Screen

  static Text getOnboardPageTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: ConstantSizes.textXXL,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }

  static Text getOnboardPageDescription(String description) {
    return Text(
      description,
      style: const TextStyle(
        fontSize: ConstantSizes.textLarge,
        color: Colors.grey,
      ),
      textAlign: TextAlign.center,
    );
  }

  static getOnboardPageButtonText(String text) {
    return Text(text, style: _buttonTextStyle);
  }

  static const TextStyle _buttonTextStyle = TextStyle(
    fontSize: ConstantSizes.textLarge,
    fontWeight: FontWeight.bold,
  );

//   static Text getButtonText(String text) {
//   return Text(text, style: _buttonTextStyle);
// }

//getOnboardPageButtonText ve getLoginPageButtonText tanimlamalarini ikisi de ayni islevde oldugu icin yukarida yazdigim sekilde yapacaktim fakat kendi sayfalarini okurken okunurluk acisindan su anki hallerini daha uygun buldum.

//Login Page

  static Text getLoginPageButtonText(String text) {
    return Text(
      text,
      style: _buttonTextStyle,
    );
  }

  static Text welcome = const Text(
    LocalStrings.welcome,
    style: TextStyle(
      fontSize: ConstantSizes.textXXL,
      fontWeight: FontWeight.bold,
    ),
    textAlign: TextAlign.center,
  );
}
