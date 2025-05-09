import 'package:asset_tracker_app/localization/strings.dart';
import 'package:asset_tracker_app/models/harem_altin_currency_data_model.dart';
import 'package:asset_tracker_app/utils/constants/theme/constant_gap_sizes.dart';
import 'package:asset_tracker_app/utils/mixins/home_screen_mixins/price_styling_mixin.dart';
import 'package:flutter/material.dart';

class PriceInfoWidget extends StatelessWidget with PriceStylingMixin {
  final CurrencyData currency;
  final CurrencyData? previousCurrency;

  const PriceInfoWidget({
    super.key,
    required this.currency,
    this.previousCurrency,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: buildPriceContainer(
            type: LocalStrings.buy,
            currency: currency,
            priceType: 'alis',
            previousCurrency: previousCurrency,
          ),
        ),
        const GapSize.widthExtraSmall(),
        Expanded(
          child: buildPriceContainer(
            type: LocalStrings.sell,
            currency: currency,
            priceType: 'satis',
            previousCurrency: previousCurrency,
          ),
        ),
      ],
    );
  }
}
