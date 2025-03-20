import 'package:asset_tracker_app/utils/constants/profile_view_chart_colors.dart';
import 'package:asset_tracker_app/utils/constants/theme/constant_sizes.dart';
import 'package:asset_tracker_app/utils/formatters/currency_formatter.dart';
import 'package:flutter/material.dart';

/// Builds chart legend with asset types and colors
/// Set [showPrices] to true to display asset values
Widget buildChartLegend(Map<String, double> assetValues,
    {bool showPrices = true}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: assetValues.keys.map((typeName) {
      final colorIndex =
          assetValues.keys.toList().indexOf(typeName) % chartColors.length;
      final value = assetValues[typeName] ?? 0;

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: ConstantSizes.paddingXS),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                color: chartColors[colorIndex],
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: ConstantSizes.gapSmall),
            Flexible(
              child: Text(
                showPrices
                    ? '$typeName (${CurrencyFormatter.formatCurrency(value)})'
                    : typeName,
                style: const TextStyle(fontSize: ConstantSizes.textSmall),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      );
    }).toList(),
  );
}
