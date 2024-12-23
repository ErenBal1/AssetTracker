import 'package:flutter/material.dart';

class HomePageRefreshButton extends StatelessWidget {
  final VoidCallback onPressed;

  const HomePageRefreshButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.refresh),
      onPressed: onPressed,
    );
  }
}
