import 'dart:async';

import 'package:asset_tracker_app/bloc/auth/auth_bloc.dart';
import 'package:asset_tracker_app/bloc/auth/auth_event.dart';
import 'package:asset_tracker_app/bloc/auth/auth_state.dart';
import 'package:asset_tracker_app/bloc/harem_altin_service/harem_altin_bloc.dart';
import 'package:asset_tracker_app/bloc/harem_altin_service/harem_altin_event.dart';
import 'package:asset_tracker_app/bloc/harem_altin_service/harem_altin_state.dart';
import 'package:asset_tracker_app/localization/strings.dart';
import 'package:asset_tracker_app/view/login_screen_view.dart';
import 'package:asset_tracker_app/widgets/profile_view/my_assets_card_listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin ProfileViewMixin<ProfileViewState extends StatefulWidget>
    on State<ProfileViewState> {
  late final HaremAltinBloc _haremAltinBloc;

  @override
  void initState() {
    super.initState();
    _haremAltinBloc = context.read<HaremAltinBloc>();
    _haremAltinBloc.add(ConnectToWebSocket());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_haremAltinBloc.state is HaremAltinDataLoaded) {
        _haremAltinBloc.add(DisconnectWebSocket());
      }
    });
    super.dispose();
  }

  void showTransactionsHistory() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(LocalStrings.transactionHistoryLabel),
        content: SizedBox(
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height * 0.6,
            child: BlocBuilder<HaremAltinBloc, HaremAltinState>(
              builder: (context, haremAltinState) {
                if (haremAltinState is HaremAltinDataLoaded) {
                  return MyAssetsCardListView(haremAltinState: haremAltinState);
                }
                if (haremAltinState is HaremAltinDataLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (haremAltinState is HaremAltinError) {
                  return const Center(
                    child: Text(LocalStrings.unableToLoadAssetsError),
                  );
                }

                return const Center(
                  child: Text(LocalStrings.smthWentWrongError),
                );
              },
            )),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Kapat'),
          ),
        ],
      ),
    );
  }

  Future<void> handleLogout() async {
    final shouldLogout = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Çıkış Yap'),
            content: const Text('Çıkış yapmak istediğinizden emin misiniz?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('İptal'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Çıkış Yap'),
              ),
            ],
          ),
        ) ??
        false;

    if (!shouldLogout) {
      return;
    }
    try {
      final authBloc = context.read<AuthBloc>();
      late final StreamSubscription<AuthState> subscription;

      subscription = authBloc.stream.listen((state) {
        if (state is AuthInitial) {
          subscription.cancel();
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const LoginScreenView(),
            ),
            (route) => false,
          );
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Başarıyla çıkış yapıldı'),
              backgroundColor: Colors.green,
            ),
          );
        } else if (state is AuthError) {
          subscription.cancel();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Çıkış yapma hatası: ${state.message}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      });

      authBloc.add(SignOutRequested());
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Çıkış yaparken bir hata oluştu: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
