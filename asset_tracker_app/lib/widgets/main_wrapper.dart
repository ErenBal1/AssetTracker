import 'package:asset_tracker_app/localization/strings.dart';
import 'package:asset_tracker_app/view/home_view.dart';
import 'package:asset_tracker_app/view/profile_view.dart';
import 'package:flutter/material.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePageView(),
    const ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
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
      ),
    );
  }
}
