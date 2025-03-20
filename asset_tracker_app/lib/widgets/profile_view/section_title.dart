import 'package:asset_tracker_app/utils/constants/theme/constant_paddings.dart';
import 'package:flutter/material.dart';

/// A reusable section title widget
class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: ConstantPaddings.sectionTitlePadding,
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
