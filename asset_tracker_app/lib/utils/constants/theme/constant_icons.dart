import 'package:asset_tracker_app/utils/constants/theme/constant_sizes.dart';
import 'package:flutter/material.dart';

class ConstantIcons {
  static Icon getSplashScreenIcon(BuildContext context) {
    return Icon(
      Icons.inventory,
      size: ConstantSizes.iconXXXL,
      color: Theme.of(context).primaryColor,
    );
  }

  static Icon getOnboardPagesIcons(IconData icon, BuildContext context) {
    return Icon(
      icon,
      size: ConstantSizes.iconXXXL,
      color: Theme.of(context).primaryColor,
    );
  }

  static Icon getLoginPageIcon(BuildContext context) {
    return Icon(
      Icons.inventory,
      size: ConstantSizes.iconXXL,
      color: Theme.of(context).primaryColor,
    );
  }
}
