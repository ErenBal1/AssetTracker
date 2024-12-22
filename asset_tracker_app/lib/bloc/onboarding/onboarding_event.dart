import 'package:equatable/equatable.dart';

abstract class OnboardingEvent extends Equatable {
  const OnboardingEvent();

  @override
  List<Object> get props => [];
}

class PageChangeRequested extends OnboardingEvent {
  final int pageIndex;
  final int totalPages;

  const PageChangeRequested({
    required this.pageIndex,
    required this.totalPages,
  });

  @override
  List<Object> get props => [pageIndex, totalPages];
}

class NextButtonPressed extends OnboardingEvent {
  final int currentPage;
  final int totalPages;

  const NextButtonPressed({
    required this.currentPage,
    required this.totalPages,
  });

  @override
  List<Object> get props => [currentPage, totalPages];
}
