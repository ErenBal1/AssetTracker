import 'dart:async';
import 'package:asset_tracker_app/models/web_socket_config.dart';
import 'package:asset_tracker_app/utils/constants/constant_paths.dart';
import 'package:asset_tracker_app/utils/harem_altin_data_parser.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

abstract class IWebSocketService {
  Future<Map<String, dynamic>?> getData();
  Future<void> connect();
  void disconnect();
}

abstract class IWebSocketDataParser {
  Map<String, dynamic>? parseData(String data);
}

class WebSocketService implements IWebSocketService {
  final WebSocketConfig _config;
  final IWebSocketDataParser _dataParser;
  WebSocketChannel? _channel;
  StreamController<Map<String, dynamic>>? _streamController;
  Map<String, dynamic>? _lastData;

  WebSocketService._({
    required WebSocketConfig config,
    required IWebSocketDataParser dataParser,
  })  : _config = config,
        _dataParser = dataParser;

  static final WebSocketService _instance = WebSocketService._(
    config: const WebSocketConfig(url: ConstantPaths.wsUrl),
    dataParser: HaremAltinDataParser(),
  );

  factory WebSocketService() => _instance;

  @override
  Future<Map<String, dynamic>?> getData() async {
    if (_channel == null) {
      await connect();
      await Future.delayed(_config.reconnectDelay);
    }
    return _lastData;
  }

  @override
  Future<void> connect() async {
    try {
      await _initializeConnection();
      _setupStreamListener();
    } catch (e) {
      _handleConnectionError(e);
    }
  }

  @override
  void disconnect() {
    _closeConnection();
    _resetState();
  }

  Future<void> _initializeConnection() async {
    _channel = WebSocketChannel.connect(Uri.parse(_config.url));
    _streamController = StreamController<Map<String, dynamic>>.broadcast();
  }

  void _setupStreamListener() {
    _channel?.stream.listen(
      _handleIncomingData,
      onError: _handleStreamError,
      onDone: _handleConnectionClosed,
    );
  }

  void _handleIncomingData(dynamic data) {
    final stringData = data.toString();

    if (stringData.startsWith(_config.initialMessage)) {
      _sendResponse();
      return;
    }

    final parsedData = _dataParser.parseData(stringData);
    if (parsedData != null) {
      _lastData = parsedData;
    }
  }

  void _sendResponse() {
    _channel?.sink.add(_config.responseMessage);
  }

  void _handleStreamError(error) {
    _logError('WebSocket stream error: $error');
  }

  void _handleConnectionClosed() {
    _logError('WebSocket connection closed');
  }

  void _handleConnectionError(dynamic error) {
    _logError('WebSocket connection error: $error');
  }

  void _closeConnection() {
    _channel?.sink.close();
    _streamController?.close();
  }

  void _resetState() {
    _channel = null;
    _streamController = null;
  }

  void _logError(String message) {
    print(message);
  }
}
