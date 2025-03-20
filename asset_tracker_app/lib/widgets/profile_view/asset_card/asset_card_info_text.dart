import 'package:asset_tracker_app/utils/constants/theme/constant_text_styles.dart';
import 'package:flutter/material.dart';

class RecentTransactionsAssetCardInfoText extends StatelessWidget {
  const RecentTransactionsAssetCardInfoText({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: ConstantTextStyles.assetCardInfoTexts,
    );
  }
}
