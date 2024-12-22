import 'package:asset_tracker_app/bloc/onboarding/onboarding_bloc.dart';
import 'package:asset_tracker_app/bloc/onboarding/onboarding_event.dart';
import 'package:asset_tracker_app/bloc/onboarding/onboarding_state.dart';
import 'package:asset_tracker_app/localization/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constants/controllers.dart';

mixin OnboardScreenMixin<T extends StatefulWidget> on State<T> {
  int currentPage = 0;
  final int _nextPageDurationTime = 300;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void setPageIndex(int index) {
    setState(() {
      currentPage = index;
    });
  }

  void navigateToNextPage() {
    pageController.nextPage(
      duration: Duration(milliseconds: _nextPageDurationTime),
      curve: Curves.easeInOut,
    );
  }

  void handleOnboardingButtonPress(
      BuildContext context, dynamic onboardingData) {
    if (currentPage < onboardingData.pages.length - 1) {
      navigateToNextPage();
    }
    context.read<OnboardingBloc>().add(
          NextButtonPressed(
            currentPage: currentPage,
            totalPages: onboardingData.pages.length,
          ),
        );
  }

  String getButtonText(OnboardingState state) {
    return state is OnboardingPageChanged &&
            state.currentPage == state.totalPages - 1
        ? LocalStrings.getStartedButton
        : LocalStrings.nextButton;
  }
}
