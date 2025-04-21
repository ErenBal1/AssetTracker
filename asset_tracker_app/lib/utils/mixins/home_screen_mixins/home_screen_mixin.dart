import 'package:asset_tracker_app/bloc/harem_altin_service/harem_altin_bloc.dart';
import 'package:asset_tracker_app/bloc/harem_altin_service/harem_altin_event.dart';
import 'package:asset_tracker_app/models/harem_altin_currency_data_model.dart';
import 'package:asset_tracker_app/services/auth_service.dart';
import 'package:asset_tracker_app/services/mock_service/mock_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin HomeScreenMixin<T extends StatefulWidget> on State<T> {
  final IAuthService authService = MockAuthService();
  late final HaremAltinBloc _haremAltinBloc;
  late final TextEditingController searchController;
  String searchQuery = '';

  List<CurrencyData> getFilteredCurrencies(List<CurrencyData> currencies) {
    if (searchQuery.isEmpty) return currencies;

    return currencies
        .where((currency) => currency.displayName
            .toLowerCase()
            .contains(searchQuery.toLowerCase()))
        .toList();
  }

  @override
  void initState() {
    super.initState();
    _haremAltinBloc = context.read<HaremAltinBloc>();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
