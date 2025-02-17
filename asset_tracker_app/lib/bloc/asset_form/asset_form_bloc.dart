import 'package:asset_tracker_app/bloc/asset_form/asset_form_event.dart';
import 'package:asset_tracker_app/bloc/asset_form/asset_form_state.dart';
import 'package:asset_tracker_app/models/user_asset.dart';
import 'package:asset_tracker_app/repositories/user_asset_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AssetFormBloc extends Bloc<AssetFormEvent, AssetFormState> {
  final UserAssetRepository _userAssetRepository;

  AssetFormBloc({required UserAssetRepository userAssetRepository})
      : _userAssetRepository = userAssetRepository,
        super(AssetFormState()) {
    on<AssetSubmitted>(_onSubmitted);
  }

  Future<void> _onSubmitted(
    AssetSubmitted event,
    Emitter<AssetFormState> emit,
  ) async {
    emit(state.copyWith(isSubmitting: true));

    try {
      final asset = UserAsset(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: FirebaseAuth.instance.currentUser!.uid,
        type: event.type,
        amount: event.amount,
        purchasePrice: event.purchasePrice,
        purchaseDate: event.purchaseDate,
      );

      await _userAssetRepository.addUserAsset(asset);
      emit(state.copyWith(isSuccess: true));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }
}
