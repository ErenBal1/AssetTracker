import 'package:asset_tracker_app/utils/constants/controllers.dart';
import 'package:asset_tracker_app/utils/constants/theme/constant_paddings.dart';
import 'package:asset_tracker_app/utils/mixins/onboard_screen_mixin.dart';
import 'package:asset_tracker_app/widgets/onboard_view/dot_indicator_widget.dart';
import 'package:asset_tracker_app/widgets/onboard_view/onboard_button.dart';
import 'package:flutter/material.dart';

class OnboardingScreenView extends StatefulWidget {
  const OnboardingScreenView({super.key});

  @override
  State<OnboardingScreenView> createState() => _OnboardingScreenViewState();
}

class _OnboardingScreenViewState extends State<OnboardingScreenView>
    with OnboardScreenMixin {
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
                onPageChanged: setPageIndex,
                itemBuilder: (context, index) => onboardingData.pages[index],
              ),
            ),
            Padding(
              padding: ConstantPaddings.allM,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildDotIndicators(),
                  OnboardingButton(
                    onPressed: onNextPressed,
                    text: buttonText,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDotIndicators() {
    return Row(
      children: List.generate(
        onboardingData.pages.length,
        (index) => OnBoardingDotIndicator(
          currentPage: currentPage,
          index: index,
        ),
      ),
    );
  }
}
