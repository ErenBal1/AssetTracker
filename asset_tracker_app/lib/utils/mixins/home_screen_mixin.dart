import 'package:asset_tracker_app/bloc/harem_altin_service/harem_altin_bloc.dart';
import 'package:asset_tracker_app/bloc/harem_altin_service/harem_altin_event.dart';
import 'package:asset_tracker_app/services/firebase/firebase_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin HomeScreenMixin<HomeScreenState extends StatefulWidget>
    on State<HomeScreenState> {
  final FirebaseAuthService authService = FirebaseAuthService();
  late final HaremAltinBloc _haremAltinBloc;

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
