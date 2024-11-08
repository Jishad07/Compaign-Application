import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final String label;
  final String? helpertext;
  final int maximumLines;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;

  const CustomInput({
    required this.label,
    this.helpertext,
    required this.controller,
    this.validator,
    this.onChanged,
    this.maximumLines = 1,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8.0),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            helperText: helpertext,
            border: const OutlineInputBorder(),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 12, horizontal: 10.0),
          ),
          maxLines: maximumLines,
          textInputAction:
              maximumLines > 1 ? TextInputAction.newline : TextInputAction.next,
          validator: validator,
          style: const TextStyle(fontSize: 16.0),
          textCapitalization: TextCapitalization.sentences,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
