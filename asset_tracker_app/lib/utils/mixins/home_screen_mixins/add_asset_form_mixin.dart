import 'package:asset_tracker_app/bloc/asset_form/asset_form_bloc.dart';
import 'package:asset_tracker_app/bloc/asset_form/asset_form_event.dart';
import 'package:asset_tracker_app/bloc/asset_form/asset_form_state.dart';
import 'package:asset_tracker_app/localization/strings.dart';
import 'package:asset_tracker_app/utils/enums/currency_type_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:asset_tracker_app/utils/constants/asset_priority_list.dart';

mixin AddAssetFormMixin<AddAssetFormState extends StatefulWidget>
    on State<AddAssetFormState> {
  final formKey = GlobalKey<FormState>();
  CurrencyType? _selectedType;
  String? _selectedKarat;
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
    final selectableTypes = priorityOrder
        .where((type) => selectableAssetCodes
            .map((e) => e.toUpperCase())
            .contains(type.name.toUpperCase()))
        .toList();
    return DropdownButtonFormField<CurrencyType>(
      value: _selectedType,
      decoration: const InputDecoration(
        labelText: LocalStrings.assetType,
        border: OutlineInputBorder(),
      ),
      items: selectableTypes
          .map((type) => DropdownMenuItem(
                value: type,
                child: Text(type.displayName),
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          _selectedType = value;
          if (value != CurrencyType.BILEZIK) {
            _selectedKarat = null;
          }
        });
      },
      validator: (value) {
        if (value == null) return LocalStrings.selectType;
        return null;
      },
    );
  }

  Widget buildKaratDropdown() {
    if (_selectedType != CurrencyType.BILEZIK) {
      return const SizedBox.shrink();
    }

    return DropdownButtonFormField<String>(
      value: _selectedKarat,
      decoration: const InputDecoration(
        labelText: 'Ayar',
        border: OutlineInputBorder(),
      ),
      items: const [
        DropdownMenuItem(value: '14', child: Text(LocalStrings.dropDown14Ayar)),
        DropdownMenuItem(value: '22', child: Text(LocalStrings.dropDown22Ayar)),
      ],
      onChanged: (value) {
        setState(() => _selectedKarat = value);
      },
      validator: (value) {
        if (_selectedType == CurrencyType.BILEZIK &&
            (value == null || value.isEmpty)) {
          return LocalStrings.pleaseSelectCarat;
        }
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
        if (value.contains(',')) {
          return LocalStrings.valueContainsCommaError;
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
        if (value.contains(',')) {
          return LocalStrings.valueContainsCommaError;
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
          setState(() {
            _selectedDate = picked;
          });
        }
      },
      child: InputDecorator(
        decoration: const InputDecoration(
          labelText: LocalStrings.purchaseDate,
          border: OutlineInputBorder(),
        ),
        child: Text(
          _selectedDate == null
              ? LocalStrings.selectDate
              : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
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
                karat: _selectedType == CurrencyType.BILEZIK
                    ? _selectedKarat
                    : null,
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
