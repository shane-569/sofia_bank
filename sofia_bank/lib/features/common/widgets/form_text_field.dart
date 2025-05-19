import 'package:flutter/material.dart';

class FormTextField extends StatelessWidget {
  final String label;
  final String? value;
  final String? errorText;
  final ValueChanged<String> onChanged;
  final TextInputType keyboardType;
  final bool enabled;

  const FormTextField({
    super.key,
    required this.label,
    this.value,
    this.errorText,
    required this.onChanged,
    this.keyboardType = TextInputType.text,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(text: value);
    controller.selection =
        TextSelection.collapsed(offset: controller.text.length);
    return TextField(
      enabled: enabled,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        errorText: errorText,
        border: const OutlineInputBorder(),
      ),
      keyboardType: keyboardType,
      onChanged: onChanged,
    );
  }
}
