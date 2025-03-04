import 'package:bciapplication/utils/constants.dart';
import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final String? selectedValue;
  final List<String> categories;
  final ValueChanged<String?>? onChanged;
  final TextEditingController controller;

  const CustomDropdown({
    Key? key,
    required this.selectedValue,
    required this.categories,
    required this.onChanged,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      hint: const Text(
        'Select Category',
        style: TextStyle(color: Colors.grey),
      ),
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: brandPrimaryColor, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: brandPrimaryColor, width: 2),
          )),
      dropdownColor: Colors.black,
      style: const TextStyle(color: Colors.white),
      items: categories.map((String category) {
        return DropdownMenuItem<String>(
          value: category,
          child: Text(category, style: const TextStyle(color: Colors.white)),
        );
      }).toList(),
      onChanged: (String? newValue) {
        if (onChanged != null) {
          onChanged!(newValue);
        }
        controller.text = newValue ?? ''; // Update controller
      },
    );
  }
}
