import 'package:asset_tracker_app/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePageView extends StatelessWidget {
  final AuthService _authService = AuthService();

  HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('Hoş Geldin ${user?.displayName ?? 'Kullanıcı'}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await _authService.signOut();
              if (context.mounted) {
                Navigator.pushReplacementNamed(context, '/login');
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
            const Text('Asset Tracker\'a Hoş Geldiniz!'),
          ],
        ),
      ),
    );
  }
}
