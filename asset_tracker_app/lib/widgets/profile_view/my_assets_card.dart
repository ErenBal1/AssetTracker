import 'package:asset_tracker_app/localization/strings.dart';
import 'package:asset_tracker_app/models/user_asset.dart';
import 'package:asset_tracker_app/utils/constants/theme/constant_gap_sizes.dart';
import 'package:asset_tracker_app/utils/constants/theme/constant_paddings.dart';
import 'package:asset_tracker_app/utils/formatters/currency_formatter.dart';
import 'package:asset_tracker_app/widgets/profile_view/asset_card/asset_card_info_text.dart';
import 'package:asset_tracker_app/widgets/profile_view/asset_card/asset_name_label.dart';
import 'package:asset_tracker_app/widgets/profile_view/asset_card/delete_asset_button.dart';
import 'package:asset_tracker_app/widgets/profile_view/asset_card/purchase_date_widget.dart';
import 'package:flutter/material.dart';

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
      child: Padding(
        padding: ConstantPaddings.allM,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: AssetNameLabel(asset: asset),
                ),
                DeleteAssetButton(asset: asset),
              ],
            ),
            const GapSize.extraSmall(),
            AssetCardInfoText(
                text: LocalStrings.amount +
                    CurrencyFormatter.formatInteger(asset.amount)),
            const GapSize.xxs(),
            AssetCardInfoText(
              text: LocalStrings.purchasePrice +
                  CurrencyFormatter.formatCurrency(asset.purchasePrice),
            ),
            const GapSize.xxs(),
            AssetCardInfoText(
              text: LocalStrings.assetCurrentValue +
                  CurrencyFormatter.formatCurrency(currentValue),
            ),
            const GapSize.extraSmall(),
            profitLossFormattedText(profitLoss, profitLossPercentage),
            const GapSize.xxs(),
            PurchaseDateWidget(asset: asset),
          ],
        ),
      ),
    );
  }

  Widget profitLossFormattedText(
      double profitLoss, double profitLossPercentage) {
    return Text(
      '${LocalStrings.profitLoss}${CurrencyFormatter.formatProfitLoss(profitLoss)} (${CurrencyFormatter.formatPercentage(profitLossPercentage)})',
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: profitLoss >= 0 ? Colors.green : Colors.red,
      ),
    );
  }
}
