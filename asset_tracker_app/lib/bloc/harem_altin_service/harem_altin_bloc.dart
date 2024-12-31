import 'dart:async';

import 'package:asset_tracker_app/bloc/harem_altin_service/harem_altin_event.dart';
import 'package:asset_tracker_app/bloc/harem_altin_service/harem_altin_state.dart';
import 'package:asset_tracker_app/localization/strings.dart';
import 'package:asset_tracker_app/models/harem_altin_data_model.dart';
import 'package:asset_tracker_app/services/websocket/web_socket_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HaremAltinBloc extends Bloc<HaremAltinEvent, HaremAltinState> {
  final WebSocketService _webSocketService = WebSocketService();
  StreamSubscription? _webSocketSubscription;
  HaremAltinDataModel? previousMarketData;
  Timer? _reconnectTimer;
  final Duration _reconnectTimeDuration = const Duration(milliseconds: 500);

  HaremAltinBloc() : super(HaremAltinDataLoading()) {
    on<ConnectToWebSocket>((event, emit) async {
      emit(HaremAltinDataLoading());

      try {
        await _webSocketService.connect();
        await _setupStreamSubscription(emit);

        final initialData = await _webSocketService.getData();
        if (initialData != null && !emit.isDone) {
          final marketData = HaremAltinDataModel.fromJson(initialData);
          emit(HaremAltinDataLoaded(
            currentData: marketData,
            previousData: previousMarketData,
          ));
          previousMarketData = marketData;
        }
      } catch (e) {
        if (!emit.isDone) {
          emit(HaremAltinDataError(e.toString()));
        }
        _scheduleReconnect();
      }
    });

    on<NewHaremAltinData>((event, emit) {
      try {
        final marketData = HaremAltinDataModel.fromJson(event.data);
        emit(HaremAltinDataLoaded(
          currentData: marketData,
          previousData: previousMarketData,
        ));
        previousMarketData = marketData;
      } catch (e) {
        emit(HaremAltinDataError(
            '${LocalStrings.haremAltinDataConversionError}$e'));
        _scheduleReconnect();
      }
    });

    on<HaremAltinError>((event, emit) {
      emit(HaremAltinDataError(event.message));
      _scheduleReconnect();
    });

    on<DisconnectWebSocket>((event, emit) async {
      _reconnectTimer?.cancel();
      await _webSocketSubscription?.cancel();
      _webSocketService.disconnect();
      previousMarketData = null;
      emit(HaremAltinDataInitial());
    });
  }

  Future<void> _setupStreamSubscription(Emitter<HaremAltinState> emit) async {
    await _webSocketSubscription?.cancel();

    _webSocketSubscription = _webSocketService.dataStream.listen(
      (data) {
        if (!isClosed) {
          add(NewHaremAltinData(data));
        }
      },
      onError: (error) {
        if (!isClosed) {
          add(HaremAltinError(error.toString()));
        }
      },
      cancelOnError: false,
    );
  }

  void _scheduleReconnect() {
    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(_reconnectTimeDuration, () {
      if (!isClosed) {
        add(ConnectToWebSocket());
      }
    });
  }

  @override
  Future<void> close() async {
    _reconnectTimer?.cancel();
    await _webSocketSubscription?.cancel();
    _webSocketService.disconnect();
    return super.close();
  }
}

class HaremAltinError extends HaremAltinEvent {
  final String message;
  HaremAltinError(this.message);
}
