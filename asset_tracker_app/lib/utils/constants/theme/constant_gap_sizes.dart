import 'package:asset_tracker_app/utils/constants/theme/constant_sizes.dart';
import 'package:flutter/material.dart';

class GapSize extends SizedBox {
  const GapSize.small({super.key}) : super(height: ConstantSizes.gapSmall);

  const GapSize.medium({super.key}) : super(height: ConstantSizes.gapMedium);

  const GapSize.mediumLarge({super.key})
      : super(height: ConstantSizes.gapLarge);

  const GapSize.big({super.key}) : super(height: ConstantSizes.gapXL);

  ///square sized box with optional child
  const GapSize.square({
    super.key,
    required double size,
    super.child,
  }) : super(height: size, width: size);

  ///custom sized box
  const GapSize.custom({
    super.key,
    super.height,
    super.width,
  });
}
