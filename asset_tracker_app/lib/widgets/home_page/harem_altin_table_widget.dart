import 'package:asset_tracker_app/bloc/harem_altin_service/harem_altin_bloc.dart';
import 'package:asset_tracker_app/bloc/harem_altin_service/harem_altin_state.dart';
import 'package:asset_tracker_app/localization/strings.dart';
import 'package:asset_tracker_app/widgets/home_page/harem_altin_table_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HaremAltinTableWidget extends StatelessWidget {
  const HaremAltinTableWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HaremAltinBloc, HaremAltinState>(
      builder: (context, state) {
        if (state is HaremAltinDataLoaded) {
          return HaremAltinTableData(
            previousData: state.previousData,
            currentData: state.currentData,
          );
        } else if (state is HaremAltinDataError) {
          return Center(
              child: Text('${LocalStrings.defaultError} ${state.message}'));
        }
        return const SizedBox.shrink();
      },
    );
  }
}
