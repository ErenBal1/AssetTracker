import 'package:asset_tracker_app/services/firebase/firebase_options.dart';
import 'package:asset_tracker_app/utils/constants.dart';
import 'package:asset_tracker_app/view/splash_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
