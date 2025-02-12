import 'package:asset_tracker_app/bloc/asset_form/asset_form_event.dart';
import 'package:asset_tracker_app/bloc/asset_form/asset_form_state.dart';
import 'package:asset_tracker_app/repositories/user_asset_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:asset_tracker_app/bloc/asset_form/asset_form_bloc.dart';
import 'package:asset_tracker_app/utils/enums/currency_type_enum.dart';

class AddAssetForm extends StatefulWidget {
  const AddAssetForm({super.key});

  @override
  State<AddAssetForm> createState() => _AddAssetFormState();
}

class _AddAssetFormState extends State<AddAssetForm> {
  final _formKey = GlobalKey<FormState>();
  CurrencyType? selectedType;
  final _amountController = TextEditingController();
  final _priceController = TextEditingController();
  DateTime? _selectedDate;

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
              const SnackBar(content: Text('Varlık başarıyla eklendi')),
            );
          } else if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error!)),
            );
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildTypeDropdown(),
                  const SizedBox(height: 16),
                  _buildAmountField(),
                  const SizedBox(height: 16),
                  _buildPriceField(),
                  const SizedBox(height: 16),
                  _buildDatePicker(),
                  const SizedBox(height: 24),
                  _buildSubmitButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTypeDropdown() {
    return DropdownButtonFormField<CurrencyType>(
      value: selectedType,
      decoration: const InputDecoration(
        labelText: 'Varlık Tipi',
        border: OutlineInputBorder(),
      ),
      items: CurrencyType.values
          .map((type) => DropdownMenuItem(
                value: type,
                child: Text(type.displayName),
              ))
          .toList(),
      onChanged: (value) {
        setState(() => selectedType = value);
      },
      validator: (value) {
        if (value == null) return 'Lütfen bir varlık tipi seçin';
        return null;
      },
    );
  }

  Widget _buildAmountField() {
    return TextFormField(
      controller: _amountController,
      decoration: const InputDecoration(
        labelText: 'Miktar',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Lütfen miktar girin';
        }
        if (double.tryParse(value) == null || double.parse(value) <= 0) {
          return 'Geçerli bir miktar girin';
        }
        return null;
      },
    );
  }

  Widget _buildPriceField() {
    return TextFormField(
      controller: _priceController,
      decoration: const InputDecoration(
        labelText: 'Alış Fiyatı',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Lütfen alış fiyatı girin';
        }
        if (double.tryParse(value) == null || double.parse(value) <= 0) {
          return 'Geçerli bir fiyat girin';
        }
        return null;
      },
    );
  }

  Widget _buildDatePicker() {
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
          labelText: 'Alım Tarihi',
          border: OutlineInputBorder(),
        ),
        child: Text(
          _selectedDate != null
              ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
              : 'Tarih Seçin',
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: _submitForm,
      child: const Text('Ekle'),
    );
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      if (_selectedDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Lütfen bir tarih seçin')),
        );
        return;
      }

      context.read<AssetFormBloc>().add(
            AssetSubmitted(
              type: selectedType!,
              amount: double.parse(_amountController.text),
              purchasePrice: double.parse(_priceController.text),
              purchaseDate: _selectedDate!,
            ),
          );
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _priceController.dispose();
    super.dispose();
  }
}
