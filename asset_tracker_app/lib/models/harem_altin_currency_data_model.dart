import 'package:asset_tracker_app/utils/enums/currency_type_enum.dart';

class CurrencyData {
  final String code;
  final double alis;
  final double satis;
  final String tarih;

  CurrencyData({
    required this.code,
    required this.alis,
    required this.satis,
    required this.tarih,
  });

  factory CurrencyData.fromJson(String code, Map<String, dynamic> json) {
    return CurrencyData(
      code: code,
      alis: double.tryParse(json['alis']?.toString() ?? '0') ?? 0,
      satis: double.tryParse(json['satis']?.toString() ?? '0') ?? 0,
      tarih: json['tarih']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'code': code,
        'alis': alis,
        'satis': satis,
      };

  bool hasIncreasedFrom(CurrencyData? previous, String type) {
    if (previous == null) return false;

    final currentValue = type == 'alis' ? alis : satis;
    final previousValue = type == 'alis' ? previous.alis : previous.satis;

    return currentValue > previousValue;
  }

  bool hasDecreasedFrom(CurrencyData? previous, String type) {
    if (previous == null) return false;

    final currentValue = type == 'alis' ? alis : satis;
    final previousValue = type == 'alis' ? previous.alis : previous.satis;

    return currentValue < previousValue;
  }

  CurrencyType get currencyType {
    // Özel dolar tipleri için özel CurrencyType'lar
    if (code == 'USDTRY') return CurrencyType.USDTRY;
    if (code == 'USDPURE') return CurrencyType.USDPURE;
    if (code == 'USDJPY') return CurrencyType.USDJPY;
    if (code == 'AUDUSD') return CurrencyType.AUDUSD;
    if (code == 'USDKG') return CurrencyType.USDKG;
    if (code == 'EURUSD') return CurrencyType.EURUSD;

    // Diğer para birimleri için normal eşleştirme
    return CurrencyType.values.firstWhere(
      (e) => e.name == code,
      orElse: () => CurrencyType.USDTRY,
    );
  }

  String get displayName => currencyType.displayName;
  bool get isGold => currencyType.isGold;
}
