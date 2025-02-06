import 'package:asset_tracker_app/utils/constants/theme/constant_sizes.dart';
import 'package:flutter/material.dart';

/// Available padding values:
/// XXS: 4.0
/// XS:  8.0
/// S:   12.0
/// M:   16.0
/// L:   20.0
/// XL:  24.0
/// XXL: 32.0
///
/// Types:
/// - all: Applies padding to all sides
/// - horizontal: Applies padding horizontally
/// - vertical: Applies padding vertically
class ConstantPaddings {
  /// Alls
  /// padding: 4.0
  static const EdgeInsets allXXS = EdgeInsets.all(ConstantSizes.paddingXXS);

  /// padding: 8.0
  static const EdgeInsets allXS = EdgeInsets.all(ConstantSizes.paddingXS);

  /// padding: 12.0
  static const EdgeInsets allS = EdgeInsets.all(ConstantSizes.paddingS);

  /// padding: 16.0
  static const EdgeInsets allM = EdgeInsets.all(ConstantSizes.paddingM);

  /// padding: 20.0
  static const EdgeInsets allL = EdgeInsets.all(ConstantSizes.paddingL);

  /// padding: 24.0
  static const EdgeInsets allXL = EdgeInsets.all(ConstantSizes.paddingXL);

  /// padding: 32.0
  static const EdgeInsets allXXL = EdgeInsets.all(ConstantSizes.paddingXXL);

  /// Horizontals
  /// horizontal padding: 4.0
  static const EdgeInsets horizontalXXS =
      EdgeInsets.symmetric(horizontal: ConstantSizes.paddingXXS);

  /// horizontal padding: 8.0
  static const EdgeInsets horizontalXS =
      EdgeInsets.symmetric(horizontal: ConstantSizes.paddingXS);

  /// horizontal padding: 12.0
  static const EdgeInsets horizontalS =
      EdgeInsets.symmetric(horizontal: ConstantSizes.paddingS);

  /// horizontal padding: 16.0
  static const EdgeInsets horizontalM =
      EdgeInsets.symmetric(horizontal: ConstantSizes.paddingM);

  /// horizontal padding: 20.0
  static const EdgeInsets horizontalL =
      EdgeInsets.symmetric(horizontal: ConstantSizes.paddingL);

  /// horizontal padding: 24.0
  static const EdgeInsets horizontalXL =
      EdgeInsets.symmetric(horizontal: ConstantSizes.paddingXL);

  /// Verticals
  /// vertical padding: 4.0
  static const EdgeInsets verticalXXS =
      EdgeInsets.symmetric(vertical: ConstantSizes.paddingXXS);

  /// vertical padding: 8.0
  static const EdgeInsets verticalXS =
      EdgeInsets.symmetric(vertical: ConstantSizes.paddingXS);

  /// vertical padding: 12.0
  static const EdgeInsets verticalS =
      EdgeInsets.symmetric(vertical: ConstantSizes.paddingS);

  /// vertical padding: 16.0
  static const EdgeInsets verticalM =
      EdgeInsets.symmetric(vertical: ConstantSizes.paddingM);

  /// vertical padding: 20.0
  static const EdgeInsets verticalL =
      EdgeInsets.symmetric(vertical: ConstantSizes.paddingL);

  /// vertical padding: 24.0
  static const EdgeInsets verticalXL =
      EdgeInsets.symmetric(vertical: ConstantSizes.paddingXL);

  /// Creates custom padding based on provided values
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

  /// Special Cases
  /// horizontal: 24.0, vertical: 12.0
  static const EdgeInsets onBoardingButtonPadding = EdgeInsets.symmetric(
    horizontal: ConstantSizes.paddingXL, // 24
    vertical: ConstantSizes.paddingS, // 12
  );

  /// horizontal: 16.0, vertical: 8.0
  static const EdgeInsets homePageSearchFieldPadding = EdgeInsets.symmetric(
    horizontal: ConstantSizes.paddingM,
    vertical: ConstantSizes.paddingXS,
  );
}
