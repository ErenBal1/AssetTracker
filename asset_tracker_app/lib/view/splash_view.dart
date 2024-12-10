import 'package:asset_tracker_app/localization/strings.dart';
import 'package:asset_tracker_app/utils/constants/app_routes_constants.dart';
import 'package:asset_tracker_app/utils/constants/empty_size.dart';
import 'package:flutter/material.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  final int splashDurationValue = 3;
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(Duration(seconds: splashDurationValue));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inventory,
              size: 100,
              color: Theme.of(context).primaryColor,
            ),
            const EmptySize.medium(),
            const Text(
              LocalStrings.appLabel,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
