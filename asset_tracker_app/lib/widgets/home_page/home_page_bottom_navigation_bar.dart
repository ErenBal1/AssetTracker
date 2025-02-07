import 'package:asset_tracker_app/localization/strings.dart';
import 'package:flutter/material.dart';

class HomeBottomNav extends StatelessWidget {
  const HomeBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 0,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: LocalStrings.homeLabelNavBar,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: LocalStrings.profileLabelNavBar,
        ),
      ],
    );
  }
}
