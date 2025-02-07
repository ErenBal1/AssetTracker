import 'package:asset_tracker_app/models/harem_altin_currency_data_model.dart';
import 'package:asset_tracker_app/utils/constants/asset_priority_list.dart';

class HaremAltinDataModel {
  final Map<String, CurrencyData> currencies;
  final DateTime timestamp;

  HaremAltinDataModel({
    required this.currencies,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  factory HaremAltinDataModel.fromJson(
    Map<String, dynamic> json, {
    HaremAltinDataModel? previousData,
  }) {
    final currencies = <String, CurrencyData>{};

    if (previousData != null) {
      currencies.addAll(previousData.currencies);
    }

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

    for (var currencyType in priorityOrder) {
      final currencyKey = currencyType.name;
      if (currencyList.containsKey(currencyKey)) {
        result.add(currencyList[currencyKey]!);
        currencyList.remove(currencyKey);
      }
    }

    if (currencyList.isNotEmpty) {
      final remaining = currencyList.values.toList()
        ..sort((a, b) => a.displayName.compareTo(b.displayName));
      result.addAll(remaining);
    }

    return result;
  }
}
