import 'package:asset_tracker_app/bloc/harem_altin_service/harem_altin_state.dart';
import 'package:asset_tracker_app/bloc/my_assets/my_assets_bloc.dart';
import 'package:asset_tracker_app/bloc/my_assets/my_assets_event.dart';
import 'package:asset_tracker_app/bloc/my_assets/my_assets_state.dart';
import 'package:asset_tracker_app/localization/strings.dart';
import 'package:asset_tracker_app/widgets/profile_view/my_assets_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyAssetsCardListView extends StatefulWidget {
  const MyAssetsCardListView({
    required this.haremAltinState,
    this.maxHeight,
    super.key,
  });
  final HaremAltinDataLoaded haremAltinState;
  final double? maxHeight;

  @override
  State<MyAssetsCardListView> createState() => _MyAssetsCardListViewState();
}

class _MyAssetsCardListViewState extends State<MyAssetsCardListView> {
  @override
  void initState() {
    super.initState();
    // Varlıkları yüklemek için bloka olayı göndeririz
    context.read<MyAssetsBloc>().add(LoadUserAssets());
  }

  @override
  Widget build(BuildContext context) {
    // MyAssetsBloc durumunu dinleyerek varlıkları gösteriyoruz
    return BlocBuilder<MyAssetsBloc, MyAssetsState>(
      builder: (context, state) {
        if (state is MyAssetsError) {
          return Center(
            child: Text(LocalStrings.errorOccurred + state.message),
          );
        }

        if (state is MyAssetsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is MyAssetsLoaded) {
          final assets = state.assets;
          if (assets.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(LocalStrings.noAssetsAddedYet),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Bu düğme veri yenilenmesi için bloka olayı gönderir
                      context.read<MyAssetsBloc>().add(LoadUserAssets());
                    },
                    child: const Text('Yenile'),
                  ),
                ],
              ),
            );
          }

          return Container(
            constraints: BoxConstraints(
              maxHeight:
                  widget.maxHeight ?? MediaQuery.of(context).size.height * 0.6,
            ),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: assets.length,
              itemBuilder: (context, index) {
                final asset = assets[index];
                final currentRate = widget
                    .haremAltinState.currentData.currencies[asset.type.name];

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
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
