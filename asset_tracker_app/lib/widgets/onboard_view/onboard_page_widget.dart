import 'package:asset_tracker_app/utils/constants/theme/constant_paddings.dart';
import 'package:asset_tracker_app/utils/constants/theme/constant_gap_sizes.dart';
import 'package:asset_tracker_app/utils/constants/theme/constant_text_styles.dart';
import 'package:asset_tracker_app/widgets/custom_icon_widget.dart';
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
            CustomIcon(icon: icon),
            const GapSize.mediumLarge(),
            Text(
              title,
              style: ConstantTextStyles.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const GapSize.small(),
            Text(
              description,
              style: ConstantTextStyles.bodyLargeGrey,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
