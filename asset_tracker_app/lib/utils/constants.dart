import 'package:asset_tracker_app/view/home_view.dart';
import 'package:asset_tracker_app/view/login_screen_view.dart';
import 'package:asset_tracker_app/view/onboard_view.dart';
import 'package:asset_tracker_app/widgets/onboard_view/onboard_page_widget.dart';
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

class BackgroundColors {}

//OnBoard Page
class OnboardingPages {
  static List<OnboardingPage> pages = [
    const OnboardingPage(
      title: 'Track Your Assets',
      description: 'Easily manage and track all your assets in one place',
      icon: Icons.track_changes,
    ),
    const OnboardingPage(
      title: 'Real-time Display',
      description:
          'View the status of your assets and how much profit or loss you have made',
      icon: Icons.update,
    ),
    const OnboardingPage(
      title: 'Detailed Analytics',
      description: 'View comprehensive reports and analytics',
      icon: Icons.analytics,
    ),
  ];
}

final PageController pageController = PageController();
