import 'package:asset_tracker_app/models/user_asset.dart';
import 'package:asset_tracker_app/widgets/my_assets_view/asset_card/delete_button_alert_dialog.dart';
import 'package:flutter/material.dart';

class DeleteAssetButton extends StatelessWidget {
  const DeleteAssetButton({
    super.key,
    required this.asset,
  });

  final UserAsset asset;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.delete),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => DeleteButtonAlertDialog(asset: asset),
        );
      },
    );
  }
}
