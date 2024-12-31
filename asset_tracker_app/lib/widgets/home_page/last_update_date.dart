import 'package:asset_tracker_app/bloc/harem_altin_service/harem_altin_bloc.dart';
import 'package:asset_tracker_app/bloc/harem_altin_service/harem_altin_state.dart';
import 'package:asset_tracker_app/localization/strings.dart';
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
        if (state is HaremAltinDataLoaded) {
          final currencies = state.currentData.currencies;
          if (currencies.isNotEmpty) {
            final firstCurrency = currencies.values.first;
            return Text('${LocalStrings.lastUpdate} ${firstCurrency.tarih}');
          }
        }
        return const SizedBox.shrink();
      },
    );
  }
}
