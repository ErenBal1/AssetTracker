import 'package:asset_tracker_app/localization/strings.dart';
import 'package:asset_tracker_app/models/harem_altin_currency_data_model.dart';
import 'package:asset_tracker_app/utils/constants/theme/constant_gap_sizes.dart';
import 'package:asset_tracker_app/utils/constants/theme/constant_text_styles.dart';
import 'package:asset_tracker_app/utils/mixins/home_screen_mixins/currency_icon_mixin.dart';
import 'package:asset_tracker_app/utils/mixins/home_screen_mixins/price_styling_mixin.dart';
import 'package:flutter/material.dart';

class AssetListItem extends StatelessWidget
    with PriceStylingMixin, CurrencyIconMixin {
  final CurrencyData currency;
  final CurrencyData? previousCurrency;

  const AssetListItem({
    super.key,
    required this.currency,
    this.previousCurrency,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Expanded(
            // Left Side - Icon and Name
            flex: 2,
            child: Row(
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
            ),
          ),
          Expanded(
            // Right Side - Prices
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Buy
                buildPriceContainer(
                  type: LocalStrings.buy,
                  currency: currency,
                  priceType: LocalStrings.buyCode,
                  previousCurrency: previousCurrency,
                ),
                // Sell
                buildPriceContainer(
                  type: LocalStrings.sell,
                  currency: currency,
                  priceType: LocalStrings.sellCode,
                  previousCurrency: previousCurrency,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
