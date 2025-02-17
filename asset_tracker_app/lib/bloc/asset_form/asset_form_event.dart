import 'package:asset_tracker_app/utils/enums/currency_type_enum.dart';

abstract class AssetFormEvent {}

class AssetSubmitted extends AssetFormEvent {
  final CurrencyType type;
  final double amount;
  final double purchasePrice;
  final DateTime purchaseDate;

  AssetSubmitted({
    required this.type,
    required this.amount,
    required this.purchasePrice,
    required this.purchaseDate,
  });
}
