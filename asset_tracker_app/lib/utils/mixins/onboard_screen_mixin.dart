import 'package:flutter/material.dart';
import '../constants/controllers.dart';

mixin OnboardScreenMixin<T extends StatefulWidget> on State<T> {
  int currentPage = 0;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void setPageIndex(int index) {
    setState(() {
      currentPage = index;
    });
  }

  void navigateToNextPage() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}
