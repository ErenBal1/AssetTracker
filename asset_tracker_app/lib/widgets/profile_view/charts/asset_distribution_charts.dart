import 'package:asset_tracker_app/models/user_asset.dart';
import 'package:asset_tracker_app/localization/strings.dart';
import 'package:asset_tracker_app/utils/constants/profile_view_chart_colors.dart';
import 'package:asset_tracker_app/utils/constants/theme/constant_sizes.dart';
import 'package:asset_tracker_app/utils/formatters/currency_formatter.dart';
import 'package:asset_tracker_app/viewmodels/profile_viewmodel.dart';
import 'package:asset_tracker_app/widgets/profile_view/charts/chart_card.dart';
import 'package:asset_tracker_app/widgets/profile_view/charts/chart_legends.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

/// A widget that displays asset distribution using pie chart and bar chart
/// All calculations are delegated to ProfileViewModel
class AssetDistributionCharts extends StatelessWidget {
  final List<UserAsset> assets;
  final Map<String, dynamic> currencies;
  final double totalValue;
  final ProfileViewModel viewModel;

  const AssetDistributionCharts({
    super.key,
    required this.assets,
    required this.currencies,
    required this.totalValue,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate asset values by type
    final Map<String, double> assetValues =
        viewModel.calculateAssetValuesByType(assets, currencies);

    // Prepare chart data
    final sections = _buildPieChartSections(assetValues);
    final barGroups = _buildBarChartGroups(assetValues);

    return Column(
      children: [
        // Pie Chart
        ChartCard(
          title: LocalStrings.pieChartTitle,
          legend: buildChartLegend(assetValues, showPrices: true),
          child: PieChart(
            PieChartData(
              sections: sections,
              centerSpaceRadius: 40,
              sectionsSpace: 2,
            ),
          ),
        ),

        // Bar Chart
        ChartCard(
          title: LocalStrings.barChartTitle,
          legend: buildChartLegend(assetValues, showPrices: false),
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: assetValues.values.isEmpty
                  ? 0
                  : assetValues.values.reduce((a, b) => a > b ? a : b) * 1.2,
              titlesData: const FlTitlesData(
                show: true,
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
              gridData: const FlGridData(show: true),
              borderData: FlBorderData(show: true),
              barGroups: barGroups,
              barTouchData: BarTouchData(
                enabled: true,
                touchTooltipData: BarTouchTooltipData(
                  tooltipBgColor: Colors.black.withOpacity(0.8),
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    final value = rod.toY;
                    return BarTooltipItem(
                      '${LocalStrings.totalValue} ${CurrencyFormatter.formatCurrency(value)}',
                      const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Builds pie chart sections based on asset values
  List<PieChartSectionData> _buildPieChartSections(
      Map<String, double> assetValues) {
    final sections = <PieChartSectionData>[];

    int index = 0;
    assetValues.forEach((typeName, value) {
      final percentage = (value / totalValue * 100).toStringAsFixed(1);
      final colorIndex = index % chartColors.length;

      sections.add(
        PieChartSectionData(
          color: chartColors[colorIndex],
          value: value,
          title: '$percentage%',
          radius: 80,
          titleStyle: const TextStyle(
            fontSize: ConstantSizes.textSmall,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      );

      index++;
    });

    return sections;
  }

  /// Builds bar chart groups based on asset values
  List<BarChartGroupData> _buildBarChartGroups(
      Map<String, double> assetValues) {
    final barGroups = <BarChartGroupData>[];

    int index = 0;
    assetValues.forEach((typeName, value) {
      final colorIndex = index % chartColors.length;

      barGroups.add(
        BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              toY: value,
              color: chartColors[colorIndex],
              width: 20,
              borderRadius: const BorderRadius.only(
                topLeft:
                    Radius.circular(ConstantSizes.borderRadiusCircularXS / 2),
                topRight:
                    Radius.circular(ConstantSizes.borderRadiusCircularXS / 2),
              ),
            ),
          ],
        ),
      );

      index++;
    });

    return barGroups;
  }
}
