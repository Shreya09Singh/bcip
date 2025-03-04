import 'package:bciapplication/utils/constants.dart';
import 'package:flutter/material.dart';

class CustomTimePicker extends StatefulWidget {
  final TextEditingController controller;

  const CustomTimePicker({Key? key, required this.controller})
      : super(key: key);

  @override
  _CustomTimePickerState createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends State<CustomTimePicker> {
  Future<void> _pickTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Colors.blue,
              onPrimary: Colors.white,
              surface: Colors.black,
              onSurface: Colors.white,
            ),
            dialogBackgroundColor: Colors.black,
          ),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      setState(() {
        widget.controller.text = pickedTime.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      readOnly: true,
      onTap: () => _pickTime(context),
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22),
          borderSide: const BorderSide(color: brandPrimaryColor, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22),
          borderSide: const BorderSide(color: brandPrimaryColor, width: 2),
        ),
        hintText: "HH : MM",
        hintStyle: TextStyle(color: textSecondaryColor),
        suffixIcon: const Icon(Icons.access_time, color: textSecondaryColor),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(22)),
      ),
      style: TextStyle(color: textPrimaryColor),
    );
  }
}
