import 'package:asset_tracker_app/utils/constants/app_size_constants.dart';
import 'package:flutter/material.dart';

class OnboardingButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

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
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 12,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 2,
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: AppSize.textLarge,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
