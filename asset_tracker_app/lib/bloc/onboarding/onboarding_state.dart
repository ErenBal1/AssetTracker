import 'package:equatable/equatable.dart';

abstract class OnboardingState extends Equatable {
  const OnboardingState();

  @override
  List<Object> get props => [];
}

class OnboardingInitial extends OnboardingState {}

class OnboardingPageChanged extends OnboardingState {
  final int currentPage;
  final int totalPages;

  const OnboardingPageChanged({
    required this.currentPage,
    required this.totalPages,
  });

  @override
  List<Object> get props => [currentPage, totalPages];
}

class OnboardingCompleted extends OnboardingState {}
