import 'package:asset_tracker_app/localization/strings.dart';
import 'package:asset_tracker_app/models/user_asset.dart';
import 'package:asset_tracker_app/utils/constants/theme/constant_sizes.dart';
import 'package:asset_tracker_app/utils/constants/theme/constant_text_styles.dart';
import 'package:asset_tracker_app/utils/formatters/currency_formatter.dart';
import 'package:flutter/material.dart';

/// A card widget that displays information about a specific asset type
class AssetCard extends StatelessWidget {
  final String typeName;
  final double amount;
  final double value;
  final double profitLoss;
  final double profitLossPercentage;
  final Color profitLossColor;
  final List<UserAsset> assets;
  final Map<String, dynamic> currencies;

  const AssetCard({
    super.key,
    required this.typeName,
    required this.amount,
    required this.value,
    required this.profitLoss,
    required this.profitLossPercentage,
    required this.profitLossColor,
    required this.assets,
    required this.currencies,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: ConstantSizes.paddingM),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(ConstantSizes.borderRadiusCircularXS),
      ),
      child: Padding(
        padding: const EdgeInsets.all(ConstantSizes.paddingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Asset name and total amount
            _buildAssetHeader(),
            const SizedBox(height: ConstantSizes.paddingM),
            // Total value
            _buildValueRow(),
            const SizedBox(height: ConstantSizes.paddingXS),
            // Profit/Loss information
            _buildProfitLossRow(),
            // Asset details if there are multiple assets of this type
            if (assets.length > 1) _buildDetailsExpansion(),
          ],
        ),
      ),
    );
  }

  // Builds the asset header with name and amount
  Widget _buildAssetHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Asset name
        Text(
          typeName,
          style: ConstantTextStyles.assetNameLabel,
        ),
        // Total amount
        Text(
          '${LocalStrings.amount}${CurrencyFormatter.formatDouble(amount)}',
          style: TextStyle(
            fontSize: ConstantSizes.textMedium,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }

  // Builds the value row
  Widget _buildValueRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Value label
        Text(
          LocalStrings.totalValue,
          style: TextStyle(
            fontSize: ConstantSizes.textSmall,
            color: Colors.grey[600],
          ),
        ),
        // Value amount
        Text(
          CurrencyFormatter.formatCurrency(value),
          style: const TextStyle(
            fontSize: ConstantSizes.textMedium,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
      ],
    );
  }

  // Builds the profit/loss row
  Widget _buildProfitLossRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Profit/Loss label
        Text(
          LocalStrings.profitLoss,
          style: TextStyle(
            fontSize: ConstantSizes.textSmall,
            color: Colors.grey[600],
          ),
        ),
        // Profit/Loss value and percentage
        Text(
          '${CurrencyFormatter.formatProfitLoss(profitLoss)} (${CurrencyFormatter.formatPercentage(profitLossPercentage)})',
          style: TextStyle(
            fontSize: ConstantSizes.textMedium,
            fontWeight: FontWeight.bold,
            color: profitLossColor,
          ),
        ),
      ],
    );
  }

  // Builds the expandable details section
  Widget _buildDetailsExpansion() {
    return Padding(
      padding: const EdgeInsets.only(top: ConstantSizes.paddingXS),
      child: ExpansionTile(
        title: Text(
          '${LocalStrings.details} (${assets.length})',
          style: const TextStyle(fontSize: ConstantSizes.textSmall),
        ),
        children: assets.map((asset) {
          final currentRate = currencies[asset.type.name];

          if (currentRate == null) {
            return const SizedBox.shrink();
          }

          final currentValue = asset.getCurrentValue(currentRate);
          final assetProfitLoss = asset.getProfitLoss(currentRate);
          final assetProfitLossPercentage =
              asset.getProfitLossPercentage(currentRate);
          final assetProfitLossColor =
              assetProfitLoss >= 0 ? Colors.green : Colors.red;

          return ListTile(
            dense: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    '${LocalStrings.amount}${CurrencyFormatter.formatDouble(asset.amount)}'),
                Text(
                  '${CurrencyFormatter.formatProfitLoss(assetProfitLoss)} (${CurrencyFormatter.formatPercentage(assetProfitLossPercentage)})',
                  style: TextStyle(
                    fontSize: ConstantSizes.textSmall,
                    fontWeight: FontWeight.bold,
                    color: assetProfitLossColor,
                  ),
                ),
              ],
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${LocalStrings.purchaseLabel} ${CurrencyFormatter.formatCurrency(asset.purchasePrice * asset.amount)}',
                  style: TextStyle(
                      fontSize: ConstantSizes.textSmall,
                      color: Colors.grey[600]),
                ),
                Text(
                  '${LocalStrings.currentlyLabel} ${CurrencyFormatter.formatCurrency(currentValue)}',
                  style: TextStyle(
                      fontSize: ConstantSizes.textSmall,
                      color: Colors.grey[600]),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
