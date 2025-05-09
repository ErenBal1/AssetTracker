import 'package:asset_tracker_app/bloc/asset_form/asset_form_bloc.dart';
import 'package:asset_tracker_app/bloc/asset_form/asset_form_event.dart';
import 'package:asset_tracker_app/bloc/asset_form/asset_form_state.dart';
import 'package:asset_tracker_app/localization/strings.dart';
import 'package:asset_tracker_app/utils/enums/currency_type_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin AddAssetFormMixin<AddAssetFormState extends StatefulWidget>
    on State<AddAssetFormState> {
  final formKey = GlobalKey<FormState>();
  CurrencyType? _selectedType;
  final _amountController = TextEditingController();
  final _priceController = TextEditingController();
  DateTime? _selectedDate;

  void assetFormBlocListener(BuildContext context, AssetFormState state) {
    if (state.isSuccess) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(LocalStrings.assetAddedSuccessfully)),
      );
    } else if (state.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.error!)),
      );
    }
  }

  Widget buildTypeDropdown() {
    return DropdownButtonFormField<CurrencyType>(
      value: _selectedType,
      decoration: const InputDecoration(
        labelText: LocalStrings.assetType,
        border: OutlineInputBorder(),
      ),
      items: CurrencyType.values
          .map((type) => DropdownMenuItem(
                value: type,
                child: Text(type.displayName),
              ))
          .toList(),
      onChanged: (value) {
        setState(() => _selectedType = value);
      },
      validator: (value) {
        if (value == null) return LocalStrings.selectType;
        return null;
      },
    );
  }

  Widget buildAmountField() {
    return TextFormField(
      controller: _amountController,
      decoration: const InputDecoration(
        labelText: LocalStrings.assetAmount,
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return LocalStrings.enterAmount;
        }
        if (double.tryParse(value) == null || double.parse(value) <= 0) {
          return LocalStrings.enterValidAmount;
        }
        return null;
      },
    );
  }

  Widget buildPriceField() {
    return TextFormField(
      controller: _priceController,
      decoration: const InputDecoration(
        labelText: LocalStrings.assetPurchasePrice,
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return LocalStrings.enterAssetPrice;
        }
        if (double.tryParse(value) == null || double.parse(value) <= 0) {
          return LocalStrings.enterValidAssetPrice;
        }
        return null;
      },
    );
  }

  Widget buildDatePicker() {
    return InkWell(
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: _selectedDate ?? DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime.now(),
        );
        if (picked != null) {
          setState(() => _selectedDate = picked);
        }
      },
      child: InputDecorator(
        decoration: const InputDecoration(
          labelText: LocalStrings.purchaseDate,
          border: OutlineInputBorder(),
        ),
        child: Text(
          _selectedDate != null
              ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
              : LocalStrings.selectDate,
        ),
      ),
    );
  }

  Widget buildSubmitButton() {
    return ElevatedButton(
      onPressed: _submitForm,
      child: const Text(LocalStrings.add),
    );
  }

  void _submitForm() {
    if (formKey.currentState?.validate() ?? false) {
      if (_selectedDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(LocalStrings.pleaseSelectDate)),
        );
        return;
      }

      try {
        context.read<AssetFormBloc>().add(
              AssetSubmitted(
                type: _selectedType!,
                amount: double.parse(_amountController.text),
                purchasePrice: double.parse(_priceController.text),
                purchaseDate: _selectedDate!,
              ),
            );

        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(LocalStrings.assetAddedSuccessfully)),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(LocalStrings.errorOccurred + e.toString())),
        );
      }
    }
  }
}
