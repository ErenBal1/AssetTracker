import 'package:asset_tracker_app/models/user_asset.dart';
import 'package:asset_tracker_app/utils/constants/theme/constant_text_styles.dart';
import 'package:flutter/material.dart';

class AssetNameLabel extends StatelessWidget {
  const AssetNameLabel({
    super.key,
    required this.asset,
  });

  final UserAsset asset;

  @override
  Widget build(BuildContext context) {
    return Text(
      asset.displayName,
      style: ConstantTextStyles.assetNameLabel,
    );
  }
}
