import 'package:flutter/material.dart';

class OnBoardingDotIndicator extends StatelessWidget {
  const OnBoardingDotIndicator({
    super.key,
    required int currentPage,
    required this.index,
  }) : _currentPage = currentPage;

  final int _currentPage;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentPage == index
            ? Theme.of(context).primaryColor
            : Colors.grey,
      ),
    );
  }
}
