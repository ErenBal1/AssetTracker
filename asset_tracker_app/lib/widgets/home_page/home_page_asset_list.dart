import 'package:asset_tracker_app/bloc/harem_altin_service/harem_altin_bloc.dart';
import 'package:asset_tracker_app/bloc/harem_altin_service/harem_altin_state.dart';
import 'package:asset_tracker_app/localization/strings.dart';
import 'package:asset_tracker_app/models/harem_altin_currency_data_model.dart';
import 'package:asset_tracker_app/widgets/home_page/asset_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeAssetList extends StatelessWidget {
  final String searchQuery;
  final List<CurrencyData> Function(List<CurrencyData>) getFilteredCurrencies;

  const HomeAssetList({
    required this.searchQuery,
    required this.getFilteredCurrencies,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double bottomPadding = 16;
    return Expanded(
      child: BlocBuilder<HaremAltinBloc, HaremAltinState>(
        builder: (context, state) {
          if (state is HaremAltinDataLoaded) {
            final filteredCurrencies = getFilteredCurrencies(
              state.currentData.sortedCurrencies,
            );

            return ListView.builder(
              key: const PageStorageKey(LocalStrings.assetListCode),
              padding: EdgeInsets.only(bottom: bottomPadding),
              itemCount: filteredCurrencies.length,
              itemBuilder: (context, index) {
                final currency = filteredCurrencies[index];
                final previousCurrency =
                    state.previousData?.currencies[currency.code];

                return AssetListItem(
                  key: ValueKey(currency.code),
                  currency: currency,
                  previousCurrency: previousCurrency,
                );
              },
            );
          }
          if (state is HaremAltinDataError) {
            return Center(
              child: Text('${LocalStrings.defaultError} ${state.message}'),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
