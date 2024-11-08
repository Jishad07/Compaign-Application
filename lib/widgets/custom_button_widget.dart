import 'package:flutter/material.dart';

import '../utils/constants.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color? buttonColor;
  final VoidCallback onPressed;
  final Color? textcolor;

  const CustomButton({
    required this.text,
    this.buttonColor,
    required this.onPressed,
    this.textcolor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Constants.primaryColor,
            )),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16.0,
              color: textcolor,
            ),
          ),
        ),
      ),
    );
  }
}
