import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? label;
  final String? Function(String?)? validator;
  final bool obscureText;
  final bool readOnly;
  final TextInputType? keyboardType;
  final int? maxLines;
  final VoidCallback? onTap;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? borderColor;
  final double? borderRadius;
  final String? hintText;

  const CustomTextField({
    super.key,
    required this.controller,
    this.label,
    this.validator,
    this.obscureText = false,
    this.readOnly = false,
    this.keyboardType,
    this.maxLines = 1,
    this.onTap,
    this.prefixIcon,
    this.suffixIcon,
    this.borderColor,
    this.borderRadius,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(

      controller: controller,
      decoration: InputDecoration(
        hintText: hintText ?? '',
        labelText: label ?? '',
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 8),
          borderSide: BorderSide(
            color: borderColor ?? Colors.grey,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 8),
          borderSide: BorderSide(
            color: borderColor ?? Colors.grey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 8),
          borderSide: BorderSide(
            color: borderColor ?? Theme.of(context).primaryColor,
            width: 2,
          ),
        ),
      ),
      validator: validator,
      obscureText: obscureText,
      readOnly: readOnly,
      keyboardType: keyboardType,
      maxLines: maxLines,
      onTap: onTap,
    );
  }
}
