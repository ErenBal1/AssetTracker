abstract class HaremAltinState {}

class HaremAltinDataInitial extends HaremAltinState {}

class HaremAltinDataLoading extends HaremAltinState {}

class HaremAltinDataLoaded extends HaremAltinState {
  final Map<String, dynamic> data;
  final Map<String, dynamic> previousData;

  HaremAltinDataLoaded({
    required this.data,
    required this.previousData,
  });
}

class HaremAltinDataError extends HaremAltinState {
  final String message;
  HaremAltinDataError(this.message);
}
