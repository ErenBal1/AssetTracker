import 'package:asset_tracker_app/services/firebase/auth_service.dart';
import 'package:asset_tracker_app/utils/constants/app_routes_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//bu sayfa komple degisecek gecici olarak yaptim

class HomePageView extends StatelessWidget {
  final AuthService _authService = AuthService();

  HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await _authService.signOut();
              if (context.mounted) {
                Navigator.pushReplacementNamed(context, ToScreen.loginPage);
              }
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Email: ${user?.email ?? ''}'),
            const SizedBox(height: 16),
            const Text('Welcome to Asset Tracker!'),
          ],
        ),
      ),
    );
  }
}
