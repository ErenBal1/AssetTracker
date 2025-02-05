import 'package:asset_tracker_app/models/harem_altin_currency_data_model.dart';
import 'package:asset_tracker_app/utils/enums/currency_type_enum.dart';

class HaremAltinDataModel {
  final Map<String, CurrencyData> currencies;
  final DateTime timestamp;

  HaremAltinDataModel({
    required this.currencies,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  factory HaremAltinDataModel.fromJson(Map<String, dynamic> json) {
    final currencies = <String, CurrencyData>{};

    json.forEach((code, data) {
      currencies[code] = CurrencyData.fromJson(code, data);
    });

    return HaremAltinDataModel(
      currencies: currencies,
      timestamp: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    currencies.forEach((key, value) {
      data[key] = value.toJson();
    });
    return data;
  }

  List<CurrencyData> get sortedCurrencies {
    final currencyList = Map<String, CurrencyData>.from(currencies);
    final result = <CurrencyData>[];

    final priorityOrder = [
      CurrencyType.ALTIN,
      CurrencyType.USDTRY,
      CurrencyType.EURTRY,
      CurrencyType.ONS,
      CurrencyType.GBPTRY,
      CurrencyType.KULCEALTIN,
      CurrencyType.CEYREK_YENI,
      CurrencyType.YARIM_YENI,
      CurrencyType.TEK_YENI,
      CurrencyType.ATA_YENI,
      CurrencyType.ATA5_YENI,
      CurrencyType.GUMUSTRY,
      CurrencyType.AYAR22,
      CurrencyType.AYAR14,
      CurrencyType.CEYREK_ESKI,
      CurrencyType.YARIM_ESKI,
      CurrencyType.TEK_ESKI,
      CurrencyType.ATA_ESKI,
      CurrencyType.ATA5_ESKI,
      CurrencyType.GREMESE_YENI,
      CurrencyType.GREMESE_ESKI,
      CurrencyType.CHFTRY,
      CurrencyType.USDPURE,
      CurrencyType.EURUSD,
      CurrencyType.USDKG,
      CurrencyType.EURKG,
      CurrencyType.XAUXAG,
      CurrencyType.CADTRY,
      CurrencyType.AUDTRY,
      CurrencyType.JPYTRY,
      CurrencyType.SARTRY,
      CurrencyType.AUDUSD,
      CurrencyType.SEKTRY,
      CurrencyType.DKKTRY,
      CurrencyType.NOKTRY,
      CurrencyType.USDJPY,
      CurrencyType.XAGUSD,
      CurrencyType.GUMUSUSD,
    ];

    // Önce priority sırasına göre ekle
    for (var currencyType in priorityOrder) {
      final currencyKey = currencyType.name;
      if (currencyList.containsKey(currencyKey)) {
        result.add(currencyList[currencyKey]!);
        currencyList.remove(currencyKey);
      }
    }

    // Kalan varsa alfabetik sıraya göre ekle
    if (currencyList.isNotEmpty) {
      final remaining = currencyList.values.toList()
        ..sort((a, b) => a.displayName.compareTo(b.displayName));
      result.addAll(remaining);
    }

    return result;
  }
}
