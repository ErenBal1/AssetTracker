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
  // Verileri yenileme fonksiyonu
  Future<void> _refreshAssets() async {
    context.read<MyAssetsBloc>().add(LoadUserAssets());
    // Yenileme efekti için kısa bir gecikme
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  void initState() {
    super.initState();
    // Varlıkları yüklemek için bloka olayı göndeririz
    _refreshAssets();
  }

  @override
  Widget build(BuildContext context) {
    // MyAssetsBloc durumunu dinleyerek varlıkları gösteriyoruz
    return BlocBuilder<MyAssetsBloc, MyAssetsState>(
      builder: (context, state) {
        if (state is MyAssetsError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(LocalStrings.errorOccurred + state.message),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _refreshAssets,
                  child: const Text('Tekrar Dene'),
                ),
              ],
            ),
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
                    onPressed: _refreshAssets,
                    child: const Text('Yenile'),
                  ),
                ],
              ),
            );
          }

          // Aşağı çekince yenileme özelliği ekliyoruz
          return RefreshIndicator(
            onRefresh: _refreshAssets,
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overscroll) {
                // Android'deki mavi glow efektini gizleyelim
                overscroll.disallowIndicator();
                return true;
              },
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: widget.maxHeight ??
                      MediaQuery.of(context).size.height * 0.6,
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: assets.length,
                  itemBuilder: (context, index) {
                    final asset = assets[index];
                    final currentRate = widget.haremAltinState.currentData
                        .currencies[asset.type.name];

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
              ),
            ),
          );
        }

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Veri yüklenemedi. Lütfen tekrar deneyin.'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _refreshAssets,
                child: const Text('Tekrar Dene'),
              ),
            ],
          ),
        );
      },
    );
  }
}
