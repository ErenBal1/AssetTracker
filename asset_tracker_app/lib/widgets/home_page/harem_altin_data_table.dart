import 'package:asset_tracker_app/localization/strings.dart';
import 'package:asset_tracker_app/utils/constants/theme/constant_sizes.dart';
import 'package:flutter/material.dart';

class HaremAltinTableData extends StatelessWidget {
  final Map<String, dynamic> data;
  final Map<String, dynamic> previousData;

  const HaremAltinTableData({
    super.key,
    required this.data,
    required this.previousData,
  });

  String _formatValue(dynamic value) {
    if (value == null) return '';
    if (value is int || value is double) {
      return value.toString();
    }
    return value;
  }

  // Değer değişimini kontrol edip ok işareti döndüren fonksiyon
  Widget _buildDirectionArrow(String code, String type) {
    if (previousData.isEmpty || !previousData.containsKey(code)) {
      return const SizedBox.shrink();
    }

    double? currentValue = double.tryParse(_formatValue(data[code][type]));
    double? previousValue =
        double.tryParse(_formatValue(previousData[code][type]));

    if (currentValue == null || previousValue == null) {
      return const SizedBox.shrink();
    }

    if (currentValue > previousValue) {
      return const Icon(Icons.arrow_upward,
          color: Colors.green, size: ConstantSizes.iconSmall);
    } else if (currentValue < previousValue) {
      return const Icon(Icons.arrow_downward,
          color: Colors.red, size: ConstantSizes.iconSmall);
    }

    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    final sortedCodes = data.keys.toList()..sort();
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
          rows: sortedCodes.map((code) {
            final currencyData = data[code];
            return DataRow(
              cells: [
                // Kod datalarinin oldugu sutun
                DataCell(Text(code)),
                // Alis datalarinin oldugu sutun
                DataCell(
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(_formatValue(currencyData['alis'])),
                      _buildDirectionArrow(code, 'alis'),
                    ],
                  ),
                ),
                // Satis datalarinin oldugu sutun
                DataCell(
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(_formatValue(currencyData['satis'])),
                      _buildDirectionArrow(code, 'satis'),
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
