import 'dart:async';
import 'package:asset_tracker_app/localization/strings.dart';
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
  bool _isConnecting = false;
  Timer? _reconnectTimer;
  static const int _maxReconnectAttempts = 5;
  int _reconnectAttempts = 0;

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

  Stream<Map<String, dynamic>> get dataStream {
    _streamController ??= StreamController<Map<String, dynamic>>.broadcast();
    return _streamController!.stream;
  }

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
    if (_isConnecting || _channel != null) return;

    _isConnecting = true;
    try {
      await _initializeConnection();
      _setupStreamListener();
      _reconnectAttempts = 0;
      _isConnecting = false;
    } catch (e) {
      _isConnecting = false;
      _handleConnectionError(e);
    }
  }

  @override
  void disconnect() {
    _reconnectTimer?.cancel();
    _closeConnection();
    _resetState();
  }

  Future<void> _initializeConnection() async {
    _channel = WebSocketChannel.connect(Uri.parse(_config.url));
    if (_streamController == null || _streamController!.isClosed) {
      _streamController = StreamController<Map<String, dynamic>>.broadcast();
    }
  }

  void _setupStreamListener() {
    _channel?.stream.listen(
      _handleIncomingData,
      onError: _handleStreamError,
      onDone: _handleConnectionClosed,
      cancelOnError: false,
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
      _streamController?.add(parsedData);
    }
  }

  void _sendResponse() {
    _channel?.sink.add(_config.responseMessage);
  }

  void _handleStreamError(error) {
    _logError('${LocalStrings.webSocketStreamError} $error');
    _initiateReconnect();
  }

  void _handleConnectionClosed() {
    _logError(LocalStrings.webSocketConnectionClosed);
    _initiateReconnect();
  }

  void _handleConnectionError(dynamic error) {
    _logError('${LocalStrings.webSocketConnectionError} $error');
    _initiateReconnect();
  }

  void _initiateReconnect() {
    if (_reconnectAttempts >= _maxReconnectAttempts) {
      _logError(LocalStrings.webSocketMaxReconnectionAttempts);
      return;
    }

    _reconnectTimer?.cancel();

    final delay = Duration(
        milliseconds:
            _config.reconnectDelay.inMilliseconds * (1 << _reconnectAttempts));

    _reconnectTimer = Timer(delay, () async {
      _reconnectAttempts++;
      _logError(
          '${LocalStrings.webSocketReconnectAttempts} $_reconnectAttempts');

      _closeConnection();
      _resetState();
      await connect();
    });
  }

  void _closeConnection() {
    _channel?.sink.close();
  }

  void _resetState() {
    _channel = null;
    _isConnecting = false;
  }

  void _logError(String message) {
    print(message);
  }
}
