import 'package:asset_tracker_app/bloc/harem_altin_service/harem_altin_bloc.dart';
import 'package:asset_tracker_app/bloc/harem_altin_service/harem_altin_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LastUpdateDate extends StatelessWidget {
  const LastUpdateDate({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HaremAltinBloc, HaremAltinState>(
      builder: (context, state) {
        if (state is HaremAltinDataLoaded && state.data.isNotEmpty) {
          final firstData = state.data.values.first;
          return Text('Last Update: ${firstData['tarih']}');
        }
        return const SizedBox.shrink();
      },
    );
  }
}
