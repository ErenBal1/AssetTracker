import 'package:asset_tracker_app/models/user_asset.dart';
import 'package:asset_tracker_app/repositories/user_asset_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AssetCard extends StatelessWidget {
  const AssetCard({
    super.key,
    required this.asset,
    required this.currentValue,
    required this.profitLoss,
    required this.profitLossPercentage,
  });

  final UserAsset asset;
  final double currentValue;
  final double profitLoss;
  final double profitLossPercentage;

  @override
  Widget build(BuildContext context) {
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
                            onPressed: () => Navigator.pop(context),
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

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text('Varlık başarıyla silindi')),
                                );
                              } catch (e) {
                                // BuildContext'i kontrol et
                                if (!context.mounted) return;

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text('Silme işlemi başarısız: $e')),
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
                color: profitLoss >= 0 ? Colors.green : Colors.red,
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
  }
}
