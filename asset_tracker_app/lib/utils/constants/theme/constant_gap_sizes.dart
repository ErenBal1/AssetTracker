import 'package:flutter/material.dart';

class GapSize extends SizedBox {
  const GapSize.small({super.key}) : super(height: 16);

  const GapSize.medium({super.key}) : super(height: 24);

  const GapSize.mediumLarge({super.key}) : super(height: 32);

  const GapSize.big({super.key}) : super(height: 48);

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
