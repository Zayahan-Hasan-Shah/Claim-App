import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool outlined;
  final double? width;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.outlined = false,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: outlined
          ? OutlinedButton(
              onPressed: onPressed,
              child: Text(text),
            )
          : ElevatedButton(
              onPressed: onPressed,
              child: Text(text),
            ),
    );
  }
}