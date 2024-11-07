// lib/components/custom_button.dart
import 'package:flutter/material.dart';



class CustomButton extends StatelessWidget {
  final String text;
  final Color? buttonColor; // Button color can be set
  final VoidCallback onPressed;

  const CustomButton({
    required this.text, 
    this.buttonColor,  // This allows you to pass the color
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed, // Button click action
      child: Container(
        height: 50,
        width: double.infinity,  // Make it take full width of the parent
        decoration: BoxDecoration(
          color: buttonColor, // Use buttonColor if provided, or default to orange
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.white,  // Text color
            ),
          ),
        ),
      ),
    );
  }
}
