import 'package:asset_tracker_app/utils/constants/app_routes_constants.dart';
import 'package:flutter/material.dart';

mixin SplashScreenMixin<T extends StatefulWidget> on State<T> {
  final int _splashDurationValue = 3;
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(Duration(seconds: _splashDurationValue));
    if (!mounted) return;

    final bool isFirstTime = await _isFirstTimeUser();
    if (!mounted) return;

    if (isFirstTime) {
      Navigator.pushReplacementNamed(context, ToScreen.onboardPage);
    } else {
      Navigator.pushReplacementNamed(context, ToScreen.loginPage);
    }
  }

  Future<bool> _isFirstTimeUser() async {
    //
    return true;
  }
}
