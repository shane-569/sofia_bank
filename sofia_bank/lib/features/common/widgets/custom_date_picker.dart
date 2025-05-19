import 'package:flutter/material.dart';

class CustomDatePicker extends StatelessWidget {
  final String label;
  final DateTime? value;
  final String? errorText;
  final ValueChanged<DateTime> onChanged;

  const CustomDatePicker({
    super.key,
    required this.label,
    required this.value,
    this.errorText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: value ?? DateTime(1990, 1, 1),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );
        if (picked != null) onChanged(picked);
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          errorText: errorText,
          border: const OutlineInputBorder(),
        ),
        child: Text(
          value != null
              ? "${value!.day}/${value!.month}/${value!.year}"
              : 'Select date',
          style: TextStyle(
            color: value != null ? Colors.black : Colors.grey,
          ),
        ),
      ),
    );
  }
}
