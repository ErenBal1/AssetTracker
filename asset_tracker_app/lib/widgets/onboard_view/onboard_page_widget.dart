import 'package:asset_tracker_app/utils/constants/app_size_constants.dart';
import 'package:asset_tracker_app/utils/constants/empty_size.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const OnboardingPage({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: AppSize.iconXXXL,
              color: Theme.of(context).primaryColor,
            ),
            const EmptySize.mediumLarge(),
            Text(
              title,
              style: const TextStyle(
                fontSize: AppSize.textXXL,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const EmptySize.small(),
            Text(
              description,
              style: const TextStyle(
                fontSize: AppSize.textLarge,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
