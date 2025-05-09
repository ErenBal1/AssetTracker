import 'package:asset_tracker_app/utils/constants/theme/constant_sizes.dart';
import 'package:flutter/material.dart';

class ConstantTextStyles {
  // Headline Styles
  static const TextStyle headlineLarge = TextStyle(
    fontSize: ConstantSizes.textXXXL,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontSize: ConstantSizes.textXXL,
    fontWeight: FontWeight.bold,
  );

  // Body Styles
  static const TextStyle bodyLarge = TextStyle(
    fontSize: ConstantSizes.textLarge,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle bodyLargeGrey = TextStyle(
    fontSize: ConstantSizes.textLarge,
    color: Colors.grey,
  );

  // Button Style
  static const TextStyle buttonText = TextStyle(
    fontSize: ConstantSizes.textLarge,
    fontWeight: FontWeight.bold,
  );

  // Home View Price Text Style
  static const TextStyle buySellText =
      TextStyle(fontSize: ConstantSizes.textSmall, color: Colors.grey);

  static const TextStyle priceText = TextStyle(fontWeight: FontWeight.w500);
  static const TextStyle assetText = TextStyle(fontWeight: FontWeight.bold);

  // My Assets View
  static const TextStyle assetNameLabel = TextStyle(
    fontSize: ConstantSizes.textLarge,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle assetCardInfoTexts = TextStyle(
    fontSize: ConstantSizes.textLarge,
  );

  static const TextStyle assetCardPurchaseDateText = TextStyle(
    fontSize: ConstantSizes.textMedium,
    color: Colors.grey,
  );
}
