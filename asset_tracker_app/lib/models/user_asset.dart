import 'package:asset_tracker_app/models/harem_altin_currency_data_model.dart';
import 'package:asset_tracker_app/utils/enums/currency_type_enum.dart';

class UserAsset {
  final String id;
  final String userId;
  final CurrencyType type;
  final double amount;
  final double purchasePrice;
  final DateTime purchaseDate;
  final DateTime createdAt;

  UserAsset({
    required this.id,
    required this.userId,
    required this.type,
    required this.amount,
    required this.purchasePrice,
    required this.purchaseDate,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'type': type.name,
      'amount': amount,
      'purchasePrice': purchasePrice,
      'purchaseDate': purchaseDate.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory UserAsset.fromMap(Map<String, dynamic> map) {
    return UserAsset(
      id: map['id'],
      userId: map['userId'],
      type: CurrencyType.values.firstWhere(
        (e) => e.name == map['type'],
        orElse: () => CurrencyType.USDTRY,
      ),
      amount: map['amount'],
      purchasePrice: map['purchasePrice'],
      purchaseDate: DateTime.parse(map['purchaseDate']),
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  // For calculating the current value of the asset
  double getCurrentValue(CurrencyData currentRate) {
    return amount * currentRate.satis;
  }

  // Profit/Loss
  double getProfitLoss(CurrencyData currentRate) {
    double currentValue = getCurrentValue(currentRate);
    double initialValue = amount * purchasePrice;
    return currentValue - initialValue;
  }

  // Profit/Loss Percentage
  double getProfitLossPercentage(CurrencyData currentRate) {
    double profitLoss = getProfitLoss(currentRate);
    double initialValue = amount * purchasePrice;
    return (profitLoss / initialValue) * 100;
  }
}
