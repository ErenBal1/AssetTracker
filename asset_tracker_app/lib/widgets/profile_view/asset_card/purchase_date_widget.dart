import 'package:asset_tracker_app/localization/strings.dart';
import 'package:asset_tracker_app/models/user_asset.dart';
import 'package:asset_tracker_app/utils/constants/theme/constant_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PurchaseDateWidget extends StatelessWidget {
  const PurchaseDateWidget({
    super.key,
    required this.asset,
  });

  final UserAsset asset;

  @override
  Widget build(BuildContext context) {
    return Text(
        LocalStrings.purchaseDateLabel +
            DateFormat('dd/MM/yyyy').format(asset.purchaseDate),
        style: ConstantTextStyles.assetCardPurchaseDateText);
  }
}
