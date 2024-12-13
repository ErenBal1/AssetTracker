import 'package:asset_tracker_app/localization/strings.dart';
import 'package:asset_tracker_app/utils/constants/theme/constant_sizes.dart';
import 'package:asset_tracker_app/utils/constants/theme/constant_text_styles.dart';
import 'package:asset_tracker_app/utils/constants/theme/constant_gap_sizes.dart';
import 'package:asset_tracker_app/utils/mixins/splash_screen_mixin.dart';
import 'package:asset_tracker_app/widgets/custom_icon_widget.dart';
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
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomIcon(icon: Icons.inventory, size: ConstantSizes.iconXXXL),
            GapSize.medium(),
            Text(
              LocalStrings.appLabel,
              style: ConstantTextStyles.headlineLarge,
            )
          ],
        ),
      ),
    );
  }
}
