import 'package:asset_tracker_app/localization/strings.dart';
import 'package:asset_tracker_app/utils/constants/app_routes_constants.dart';
import 'package:asset_tracker_app/utils/mixins/onboard_screen_mixin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:asset_tracker_app/bloc/onboarding/onboarding_bloc.dart';
import 'package:asset_tracker_app/bloc/onboarding/onboarding_event.dart';
import 'package:asset_tracker_app/bloc/onboarding/onboarding_state.dart';
import 'package:asset_tracker_app/utils/constants/controllers.dart';
import 'package:asset_tracker_app/utils/constants/theme/constant_paddings.dart';
import 'package:asset_tracker_app/utils/constants/onboarding_page_list.dart';
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
  final onboardingData = OnboardingData();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingBloc(),
      child: BlocConsumer<OnboardingBloc, OnboardingState>(
        listener: (context, state) {
          if (state is OnboardingCompleted) {
            Navigator.pushReplacementNamed(context, ToScreen.loginPage);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: pageController,
                      itemCount: onboardingData.pages.length,
                      onPageChanged: (index) {
                        setPageIndex(index);
                        context.read<OnboardingBloc>().add(
                              PageChangeRequested(
                                pageIndex: index,
                                totalPages: onboardingData.pages.length,
                              ),
                            );
                      },
                      itemBuilder: (context, index) =>
                          onboardingData.pages[index],
                    ),
                  ),
                  Padding(
                    padding: ConstantPaddings.allM,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildDotIndicators(),
                        OnboardingButton(
                          onPressed: () {
                            if (currentPage < onboardingData.pages.length - 1) {
                              navigateToNextPage();
                            }
                            context.read<OnboardingBloc>().add(
                                  NextButtonPressed(
                                    currentPage: currentPage,
                                    totalPages: onboardingData.pages.length,
                                  ),
                                );
                          },
                          text: state is OnboardingPageChanged &&
                                  state.currentPage == state.totalPages - 1
                              ? LocalStrings.getStartedButton
                              : LocalStrings.nextButton,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
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
