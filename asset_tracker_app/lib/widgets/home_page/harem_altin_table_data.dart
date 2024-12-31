import 'package:asset_tracker_app/localization/strings.dart';
import 'package:asset_tracker_app/models/harem_altin_currency_data_model.dart';
import 'package:asset_tracker_app/models/harem_altin_data_model.dart';
import 'package:asset_tracker_app/utils/constants/theme/constant_sizes.dart';
import 'package:flutter/material.dart';

class HaremAltinTableData extends StatelessWidget {
  final HaremAltinDataModel currentData;
  final HaremAltinDataModel? previousData;

  const HaremAltinTableData({
    super.key,
    required this.currentData,
    this.previousData,
  });

  Widget _buildDirectionArrow(CurrencyData currency, String type) {
    final previousCurrency = previousData?.currencies[currency.code];

    if (currency.hasIncreasedFrom(previousCurrency, type)) {
      return const Icon(
        Icons.arrow_upward,
        color: Colors.green,
        size: ConstantSizes.iconSmall,
      );
    }

    if (currency.hasDecreasedFrom(previousCurrency, type)) {
      return const Icon(
        Icons.arrow_downward,
        color: Colors.red,
        size: ConstantSizes.iconSmall,
      );
    }

    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    const dataRowMaxHeight = 60.0;
    const horizontalMargin = 16.0;
    const columnSpacing = 24.0;

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          dataRowMaxHeight: dataRowMaxHeight,
          horizontalMargin: horizontalMargin,
          columnSpacing: columnSpacing,
          columns: const [
            DataColumn(label: Text(LocalStrings.haremAltinTableKod)),
            DataColumn(label: Text(LocalStrings.haremAltinTableAlis)),
            DataColumn(label: Text(LocalStrings.haremAltinTableSatis)),
          ],
          rows: currentData.sortedCurrencies.map((currency) {
            return DataRow(
              cells: [
                DataCell(Text(currency.displayName)),
                DataCell(
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('${currency.alis} ${currency.currencySymbol}'),
                      _buildDirectionArrow(currency, 'alis'),
                    ],
                  ),
                ),
                DataCell(
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('${currency.satis} ${currency.currencySymbol}'),
                      _buildDirectionArrow(currency, 'satis'),
                    ],
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
