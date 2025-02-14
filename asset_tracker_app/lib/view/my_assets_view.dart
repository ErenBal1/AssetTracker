import 'package:asset_tracker_app/bloc/harem_altin_service/harem_altin_bloc.dart';
import 'package:asset_tracker_app/bloc/harem_altin_service/harem_altin_state.dart';
import 'package:asset_tracker_app/localization/strings.dart';
import 'package:asset_tracker_app/utils/mixins/my_assets_view_mixin.dart';
import 'package:asset_tracker_app/widgets/my_assets_view/my_assets_card_listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyAssetsView extends StatefulWidget {
  const MyAssetsView({super.key});

  @override
  State<MyAssetsView> createState() => _MyAssetsViewState();
}

class _MyAssetsViewState extends State<MyAssetsView> with MyAssetsViewMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(LocalStrings.myAssetsLabel),
      ),
      body: BlocBuilder<HaremAltinBloc, HaremAltinState>(
        builder: (context, haremAltinState) {
          if (haremAltinState is HaremAltinDataLoaded) {
            return MyAssetsCardListView(haremAltinState: haremAltinState);
          } else if (haremAltinState is HaremAltinDataLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (haremAltinState is HaremAltinError) {
            return const Center(
              child: Text(LocalStrings.unableToLoadAssetsError),
            );
          }

          return const Center(
            child: Text(LocalStrings.smthWentWrongError),
          );
        },
      ),
    );
  }
}
