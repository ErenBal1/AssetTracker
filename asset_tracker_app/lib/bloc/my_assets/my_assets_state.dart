import 'package:asset_tracker_app/models/harem_altin_currency_data_model.dart';
import 'package:asset_tracker_app/models/user_asset.dart';

abstract class MyAssetsState {}

class MyAssetsInitial extends MyAssetsState {}

class MyAssetsLoading extends MyAssetsState {}

class MyAssetsLoaded extends MyAssetsState {
  final List<UserAsset> assets;
  final Map<String, CurrencyData> currentRates;

  MyAssetsLoaded({
    required this.assets,
    required this.currentRates,
  });
}

class MyAssetsError extends MyAssetsState {
  final String message;
  MyAssetsError(this.message);
}
