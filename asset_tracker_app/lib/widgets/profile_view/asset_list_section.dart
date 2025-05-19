import 'package:asset_tracker_app/models/user_asset.dart';
import 'package:asset_tracker_app/widgets/profile_view/asset_card.dart';
import 'package:flutter/material.dart';

/// A widget that displays grouped assets in a list format
class AssetListSection extends StatelessWidget {
  final List<UserAsset> assets;
  final Map<String, dynamic> currencies;

  const AssetListSection({
    super.key,
    required this.assets,
    required this.currencies,
  });

  @override
  Widget build(BuildContext context) {
    // Group assets by their display names
    final Map<String, List<UserAsset>> groupedAssets = {};
    final Map<String, double> totalAmounts = {};
    final Map<String, double> totalValues = {};
    final Map<String, double> totalPurchaseValues = {};
    final Map<String, double> totalProfitLoss = {};

    // Group assets and calculate totals
    for (final asset in assets) {
      final displayName = asset.displayName;
      if (!groupedAssets.containsKey(displayName)) {
        groupedAssets[displayName] = [];
        totalAmounts[displayName] = 0;
        totalValues[displayName] = 0;
        totalPurchaseValues[displayName] = 0;
        totalProfitLoss[displayName] = 0;
      }

      groupedAssets[displayName]!.add(asset);
      totalAmounts[displayName] =
          (totalAmounts[displayName] ?? 0) + asset.amount;

      // Calculate total purchase value
      final purchaseValue = asset.amount * asset.purchasePrice;
      totalPurchaseValues[displayName] =
          (totalPurchaseValues[displayName] ?? 0) + purchaseValue;

      // Calculate current total value
      final currentValue = asset.getCurrentValue(currencies);
      totalValues[displayName] = (totalValues[displayName] ?? 0) + currentValue;

      // Calculate profit/loss
      final profitLoss = asset.getProfitLoss(currencies);
      totalProfitLoss[displayName] =
          (totalProfitLoss[displayName] ?? 0) + profitLoss;
    }

    // Return the list of grouped assets
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: groupedAssets.length,
      itemBuilder: (context, index) {
        final displayName = groupedAssets.keys.elementAt(index);
        final amount = totalAmounts[displayName] ?? 0;
        final value = totalValues[displayName] ?? 0;
        final profitLoss = totalProfitLoss[displayName] ?? 0;
        final initialValue = totalPurchaseValues[displayName] ?? 0;
        final profitLossPercentage =
            initialValue > 0 ? (profitLoss / initialValue) * 100 : 0.0;

        // Determine profit/loss color
        final isProfitable = profitLoss >= 0;
        final profitLossColor = isProfitable ? Colors.green : Colors.red;

        return AssetCard(
          typeName: displayName,
          amount: amount,
          value: value,
          profitLoss: profitLoss,
          profitLossPercentage: profitLossPercentage,
          profitLossColor: profitLossColor,
          assets: groupedAssets[displayName]!,
          currencies: currencies,
        );
      },
    );
  }
}
