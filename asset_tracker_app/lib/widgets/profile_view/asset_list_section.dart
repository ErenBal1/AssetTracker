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
    // Group assets by their types
    final Map<String, List<UserAsset>> groupedAssets = {};
    final Map<String, double> totalAmounts = {};
    final Map<String, double> totalValues = {};
    final Map<String, double> totalPurchaseValues = {};
    final Map<String, double> totalProfitLoss = {};

    // Group assets and calculate totals
    for (final asset in assets) {
      final typeName = asset.type.displayName;
      if (!groupedAssets.containsKey(typeName)) {
        groupedAssets[typeName] = [];
        totalAmounts[typeName] = 0;
        totalValues[typeName] = 0;
        totalPurchaseValues[typeName] = 0;
        totalProfitLoss[typeName] = 0;
      }

      groupedAssets[typeName]!.add(asset);
      totalAmounts[typeName] = (totalAmounts[typeName] ?? 0) + asset.amount;

      // Calculate total purchase value
      final purchaseValue = asset.amount * asset.purchasePrice;
      totalPurchaseValues[typeName] =
          (totalPurchaseValues[typeName] ?? 0) + purchaseValue;

      final currentRate = currencies[asset.type.name];
      if (currentRate != null) {
        // Calculate current total value
        final currentValue = asset.getCurrentValue(currentRate);
        totalValues[typeName] = (totalValues[typeName] ?? 0) + currentValue;

        // Calculate profit/loss
        final profitLoss = asset.getProfitLoss(currentRate);
        totalProfitLoss[typeName] =
            (totalProfitLoss[typeName] ?? 0) + profitLoss;
      }
    }

    // Return the list of grouped assets
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: groupedAssets.length,
      itemBuilder: (context, index) {
        final typeName = groupedAssets.keys.elementAt(index);
        final amount = totalAmounts[typeName] ?? 0;
        final value = totalValues[typeName] ?? 0;
        final profitLoss = totalProfitLoss[typeName] ?? 0;
        final initialValue = totalPurchaseValues[typeName] ?? 0;
        final profitLossPercentage =
            initialValue > 0 ? (profitLoss / initialValue) * 100 : 0.0;

        // Determine profit/loss color
        final isProfitable = profitLoss >= 0;
        final profitLossColor = isProfitable ? Colors.green : Colors.red;

        return AssetCard(
          typeName: typeName,
          amount: amount,
          value: value,
          profitLoss: profitLoss,
          profitLossPercentage: profitLossPercentage,
          profitLossColor: profitLossColor,
          assets: groupedAssets[typeName]!,
          currencies: currencies,
        );
      },
    );
  }
}
