import 'package:flutter/material.dart';
import 'package:asset_tracker_app/utils/constants/theme/constant_sizes.dart';

class CustomIcon extends StatelessWidget {
  final IconData icon;
  final double? size;
  final Color? color;

  const CustomIcon({
    super.key,
    required this.icon,
    this.size = ConstantSizes.iconXXL, // Default size
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: size,
      color: color ??
          Theme.of(context)
              .primaryColor, // Used provided color or theme's primary color
    );
  }
}
