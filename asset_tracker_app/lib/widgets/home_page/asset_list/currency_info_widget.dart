import 'package:asset_tracker_app/models/harem_altin_currency_data_model.dart';
import 'package:asset_tracker_app/utils/constants/theme/constant_gap_sizes.dart';
import 'package:asset_tracker_app/utils/constants/theme/constant_text_styles.dart';
import 'package:asset_tracker_app/utils/mixins/home_screen_mixins/currency_icon_mixin.dart';
import 'package:flutter/material.dart';

class CurrencyInfoWidget extends StatelessWidget with CurrencyIconMixin {
  final CurrencyData currency;

  const CurrencyInfoWidget({
    super.key,
    required this.currency,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        buildCurrencyIcon(currency.isGold),
        const GapSize.widthExtraSmall(),
        Expanded(
          child: Text(
            currency.displayName,
            style: ConstantTextStyles.assetText,
          ),
        ),
      ],
    );
  }
}
