import 'package:asset_tracker_app/utils/constants/theme/constant_icons.dart';
import 'package:asset_tracker_app/utils/constants/theme/constant_paddings.dart';
import 'package:asset_tracker_app/utils/constants/theme/constant_gap_sizes.dart';
import 'package:asset_tracker_app/utils/constants/theme/constant_texts_and_styles.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const OnboardingPage({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: ConstantPaddings.allXXL,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ConstantIcons.getOnboardPagesIcons(icon, context),
            const GapSize.mediumLarge(),
            ConstantTextsAndStyles.getOnboardPageTitle(title),
            const GapSize.small(),
            ConstantTextsAndStyles.getOnboardPageDescription(description),
          ],
        ),
      ),
    );
  }
}
