import 'package:asset_tracker_app/bloc/harem_altin_service/harem_altin_bloc.dart';
import 'package:asset_tracker_app/bloc/harem_altin_service/harem_altin_event.dart';
import 'package:asset_tracker_app/bloc/harem_altin_service/harem_altin_state.dart';
import 'package:asset_tracker_app/models/user_asset.dart';
import 'package:asset_tracker_app/repositories/user_asset_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class MyAssetsView extends StatefulWidget {
  const MyAssetsView({super.key});

  @override
  State<MyAssetsView> createState() => _MyAssetsViewState();
}

class _MyAssetsViewState extends State<MyAssetsView> {
  late final HaremAltinBloc _haremAltinBloc;

  @override
  void initState() {
    super.initState();
    _haremAltinBloc = context.read<HaremAltinBloc>();
    _haremAltinBloc.add(ConnectToWebSocket());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_haremAltinBloc.state is HaremAltinDataLoaded) {
        _haremAltinBloc.add(DisconnectWebSocket());
      }
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Assets'),
      ),
      body: BlocBuilder<HaremAltinBloc, HaremAltinState>(
        builder: (context, haremAltinState) {
          if (haremAltinState is HaremAltinDataLoaded) {
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

                    return Card(
                      margin: const EdgeInsets.all(8),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  asset.type.displayName,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text('Varlığı Sil'),
                                        content: Text(
                                            '${asset.type.displayName} varlığını silmek istediğinize emin misiniz?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: const Text('İptal'),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              // Önce dialog'u kapat
                                              Navigator.pop(context);

                                              try {
                                                // BuildContext'i kontrol et
                                                if (!context.mounted) return;

                                                await context
                                                    .read<UserAssetRepository>()
                                                    .deleteAsset(asset.id);

                                                // BuildContext'i tekrar kontrol et
                                                if (!context.mounted) return;

                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                      content: Text(
                                                          'Varlık başarıyla silindi')),
                                                );
                                              } catch (e) {
                                                // BuildContext'i kontrol et
                                                if (!context.mounted) return;

                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                      content: Text(
                                                          'Silme işlemi başarısız: $e')),
                                                );
                                              }
                                            },
                                            style: TextButton.styleFrom(
                                                foregroundColor: Colors.red),
                                            child: const Text('Sil'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Miktar: ${asset.amount}',
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Alış Fiyatı: ${asset.purchasePrice.toStringAsFixed(2)} ₺',
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Güncel Değer: ${currentValue.toStringAsFixed(2)} ₺',
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Kar/Zarar: ${profitLoss.toStringAsFixed(2)} ₺ (${profitLossPercentage.toStringAsFixed(2)}%)',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color:
                                    profitLoss >= 0 ? Colors.green : Colors.red,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Alım Tarihi: ${DateFormat('dd/MM/yyyy').format(asset.purchaseDate)}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }

          return const Center(
            child: Text("burda sıkıntı var 2."),
          );
        },
      ),
    );
  }
}
