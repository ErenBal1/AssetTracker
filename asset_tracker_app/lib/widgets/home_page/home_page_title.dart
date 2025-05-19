import 'package:asset_tracker_app/localization/strings.dart';
import 'package:asset_tracker_app/utils/constants/theme/constant_sizes.dart';
import 'package:flutter/material.dart';

class HomePageTitle extends StatelessWidget implements PreferredSizeWidget {
  const HomePageTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: const Text(LocalStrings.appLabel),
        centerTitle: true,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        backgroundColor: Theme.of(context).primaryColor);
  }

  @override
  Size get preferredSize => const Size.fromHeight(ConstantSizes.appBarHeight);
}
