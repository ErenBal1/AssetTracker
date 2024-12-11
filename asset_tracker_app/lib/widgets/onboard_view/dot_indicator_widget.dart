import 'package:asset_tracker_app/utils/constants/theme/constant_paddings.dart';
import 'package:flutter/material.dart';

class OnBoardingDotIndicator extends StatelessWidget {
  const OnBoardingDotIndicator({
    super.key,
    required int currentPage,
    required this.index,
  }) : _currentPage = currentPage;

  final int _currentPage;
  final int index;
  final double _dotIndicatorContainerWidth = 8;
  final double _dotIndicatorContainerHeight = 8;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: ConstantPaddings.horizontalXXS,
      width: _dotIndicatorContainerWidth,
      height: _dotIndicatorContainerHeight,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentPage == index
            ? Theme.of(context).primaryColor
            : Colors.grey,
      ),
    );
  }
}
