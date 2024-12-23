import 'package:asset_tracker_app/bloc/harem_altin_service/harem_altin_event.dart';
import 'package:asset_tracker_app/bloc/harem_altin_service/harem_altin_state.dart';
import 'package:asset_tracker_app/services/web_socket_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HaremAltinBloc extends Bloc<HaremAltinEvent, HaremAltinState> {
  final WebSocketService _webSocketService = WebSocketService();
  Map<String, dynamic> previousData = {};

  HaremAltinBloc() : super(HaremAltinDataLoading()) {
    on<ConnectToWebSocket>((event, emit) async {
      final newData = await _webSocketService.getData();
      if (newData != null) {
        emit(HaremAltinDataLoaded(
          data: newData,
          previousData: previousData,
        ));
        previousData = Map.from(newData);
      }
    });

    on<DisconnectWebSocket>((event, emit) {
      _webSocketService.disconnect();
      emit(HaremAltinDataInitial());
    });
  }
}
