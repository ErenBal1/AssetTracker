import 'package:flutter_bloc/flutter_bloc.dart';
import 'onboarding_event.dart';
import 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc() : super(OnboardingInitial()) {
    on<PageChangeRequested>((event, emit) {
      emit(OnboardingPageChanged(
        currentPage: event.pageIndex,
        totalPages: event.totalPages,
      ));
    });

    on<NextButtonPressed>((event, emit) {
      if (event.currentPage < event.totalPages - 1) {
        emit(OnboardingPageChanged(
          currentPage: event.currentPage,
          totalPages: event.totalPages,
        ));
      } else {
        emit(OnboardingCompleted());
      }
    });
  }
}
