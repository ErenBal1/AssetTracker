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
    '/onboarding': (context) => const OnboardingScreenView(),
    '/login': (context) => const LoginScreenView(),
    '/home': (context) => HomePageView(),
  };
}
