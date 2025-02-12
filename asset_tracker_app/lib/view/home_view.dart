import 'package:asset_tracker_app/utils/mixins/home_screen_mixins/home_screen_mixin.dart';
import 'package:asset_tracker_app/widgets/home_page/add_asset.dart';
import 'package:asset_tracker_app/widgets/home_page/asset_list/home_page_asset_list.dart';
import 'package:asset_tracker_app/widgets/home_page/home_page_bottom_navigation_bar.dart';
import 'package:asset_tracker_app/widgets/home_page/home_page_search_field.dart';
import 'package:asset_tracker_app/widgets/home_page/home_page_title.dart';
import 'package:asset_tracker_app/widgets/home_page/last_update_date.dart';
import 'package:flutter/material.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> with HomeScreenMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomePageTitle(),
      body: Column(
        children: [
          const LastUpdateDate(),
          HomeSearchField(
            controller: searchController,
            onQueryChanged: (query) => setState(() => searchQuery = query),
          ),
          HomeAssetList(
            searchQuery: searchQuery,
            getFilteredCurrencies: getFilteredCurrencies,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddAssetBottomSheet(context),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const HomeBottomNav(),
    );
  }

  void _showAddAssetBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: const AddAssetForm(),
      ),
    );
  }
}
