import 'package:asset_tracker_app/init/app_init.dart';
import 'package:asset_tracker_app/utils/constants/app_routes_constants.dart';
import 'package:asset_tracker_app/view/splash_view.dart';
import 'package:flutter/material.dart';

void main() async {
  AppInit();
  runApp(const AssetTrackerMain());
}

class AssetTrackerMain extends StatelessWidget {
  const AssetTrackerMain({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Asset Tracker',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        home: const SplashScreenView(),
        routes: AppRoutes.routes);
  }
}
