import 'package:asset_tracker_app/utils/constants/theme/constant_gap_sizes.dart';
import 'package:asset_tracker_app/utils/constants/theme/constant_paddings.dart';
import 'package:asset_tracker_app/utils/constants/theme/constant_sizes.dart';
import 'package:asset_tracker_app/utils/constants/theme/constant_text_styles.dart';
import 'package:flutter/material.dart';

class ChartCard extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget legend;
  const ChartCard({
    super.key,
    required this.title,
    required this.child,
    required this.legend,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: ConstantPaddings.custom(
            horizontal: ConstantSizes.paddingM,
            vertical: ConstantSizes.paddingXS),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(ConstantSizes.borderRadiusCircularXS),
        ),
        child: Padding(
            padding: ConstantPaddings.allM,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: ConstantTextStyles.assetNameLabel,
                ),
                const GapSize.small(),
                SizedBox(
                  height: 200,
                  child: child,
                ),
                const GapSize.mediumLarge(),
                legend,
              ],
            )));
  }
}
