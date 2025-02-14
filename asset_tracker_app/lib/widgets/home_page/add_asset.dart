import 'package:asset_tracker_app/bloc/asset_form/asset_form_state.dart';
import 'package:asset_tracker_app/localization/strings.dart';
import 'package:asset_tracker_app/repositories/user_asset_repository.dart';
import 'package:asset_tracker_app/utils/constants/theme/constant_gap_sizes.dart';
import 'package:asset_tracker_app/utils/constants/theme/constant_paddings.dart';
import 'package:asset_tracker_app/utils/mixins/home_screen_mixins/add_asset_form_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:asset_tracker_app/bloc/asset_form/asset_form_bloc.dart';

class AddAssetForm extends StatefulWidget {
  const AddAssetForm({super.key});

  @override
  State<AddAssetForm> createState() => _AddAssetFormState();
}

class _AddAssetFormState extends State<AddAssetForm> with AddAssetFormMixin {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AssetFormBloc(
        userAssetRepository: context.read<UserAssetRepository>(),
      ),
      child: BlocListener<AssetFormBloc, AssetFormState>(
        listener: (context, state) {
          if (state.isSuccess) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text(LocalStrings.assetAddedSuccessfully)),
            );
          } else if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error!)),
            );
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: ConstantPaddings.allM,
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildTypeDropdown(),
                  const GapSize.small(),
                  buildAmountField(),
                  const GapSize.small(),
                  buildPriceField(),
                  const GapSize.small(),
                  buildDatePicker(),
                  const GapSize.medium(),
                  buildSubmitButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
