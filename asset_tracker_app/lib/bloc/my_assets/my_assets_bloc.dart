import 'dart:async';
import 'package:asset_tracker_app/bloc/harem_altin_service/harem_altin_bloc.dart';
import 'package:asset_tracker_app/bloc/harem_altin_service/harem_altin_state.dart';
import 'package:asset_tracker_app/bloc/my_assets/my_assets_event.dart';
import 'package:asset_tracker_app/bloc/my_assets/my_assets_state.dart';
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
    on<LoadUserAssets>(_onLoadUserAssets);
    on<DeleteUserAsset>(_onDeleteUserAsset);
  }

  Future<void> _onLoadUserAssets(
    LoadUserAssets event,
    Emitter<MyAssetsState> emit,
  ) async {
    emit(MyAssetsLoading());

    _assetsSubscription?.cancel();
    _ratesSubscription?.cancel();

    try {
      if (_haremAltinBloc.state is HaremAltinDataLoaded) {
        final currentRates = (_haremAltinBloc.state as HaremAltinDataLoaded)
            .currentData
            .currencies;

        final assets = await _userAssetRepository.getUserAssets().first;
        emit(MyAssetsLoaded(assets: assets, currentRates: currentRates));
      }

      _assetsSubscription = _userAssetRepository.getUserAssets().listen(
        (assets) {
          if (_haremAltinBloc.state is HaremAltinDataLoaded && !emit.isDone) {
            final rates = (_haremAltinBloc.state as HaremAltinDataLoaded)
                .currentData
                .currencies;
            emit(MyAssetsLoaded(assets: assets, currentRates: rates));
          }
        },
        onError: (error) {
          if (!emit.isDone) {
            emit(MyAssetsError(error.toString()));
          }
        },
      );

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
    } catch (e) {
      if (!emit.isDone) {
        emit(MyAssetsError(e.toString()));
      }
    }
  }

  Future<void> _onDeleteUserAsset(
    DeleteUserAsset event,
    Emitter<MyAssetsState> emit,
  ) async {
    try {
      await _userAssetRepository.deleteAsset(event.assetId);
    } catch (e) {
      emit(MyAssetsError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _assetsSubscription?.cancel();
    _ratesSubscription?.cancel();
    return super.close();
  }
}
