import 'package:asset_tracker_app/bloc/harem_altin_service/harem_altin_bloc.dart';
import 'package:asset_tracker_app/bloc/harem_altin_service/harem_altin_state.dart';
import 'package:asset_tracker_app/localization/strings.dart';
import 'package:asset_tracker_app/models/harem_altin_currency_data_model.dart';
import 'package:asset_tracker_app/utils/mixins/home_screen_mixin.dart';
import 'package:asset_tracker_app/widgets/home_page/asset_list_item.dart';
import 'package:asset_tracker_app/widgets/home_page/last_update_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> with HomeScreenMixin {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  List<CurrencyData> _getFilteredCurrencies(List<CurrencyData> currencies) {
    if (_searchQuery.isEmpty) return currencies;

    return currencies
        .where((currency) => currency.displayName
            .toLowerCase()
            .contains(_searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assets Tracker'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Son güncelleme tarihi
          const Padding(
            padding: EdgeInsets.only(top: 8, bottom: 4),
            child: LastUpdateDate(),
          ),

          // Arama alanı
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search assets...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
              ),
              onChanged: (query) {
                setState(() {
                  _searchQuery = query;
                });
              },
            ),
          ),

          // Liste
          Expanded(
            child: BlocBuilder<HaremAltinBloc, HaremAltinState>(
              builder: (context, state) {
                if (state is HaremAltinDataLoaded) {
                  final filteredCurrencies = _getFilteredCurrencies(
                      state.currentData.sortedCurrencies);

                  return ListView.builder(
                    padding: const EdgeInsets.only(bottom: 16),
                    itemCount: filteredCurrencies.length,
                    itemBuilder: (context, index) {
                      final currency = filteredCurrencies[index];
                      final previousCurrency =
                          state.previousData?.currencies[currency.code];
                      return AssetListItem(
                        currency: currency,
                        previousCurrency: previousCurrency,
                      );
                    },
                  );
                }
                if (state is HaremAltinDataError) {
                  return Center(
                    child:
                        Text('${LocalStrings.defaultError} ${state.message}'),
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
