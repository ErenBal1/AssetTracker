import 'package:asset_tracker_app/localization/strings.dart';
import 'package:asset_tracker_app/utils/constants/app_routes_constants.dart';
import 'package:asset_tracker_app/utils/constants/controllers.dart';
import 'package:asset_tracker_app/utils/constants/onboarding_page_list.dart';
import 'package:asset_tracker_app/widgets/onboard_view/dot_indicator_widget.dart';
import 'package:flutter/material.dart';

class OnboardingScreenView extends StatefulWidget {
  const OnboardingScreenView({super.key});

  @override
  State<OnboardingScreenView> createState() => _OnboardingScreenViewState();
}

class _OnboardingScreenViewState extends State<OnboardingScreenView> {
  int _currentPage = 0;
  final onboardingData = OnboardingData();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void _onNextPressed() {
    if (_currentPage < onboardingData.pages.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacementNamed(context, ToScreen.loginPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: pageController,
                itemCount: onboardingData.pages.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) => onboardingData.pages[index],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: List.generate(
                      onboardingData.pages.length,
                      (index) => OnBoardingDotIndicator(
                        currentPage: _currentPage,
                        index: index,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _onNextPressed,
                    child: Text(
                      _currentPage == onboardingData.pages.length - 1
                          ? LocalStrings.getStartedButton
                          : LocalStrings.nextButton,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
