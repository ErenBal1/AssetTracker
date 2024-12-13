import 'package:asset_tracker_app/localization/strings.dart';
import 'package:asset_tracker_app/utils/mixins/validation_mixin.dart';
import 'package:flutter/material.dart';

class EmailInputField extends StatelessWidget with ValidationMixin {
  final TextEditingController controller;

  const EmailInputField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
          labelText: LocalStrings.emailLabel,
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.email),
        ),
        validator: validateEmail);
  }
}
