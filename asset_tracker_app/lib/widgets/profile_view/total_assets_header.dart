import 'package:asset_tracker_app/utils/formatters/currency_formatter.dart';
import 'package:asset_tracker_app/localization/strings.dart';
import 'package:asset_tracker_app/utils/constants/theme/constant_sizes.dart';
import 'package:asset_tracker_app/utils/constants/theme/constant_paddings.dart';
import 'package:flutter/material.dart';

/// A widget that displays the total value of assets in a stylized header
class TotalAssetsHeader extends StatelessWidget {
  final double totalAssetValue;

  /// Creates a total assets header widget
  ///
  /// [totalAssetValue] is the total value of all assets
  const TotalAssetsHeader({
    super.key,
    required this.totalAssetValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: ConstantPaddings.allM,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Theme.of(context).primaryColor, Colors.lightBlueAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius:
            BorderRadius.circular(ConstantSizes.borderRadiusCircularXS),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: ConstantSizes.paddingXL, bottom: ConstantSizes.paddingXS),
            child: Text(
              LocalStrings.totalAssetValue,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: ConstantSizes.textMedium,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: ConstantSizes.paddingXL),
            child: Text(
              CurrencyFormatter.formatCurrency(totalAssetValue),
              style: const TextStyle(
                color: Colors.white,
                fontSize: ConstantSizes.textXXL,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
