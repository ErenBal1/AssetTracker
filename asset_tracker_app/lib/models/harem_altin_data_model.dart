import 'package:asset_tracker_app/models/harem_altin_currency_data_model.dart';

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
    final list = currencies.values.toList();
    list.sort((a, b) => a.code.compareTo(b.code));
    return list;
  }
}
