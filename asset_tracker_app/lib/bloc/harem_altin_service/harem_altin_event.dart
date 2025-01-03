abstract class HaremAltinEvent {}

class ConnectToWebSocket extends HaremAltinEvent {}

class DisconnectWebSocket extends HaremAltinEvent {}

class NewHaremAltinData extends HaremAltinEvent {
  final Map<String, dynamic> data;
  NewHaremAltinData(this.data);
}
