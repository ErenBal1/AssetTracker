abstract class HaremAltinEvent {}

class ConnectToWebSocket extends HaremAltinEvent {}

class DisconnectFromWebSocket extends HaremAltinEvent {}

class NewHaremAltinData extends HaremAltinEvent {
  final Map<String, dynamic> data;
  NewHaremAltinData(this.data);
}
