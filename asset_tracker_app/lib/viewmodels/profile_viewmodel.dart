import 'package:asset_tracker_app/models/user_asset.dart';
import 'package:asset_tracker_app/repositories/user_asset_repository.dart';
import 'package:intl/intl.dart';

/// ViewModel for the profile screen that handles business logic
/// and provides data for the UI.
class ProfileViewModel {
  final UserAssetRepository _userAssetRepository;

  /// Constructor requires a UserAssetRepository
  ProfileViewModel({required UserAssetRepository userAssetRepository})
      : _userAssetRepository = userAssetRepository;

  /// Stream of user assets
  Stream<List<UserAsset>> get userAssetsStream =>
      _userAssetRepository.getUserAssets();

  /// Formats currency amount with Turkish lira symbol
  String formatCurrency(double amount) {
    // Create custom format with currency symbol on the right
    final turkishFormat = NumberFormat.currency(
      locale: 'tr_TR',
      symbol: 'TL',
      decimalDigits: 2,
      customPattern: '###,###,##0.00 \u00A4',
    );
    return turkishFormat.format(amount);
  }

  /// Calculates total asset value from all assets
  double calculateTotalAssetValue(
      List<UserAsset> assets, Map<String, dynamic> currencies) {
    double totalValue = 0.0;

    for (final asset in assets) {
      final currentRate = currencies[asset.type.name];
      if (currentRate != null) {
        totalValue += asset.getCurrentValue(currentRate);
      }
    }

    return totalValue;
  }

  /// Groups assets by their type and calculates aggregate values
  Map<String, Map<String, dynamic>> groupAssetsByType(
      List<UserAsset> assets, Map<String, dynamic> currencies) {
    final Map<String, List<UserAsset>> groupedAssets = {};
    final Map<String, double> totalAmounts = {};
    final Map<String, double> totalValues = {};
    final Map<String, double> totalPurchaseValues = {};
    final Map<String, double> totalProfitLoss = {};

    // Group assets by type name and calculate totals
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

    // Return a combined map with all calculated values
    final result = <String, Map<String, dynamic>>{};
    result['groupedAssets'] = {'data': groupedAssets};
    result['totalAmounts'] = totalAmounts.map((k, v) => MapEntry(k, v));
    result['totalValues'] = totalValues.map((k, v) => MapEntry(k, v));
    result['totalPurchaseValues'] =
        totalPurchaseValues.map((k, v) => MapEntry(k, v));
    result['totalProfitLoss'] = totalProfitLoss.map((k, v) => MapEntry(k, v));

    return result;
  }

  /// Calculates asset values by type for chart data
  Map<String, double> calculateAssetValuesByType(
      List<UserAsset> assets, Map<String, dynamic> currencies) {
    final Map<String, double> assetValues = {};

    for (final asset in assets) {
      final typeName = asset.type.displayName;
      final currentRate = currencies[asset.type.name];

      if (currentRate != null) {
        final value = asset.getCurrentValue(currentRate);
        assetValues[typeName] = (assetValues[typeName] ?? 0) + value;
      }
    }

    return assetValues;
  }
}
