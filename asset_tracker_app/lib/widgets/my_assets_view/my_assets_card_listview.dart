import 'package:asset_tracker_app/bloc/harem_altin_service/harem_altin_state.dart';
import 'package:asset_tracker_app/models/user_asset.dart';
import 'package:asset_tracker_app/repositories/user_asset_repository.dart';
import 'package:asset_tracker_app/widgets/my_assets_view/my_assets_card.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyAssetsCardListView extends StatelessWidget {
  const MyAssetsCardListView({
    required this.haremAltinState,
    super.key,
  });
  final HaremAltinDataLoaded haremAltinState;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<UserAsset>>(
      stream: context.read<UserAssetRepository>().getUserAssets(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('Hata: ${snapshot.error}'),
          );
        }

        if (!snapshot.hasData) {
          return const Center(
            child: Text("burda sıkıntı var 1."),
          );
        }

        final assets = snapshot.data!;
        if (assets.isEmpty) {
          return const Center(
            child: Text('Henüz varlık eklemediniz.'),
          );
        }

        return ListView.builder(
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
        );
      },
    );
  }
}
