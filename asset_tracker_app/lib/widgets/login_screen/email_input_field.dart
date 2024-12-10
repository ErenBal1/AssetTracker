import 'package:asset_tracker_app/localization/strings.dart';
import 'package:flutter/material.dart';

class EmailInputField extends StatelessWidget {
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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return LocalStrings.enterEmail;
        }
        if (!value.contains('@')) {
          return LocalStrings.enterValidEmail;
        }
        return null;
      },
    );
  }
}
