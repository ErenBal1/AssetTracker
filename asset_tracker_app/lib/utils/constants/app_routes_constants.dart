import 'package:asset_tracker_app/view/home_view.dart';
import 'package:asset_tracker_app/view/login_screen_view.dart';
import 'package:asset_tracker_app/view/onboard_view.dart';
import 'package:asset_tracker_app/view/profile_view.dart';
import 'package:asset_tracker_app/widgets/main_wrapper.dart';
import 'package:flutter/material.dart';

class ToScreen {
  static const String loginPage = '/login';
  static const String homePage = '/home';
  static const String onboardPage = '/onboarding';
  static const String myAssetsPage = '/myAssets';
  static const String mainWrapper = '/mainWrapper';
}

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> routes = {
    ToScreen.onboardPage: (context) => const OnboardingScreenView(),
    ToScreen.loginPage: (context) => const LoginScreenView(),
    ToScreen.homePage: (context) => const HomePageView(),
    ToScreen.myAssetsPage: (context) => const ProfileView(),
    ToScreen.mainWrapper: (context) => const MainWrapper(),
  };
}
