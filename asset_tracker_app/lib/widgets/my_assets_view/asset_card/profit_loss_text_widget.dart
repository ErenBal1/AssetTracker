import 'package:asset_tracker_app/localization/strings.dart';
import 'package:asset_tracker_app/utils/constants/theme/constant_sizes.dart';
import 'package:flutter/material.dart';

Widget profitLossTextWidget(double profitLoss, double profitLossPercentage) {
  return Text(
    '${LocalStrings.profitLoss}${profitLoss.toStringAsFixed(2)} (${profitLossPercentage.toStringAsFixed(2)}%)',
    style: TextStyle(
      fontSize: ConstantSizes.textLarge,
      fontWeight: FontWeight.bold,
      color: profitLoss >= 0 ? Colors.green : Colors.red,
    ),
  );
}
