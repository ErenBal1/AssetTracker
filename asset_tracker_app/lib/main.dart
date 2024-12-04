import 'package:asset_tracker_app/view/homePageView.dart';
import 'package:asset_tracker_app/view/loginPageView.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginPageView(),
      debugShowCheckedModeBanner: false,
    );
  }
}
