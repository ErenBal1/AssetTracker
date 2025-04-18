import 'package:asset_tracker_app/utils/constants/theme/constant_paddings.dart';
import 'package:asset_tracker_app/utils/constants/theme/constant_sizes.dart';
import 'package:asset_tracker_app/utils/constants/theme/constant_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:asset_tracker_app/models/harem_altin_currency_data_model.dart';
import 'package:intl/intl.dart';

mixin PriceStylingMixin {
  Color getPriceChangeColor(bool isIncreased) {
    return isIncreased ? Colors.green.shade100 : Colors.red.shade100;
  }

  Widget buildPriceContainer({
    required String type,
    required CurrencyData currency,
    required String priceType,
    CurrencyData? previousCurrency,
  }) {
    final formatter = NumberFormat('#,##0.00', 'tr_TR');
    String currentPrice = priceType == 'alis'
        ? formatter.format(currency.alis)
        : formatter.format(currency.satis);

    bool hasIncreased = currency.hasIncreasedFrom(previousCurrency, priceType);
    bool hasDecreased = currency.hasDecreasedFrom(previousCurrency, priceType);

    return Container(
      padding: ConstantPaddings.allXS,
      decoration: BoxDecoration(
        color: hasIncreased
            ? getPriceChangeColor(true)
            : hasDecreased
                ? getPriceChangeColor(false)
                : Colors.transparent,
        borderRadius:
            BorderRadius.circular(ConstantSizes.borderRadiusCircularXS),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(type, style: ConstantTextStyles.buySellText),
          Text(
            currentPrice,
            style: ConstantTextStyles.priceText,
          ),
        ],
      ),
    );
  }
}
