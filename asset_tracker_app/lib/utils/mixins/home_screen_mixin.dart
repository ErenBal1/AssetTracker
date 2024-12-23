import 'package:asset_tracker_app/bloc/harem_altin_service/harem_altin_bloc.dart';
import 'package:asset_tracker_app/bloc/harem_altin_service/harem_altin_event.dart';
import 'package:asset_tracker_app/localization/strings.dart';
import 'package:asset_tracker_app/services/firebase/firebase_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin HomeScreenMixin<HomeScreenState extends StatefulWidget>
    on State<HomeScreenState> {
  final FirebaseAuthService authService = FirebaseAuthService();
  late final HaremAltinBloc _haremAltinBloc;
  final _snackBarDurationValue = 50;

  Future<void> refreshData() async {
    _haremAltinBloc.add(DisconnectWebSocket());
    _haremAltinBloc.add(ConnectToWebSocket());

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(LocalStrings.refreshingData),
          duration: Duration(milliseconds: _snackBarDurationValue),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _haremAltinBloc = context.read<HaremAltinBloc>();
    _haremAltinBloc.add(ConnectToWebSocket());
  }

  @override
  void dispose() {
    _haremAltinBloc.add(DisconnectWebSocket());
    super.dispose();
  }
}
