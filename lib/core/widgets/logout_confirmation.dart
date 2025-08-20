// core/widgets/logout_confirmation_dialog.dart
import 'package:claim_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

Future<bool?> showLogoutConfirmationDialog(BuildContext context) async {
  return await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const CustomText(title: 'Confirm Logout'),
      content: const CustomText(title: 'Are you sure you want to logout?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const CustomText(title: 'Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: const CustomText(title: 'Logout'),
        ),
      ],
    ),
  );
}
