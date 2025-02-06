import 'package:asset_tracker_app/models/harem_altin_currency_data_model.dart';
import 'package:flutter/material.dart';
import 'currency_info_widget.dart';
import 'price_info_widget.dart';

class AssetListItem extends StatelessWidget {
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
            flex: 2,
            child: CurrencyInfoWidget(currency: currency),
          ),
          Expanded(
            flex: 3,
            child: PriceInfoWidget(
              currency: currency,
              previousCurrency: previousCurrency,
            ),
          ),
        ],
      ),
    );
  }
}
