import 'package:asset_tracker_app/utils/constants/theme/constant_paddings.dart';
import 'package:asset_tracker_app/utils/constants/theme/constant_text_styles.dart';
import 'package:flutter/material.dart';

class OnboardingButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final double _elevation = 2.0;
  final double _onBoardButtonBorderRadius = 12.0;

  const OnboardingButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: ConstantPaddings.onBoardingButtonPadding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_onBoardButtonBorderRadius),
          ),
          elevation: _elevation,
        ),
        child: Text(text, style: ConstantTextStyles.buttonText));
  }
}
