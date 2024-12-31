import 'package:asset_tracker_app/models/harem_altin_data_model.dart';

abstract class HaremAltinState {}

class HaremAltinDataInitial extends HaremAltinState {}

class HaremAltinDataLoading extends HaremAltinState {}

class HaremAltinDataLoaded extends HaremAltinState {
  final HaremAltinDataModel currentData;
  final HaremAltinDataModel? previousData;

  HaremAltinDataLoaded({
    required this.currentData,
    this.previousData,
  });
}

class HaremAltinDataError extends HaremAltinState {
  final String message;
  HaremAltinDataError(this.message);
}
