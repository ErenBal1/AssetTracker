import 'package:flutter/material.dart';

class EmptySize extends SizedBox {
  const EmptySize.small({super.key}) : super(height: 16);

  const EmptySize.medium({super.key}) : super(height: 24);

  const EmptySize.mediumLarge({super.key}) : super(height: 32);

  const EmptySize.big({super.key}) : super(height: 48);

  const EmptySize.square({
    super.key,
    required double size,
    super.child,
  }) : super(height: size, width: size);

  //belki custom lazım olur
  const EmptySize.custom({
    super.key,
    super.height,
    super.width,
  });
}
