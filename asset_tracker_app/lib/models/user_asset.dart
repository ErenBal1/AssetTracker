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
  final String? karat;

  UserAsset({
    required this.id,
    required this.userId,
    required this.type,
    required this.amount,
    required this.purchasePrice,
    required this.purchaseDate,
    DateTime? createdAt,
    this.karat,
  }) : createdAt = createdAt ?? DateTime.now();

  String get displayName {
    if (type == CurrencyType.BILEZIK && karat != null) {
      return '$karat Ayar Bilezik';
    }
    return type.displayName;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'type': type.name,
      'amount': amount,
      'purchasePrice': purchasePrice,
      'purchaseDate': purchaseDate.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'karat': karat,
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
      karat: map['karat'],
    );
  }

  // Calculates the current value of the asset
  double getCurrentValue(Map<String, dynamic> currencies) {
    if (type == CurrencyType.BILEZIK && karat != null) {
      final refType = karat == '14' ? CurrencyType.AYAR14 : CurrencyType.AYAR22;
      final currentRate = currencies[refType.name];
      if (currentRate != null) {
        return amount * currentRate.satis;
      }
      return 0;
    } else {
      final currentRate = currencies[type.name];
      if (currentRate != null) {
        return amount * currentRate.satis;
      }
      return 0;
    }
  }

  // Calculates profit/loss
  double getProfitLoss(Map<String, dynamic> currencies) {
    double currentValue = getCurrentValue(currencies);
    double initialValue = amount * purchasePrice;
    return currentValue - initialValue;
  }

  // Calculates profit/loss percentage
  double getProfitLossPercentage(Map<String, dynamic> currencies) {
    double profitLoss = getProfitLoss(currencies);
    double initialValue = amount * purchasePrice;
    return initialValue == 0 ? 0 : (profitLoss / initialValue) * 100;
  }
}
