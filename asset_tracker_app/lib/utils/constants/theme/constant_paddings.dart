import 'package:flutter/material.dart';

class ConstantPaddings {
  /// Alls
  ///
  /// 4
  static const EdgeInsets allXXS = EdgeInsets.all(4);

  /// 8
  static const EdgeInsets allXS = EdgeInsets.all(8);

  /// 12
  static const EdgeInsets allS = EdgeInsets.all(12);

  /// 16
  static const EdgeInsets allM = EdgeInsets.all(16);

  /// 20
  static const EdgeInsets allL = EdgeInsets.all(20);

  /// 24
  static const EdgeInsets allXL = EdgeInsets.all(24);

  /// 32
  static const EdgeInsets allXXL = EdgeInsets.all(32);

  /// Horizontals
  ///
  /// 4
  static const EdgeInsets horizontalXXS = EdgeInsets.symmetric(horizontal: 4);

  /// 8
  static const EdgeInsets horizontalXS = EdgeInsets.symmetric(horizontal: 8);

  /// 12
  static const EdgeInsets horizontalS = EdgeInsets.symmetric(horizontal: 12);

  /// 16
  static const EdgeInsets horizontalM = EdgeInsets.symmetric(horizontal: 16);

  /// 20
  static const EdgeInsets horizontalL = EdgeInsets.symmetric(horizontal: 20);

  /// 24
  static const EdgeInsets horizontalXL = EdgeInsets.symmetric(horizontal: 24);

  /// Verticals
  ///
  /// 4
  static const EdgeInsets verticalXXS = EdgeInsets.symmetric(vertical: 4);

  /// 8
  static const EdgeInsets verticalXS = EdgeInsets.symmetric(vertical: 8);

  /// 12
  static const EdgeInsets verticalS = EdgeInsets.symmetric(vertical: 12);

  /// 16
  static const EdgeInsets verticalM = EdgeInsets.symmetric(vertical: 16);

  /// 20
  static const EdgeInsets verticalL = EdgeInsets.symmetric(vertical: 20);

  /// 24
  static const EdgeInsets verticalXL = EdgeInsets.symmetric(vertical: 24);

  static EdgeInsets custom({
    double? all,
    double? horizontal,
    double? vertical,
    double? left,
    double? top,
    double? right,
    double? bottom,
  }) {
    if (all != null) {
      return EdgeInsets.all(all);
    }

    return EdgeInsets.only(
      left: left ?? horizontal ?? 0,
      top: top ?? vertical ?? 0,
      right: right ?? horizontal ?? 0,
      bottom: bottom ?? vertical ?? 0,
    );
  }

  /// For Special Ones
  /// Horizontal: 24, Vertical: 12
  static const EdgeInsets onBoardingButtonPadding = EdgeInsets.symmetric(
    horizontal: 24,
    vertical: 12,
  );
}
