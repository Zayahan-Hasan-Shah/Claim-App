import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool outlined;
  final double? width;
  final Gradient? gradient;
  final double? borderRadius;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.outlined = false,
    this.width,
    this.gradient,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    if (gradient != null) {
      return SizedBox(
        width: width,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(borderRadius ?? 8),
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 8),
              ),
            ),
            onPressed: onPressed,
            child: Text(text, style: const TextStyle(color: Colors.white)),
          ),
        ),
      );
    }
    return SizedBox(
      width: width,
      child: outlined
          ? OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius ?? 8),
                ),
              ),
              child: Text(text),
            )
          : ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius ?? 8),
                ),
              ),
              child: Text(text),
            ),
    );
  }
}
