import 'package:asset_tracker_app/bloc/harem_altin_service/harem_altin_bloc.dart';
import 'package:asset_tracker_app/bloc/harem_altin_service/harem_altin_event.dart';
import 'package:asset_tracker_app/utils/constants/app_routes_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageLogoutButton extends StatelessWidget {
  const HomePageLogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.logout),
      onPressed: () async {
        // Önce websocket bağlantısını kapat
        context.read<HaremAltinBloc>().add(DisconnectWebSocket());
        // Sonra çıkış yap
        await FirebaseAuth.instance.signOut();
        if (context.mounted) {
          Navigator.pushReplacementNamed(context, ToScreen.loginPage);
        }
      },
    );
  }
}
