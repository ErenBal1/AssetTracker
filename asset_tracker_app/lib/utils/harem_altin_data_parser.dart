import 'dart:convert';

import 'package:asset_tracker_app/services/web_socket_service.dart';

class HaremAltinDataParser implements IWebSocketDataParser {
  @override
  Map<String, dynamic>? parseData(String data) {
    try {
      if (!data.startsWith('42["price_changed"')) return null;

      String jsonStr = data.substring(data.indexOf(',') + 1);
      jsonStr = jsonStr.substring(0, jsonStr.length - 1);

      Map<String, dynamic> parsedData = json.decode(jsonStr);
      return parsedData['data'];
    } catch (e) {
      _logError('Data parsing error: $e');
      return null;
    }
  }

  void _logError(String message) {
    print(message);
  }
}
