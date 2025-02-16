import 'package:asset_tracker_app/bloc/harem_altin_service/harem_altin_bloc.dart';
import 'package:asset_tracker_app/bloc/harem_altin_service/harem_altin_event.dart';
import 'package:asset_tracker_app/bloc/harem_altin_service/harem_altin_state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin MyAssetsViewMixin<MyAssetsViewState extends StatefulWidget>
    on State<MyAssetsViewState> {
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
}
