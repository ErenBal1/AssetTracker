import 'package:asset_tracker_app/view/home_view.dart';
import 'package:asset_tracker_app/view/login_screen_view.dart';
import 'package:asset_tracker_app/view/onboard_view.dart';
import 'package:flutter/material.dart';

class ToScreen {
  static const String loginPage = '/login';
  static const String homePage = '/home';
  static const String onboardPage = '/onboarding';
}

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> routes = {
    ToScreen.onboardPage: (context) => const OnboardingScreenView(),
    ToScreen.loginPage: (context) => const LoginScreenView(),
    ToScreen.homePage: (context) => HomePageView(),
  };
}
