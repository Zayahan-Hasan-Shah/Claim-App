// core/widgets/custom_text.dart
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String title;
  final double? fontSize;
  final TextAlign? align;
  final int? maxLines;
  final TextOverflow? overflow;
  final FontWeight? weight;
  final double? size;
  final Color? color;
  final bool underline;

  const CustomText({
    super.key,
    required this.title,
    this.fontSize,
    this.align,
    this.maxLines,
    this.overflow,
    this.weight,
    this.size,
    this.color,
    this.underline = false,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: fontSize ?? 16,
        fontWeight: weight,
        color: color,
        decoration: underline ? TextDecoration.underline : null,
      ),
      textAlign: align,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
