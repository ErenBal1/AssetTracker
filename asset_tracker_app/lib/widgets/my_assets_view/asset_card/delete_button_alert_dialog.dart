import 'package:asset_tracker_app/localization/strings.dart';
import 'package:asset_tracker_app/models/user_asset.dart';
import 'package:asset_tracker_app/repositories/user_asset_repository.dart';
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
          onPressed: () async {
            Navigator.pop(context);
            try {
              if (!context.mounted) return;
              await context.read<UserAssetRepository>().deleteAsset(asset.id);
              if (!context.mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text(LocalStrings.assetDeletedSuccessfully)),
              );
            } catch (e) {
              if (!context.mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content:
                        Text(LocalStrings.deleteAssetFailed + e.toString())),
              );
            }
          },
          style: TextButton.styleFrom(foregroundColor: Colors.red),
          child: const Text(LocalStrings.delete),
        ),
      ],
    );
  }
}
