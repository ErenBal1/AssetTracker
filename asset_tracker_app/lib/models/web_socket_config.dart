class WebSocketConfig {
  final String url;
  final Duration reconnectDelay = const Duration(milliseconds: 500);
  final String initialMessage = '0';
  final String responseMessage = '40';

  const WebSocketConfig({
    required this.url,
  });
}
