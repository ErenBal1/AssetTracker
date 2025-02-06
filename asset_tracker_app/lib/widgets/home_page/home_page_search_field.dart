import 'package:asset_tracker_app/localization/strings.dart';
import 'package:asset_tracker_app/utils/constants/theme/constant_paddings.dart';
import 'package:flutter/material.dart';

class HomeSearchField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onQueryChanged;
  final _outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
  );

  HomeSearchField({
    required this.controller,
    required this.onQueryChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: ConstantPaddings.homePageSearchFieldPadding,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: LocalStrings.searchFieldHintText,
          prefixIcon: const Icon(Icons.search),
          border: _outlineInputBorder,
          filled: true,
          fillColor: Colors.grey.shade100,
        ),
        onChanged: onQueryChanged,
      ),
    );
  }
}
