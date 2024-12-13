import 'package:asset_tracker_app/utils/constants/theme/constant_gap_sizes.dart';
import 'package:asset_tracker_app/utils/constants/theme/constant_text_styles.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;
  final String text;

  const LoginButton({
    super.key,
    required this.onPressed,
    required this.isLoading,
    required this.text,
  });
  final double _elevation = 2.0;
  final double _indicatorSquareGapSize = 24;
  final double _loginButtonSizedBoxHeight = 48;
  final double _loginButtonBorderRadius = 8;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _loginButtonSizedBoxHeight,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(_loginButtonBorderRadius),
            ),
            elevation: _elevation,
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
          ),
          child: isLoading
              ? GapSize.square(
                  size: _indicatorSquareGapSize,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Text(text, style: ConstantTextStyles.buttonText)),
    );
  }
}
