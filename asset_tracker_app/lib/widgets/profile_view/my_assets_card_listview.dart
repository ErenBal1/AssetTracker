import 'package:asset_tracker_app/bloc/harem_altin_service/harem_altin_state.dart';
import 'package:asset_tracker_app/localization/strings.dart';
import 'package:asset_tracker_app/models/user_asset.dart';
import 'package:asset_tracker_app/repositories/user_asset_repository.dart';
import 'package:asset_tracker_app/widgets/profile_view/my_assets_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyAssetsCardListView extends StatelessWidget {
  const MyAssetsCardListView({
    required this.haremAltinState,
    this.maxHeight,
    super.key,
  });
  final HaremAltinDataLoaded haremAltinState;
  final double? maxHeight;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<UserAsset>>(
      stream: context.read<UserAssetRepository>().getUserAssets(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(LocalStrings.errorOccurred + snapshot.error.toString()),
          );
        }

        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final assets = snapshot.data!;
        if (assets.isEmpty) {
          return const Center(
            child: Text(LocalStrings.noAssetsAddedYet),
          );
        }

        return Container(
          constraints: BoxConstraints(
            maxHeight: maxHeight ?? MediaQuery.of(context).size.height * 0.6,
          ),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: assets.length,
            itemBuilder: (context, index) {
              final asset = assets[index];
              final currentRate =
                  haremAltinState.currentData.currencies[asset.type.name];

              if (currentRate == null) {
                return const SizedBox.shrink();
              }

              final currentValue = asset.getCurrentValue(currentRate);
              final profitLoss = asset.getProfitLoss(currentRate);
              final profitLossPercentage =
                  asset.getProfitLossPercentage(currentRate);

              return AssetCard(
                  asset: asset,
                  currentValue: currentValue,
                  profitLoss: profitLoss,
                  profitLossPercentage: profitLossPercentage);
            },
          ),
        );
      },
    );
  }
}
