import 'package:asset_tracker_app/models/user_asset.dart';
import 'package:asset_tracker_app/repositories/user_asset_repository.dart';

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

  /// Calculates total asset value from all assets
  double calculateTotalAssetValue(
      List<UserAsset> assets, Map<String, dynamic> currencies) {
    double totalValue = 0.0;

    for (final asset in assets) {
      totalValue += asset.getCurrentValue(currencies);
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

      final purchaseValue = asset.amount * asset.purchasePrice;
      totalPurchaseValues[displayName] =
          (totalPurchaseValues[displayName] ?? 0) + purchaseValue;

      final currentValue = asset.getCurrentValue(currencies);
      totalValues[displayName] = (totalValues[displayName] ?? 0) + currentValue;

      final profitLoss = asset.getProfitLoss(currencies);
      totalProfitLoss[displayName] =
          (totalProfitLoss[displayName] ?? 0) + profitLoss;
    }

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
      final displayName = asset.displayName;
      final value = asset.getCurrentValue(currencies);
      assetValues[displayName] = (assetValues[displayName] ?? 0) + value;
    }

    return assetValues;
  }
}
