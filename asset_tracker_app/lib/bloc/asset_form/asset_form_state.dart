class AssetFormState {
  final bool isSubmitting;
  final bool isSuccess;
  final String? error;

  AssetFormState({
    this.isSubmitting = false,
    this.isSuccess = false,
    this.error,
  });

  AssetFormState copyWith({
    bool? isSubmitting,
    bool? isSuccess,
    String? error,
  }) {
    return AssetFormState(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error,
    );
  }
}
