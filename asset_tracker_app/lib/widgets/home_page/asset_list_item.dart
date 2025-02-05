import 'package:asset_tracker_app/models/harem_altin_currency_data_model.dart';
import 'package:flutter/material.dart';

class AssetListItem extends StatelessWidget {
  final CurrencyData currency;
  final CurrencyData? previousCurrency;

  const AssetListItem({
    super.key,
    required this.currency,
    this.previousCurrency,
  });

  Color _getPriceChangeColor(bool isIncreased) {
    return isIncreased ? Colors.green.shade100 : Colors.red.shade100;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Sol taraf - İkon ve isim
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Icon(
                    currency.isGold
                        ? Icons.monetization_on
                        : Icons.currency_exchange,
                    color: currency.isGold ? Colors.amber : Colors.blue,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      currency.displayName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Sağ taraf - Fiyatlar
            Expanded(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Alış Fiyatı
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: currency.hasIncreasedFrom(previousCurrency, 'alis')
                          ? _getPriceChangeColor(true)
                          : currency.hasDecreasedFrom(previousCurrency, 'alis')
                              ? _getPriceChangeColor(false)
                              : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Alış',
                            style: TextStyle(fontSize: 12, color: Colors.grey)),
                        Text(
                          '${currency.alis} ${currency.currencySymbol}',
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  // Satış Fiyatı
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: currency.hasIncreasedFrom(
                              previousCurrency, 'satis')
                          ? _getPriceChangeColor(true)
                          : currency.hasDecreasedFrom(previousCurrency, 'satis')
                              ? _getPriceChangeColor(false)
                              : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Satış',
                            style: TextStyle(fontSize: 12, color: Colors.grey)),
                        Text(
                          '${currency.satis} ${currency.currencySymbol}',
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
