import 'package:asset_tracker_app/widgets/home_page/add_asset.dart';
import 'package:flutter/material.dart';

void showAddAssetBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: const AddAssetForm(),
    ),
  );
}
