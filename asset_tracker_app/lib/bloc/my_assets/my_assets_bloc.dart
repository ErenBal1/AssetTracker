import 'dart:async';
import 'package:asset_tracker_app/bloc/harem_altin_service/harem_altin_bloc.dart';
import 'package:asset_tracker_app/bloc/harem_altin_service/harem_altin_state.dart';
import 'package:asset_tracker_app/bloc/my_assets/my_assets_event.dart';
import 'package:asset_tracker_app/bloc/my_assets/my_assets_state.dart';
import 'package:asset_tracker_app/models/user_asset.dart';
import 'package:asset_tracker_app/repositories/user_asset_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyAssetsBloc extends Bloc<MyAssetsEvent, MyAssetsState> {
  final UserAssetRepository _userAssetRepository;
  final HaremAltinBloc _haremAltinBloc;
  StreamSubscription? _assetsSubscription;
  StreamSubscription? _ratesSubscription;

  MyAssetsBloc({
    required UserAssetRepository userAssetRepository,
    required HaremAltinBloc haremAltinBloc,
  })  : _userAssetRepository = userAssetRepository,
        _haremAltinBloc = haremAltinBloc,
        super(MyAssetsInitial()) {
    on<LoadUserAssets>(_onLoadUserAssets, transformer: (events, mapper) {
      return events.asyncExpand(mapper);
    });
  }

  void _onLoadUserAssets(
    LoadUserAssets event,
    Emitter<MyAssetsState> emit,
  ) {
    emit(MyAssetsLoading());

    // Eğer mevcut abonelikler varsa iptal et
    _assetsSubscription?.cancel();
    _ratesSubscription?.cancel();

    // Stream dönüştürücü (StreamTransformer) oluştur
    final transformer =
        StreamTransformer<List<UserAsset>, MyAssetsState>.fromHandlers(
      handleData: (data, sink) {
        if (_haremAltinBloc.state is HaremAltinDataLoaded) {
          final rates = (_haremAltinBloc.state as HaremAltinDataLoaded)
              .currentData
              .currencies;
          sink.add(MyAssetsLoaded(assets: data, currentRates: rates));
        } else {}
      },
      handleError: (error, stackTrace, sink) {
        sink.add(MyAssetsError(error.toString()));
      },
    );

    // UserAssets stream'ini dinle
    _assetsSubscription =
        _userAssetRepository.getUserAssets().transform(transformer).listen(
      (state) {
        if (!emit.isDone) {
          emit(state);
        }
      },
    );

    // HaremAltinBloc'u dinleme
    _ratesSubscription = _haremAltinBloc.stream.listen((ratesState) {
      if (ratesState is HaremAltinDataLoaded &&
          state is MyAssetsLoaded &&
          !emit.isDone) {
        final currentAssets = (state as MyAssetsLoaded).assets;
        emit(MyAssetsLoaded(
          assets: currentAssets,
          currentRates: ratesState.currentData.currencies,
        ));
      }
    });
  }

  @override
  Future<void> close() {
    _assetsSubscription?.cancel();
    _ratesSubscription?.cancel();
    return super.close();
  }
}
