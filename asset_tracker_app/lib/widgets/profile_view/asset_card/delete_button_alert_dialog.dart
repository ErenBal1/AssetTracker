import 'package:asset_tracker_app/bloc/my_assets/my_assets_bloc.dart';
import 'package:asset_tracker_app/bloc/my_assets/my_assets_event.dart';
import 'package:asset_tracker_app/localization/strings.dart';
import 'package:asset_tracker_app/models/user_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteButtonAlertDialog extends StatelessWidget {
  const DeleteButtonAlertDialog({
    super.key,
    required this.asset,
  });

  final UserAsset asset;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(LocalStrings.deleteAsset),
      content:
          Text(asset.type.displayName + LocalStrings.deleteAssetConfirmation),
      actions: [
        //Cancel Button
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(LocalStrings.cancel),
        ),
        //Delete Button
        TextButton(
          onPressed: () => _onDeletePressed(context),
          style: TextButton.styleFrom(foregroundColor: Colors.red),
          child: const Text(LocalStrings.delete),
        ),
      ],
    );
  }

  Future<void> _onDeletePressed(BuildContext context) async {
    Navigator.pop(context);
    try {
      if (!context.mounted) return;

      // MyAssetsBloc üzerinden silme işlemini gerçekleştir
      final myAssetsBloc = context.read<MyAssetsBloc>();
      myAssetsBloc.add(DeleteUserAsset(asset.id));

      // Bir kısa gecikmeden sonra listeyi güncelle
      Future.delayed(const Duration(milliseconds: 300), () {
        if (context.mounted) {
          // Silme işleminden sonra verileri yeniden yükle
          myAssetsBloc.add(LoadUserAssets());
        }
      });

      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(LocalStrings.assetDeletedSuccessfully)),
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(LocalStrings.deleteAssetFailed + e.toString())),
      );
    }
  }
}
