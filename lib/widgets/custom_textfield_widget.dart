import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final String? label;
  final String? helpertext;
  final int? maximumLines;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;

  CustomInput({
    this.label,
    this.helpertext,
    required this.controller,
    this.validator,
    this.maximumLines= 1,  // Default value provided here
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label above the TextField
        Text(
          "$label",
          style: TextStyle(fontSize: 14),
        ),
        SizedBox(height: 8.0), // Add some space between label and input field
        // TextFormField
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            helperText: helpertext,
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(
              vertical: 12, // This will now work, as we ensured contentpaddingsize is non-null
              horizontal: 10.0,
            ),
          ),
           maxLines: maximumLines,  // Allow for multiple lines of text (this should be enough for 50+ characters)
          textInputAction: TextInputAction.newline, 
          validator: validator,
          style: TextStyle(fontSize: 16.0),
          // textInputAction: TextInputAction.next,
        ),
      ],
    );
  }
}
