import 'package:asset_tracker_app/localization/strings.dart';
import 'package:asset_tracker_app/utils/constants/app_routes_constants.dart';
import 'package:asset_tracker_app/utils/constants/controllers.dart';
import 'package:asset_tracker_app/utils/constants/onboarding_page_list.dart';
import 'package:flutter/material.dart';

mixin OnboardScreenMixin<T extends StatefulWidget> on State<T> {
  int currentPage = 0;
  final onboardingData = OnboardingData();

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

  void onNextPressed() {
    if (currentPage < onboardingData.pages.length - 1) {
      navigateToNextPage();
    } else {
      navigateToLogin();
    }
  }

  void navigateToNextPage() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void navigateToLogin() {
    Navigator.pushReplacementNamed(context, ToScreen.loginPage);
  }

  String get buttonText => currentPage == onboardingData.pages.length - 1
      ? LocalStrings.getStartedButton
      : LocalStrings.nextButton;
}
