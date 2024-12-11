import 'package:asset_tracker_app/utils/constants/theme/constant_icons.dart';
import 'package:asset_tracker_app/utils/constants/theme/constant_texts_and_styles.dart';
import 'package:asset_tracker_app/utils/constants/theme/constant_gap_sizes.dart';
import 'package:asset_tracker_app/utils/mixins/splash_screen_mixin.dart';
import 'package:flutter/material.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView>
    with SplashScreenMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ConstantIcons.getSplashScreenIcon(context),
            const GapSize.medium(),
            ConstantTextsAndStyles.splashAppLabelText
          ],
        ),
      ),
    );
  }
}
