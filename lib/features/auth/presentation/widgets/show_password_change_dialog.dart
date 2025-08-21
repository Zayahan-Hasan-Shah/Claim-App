import 'package:claim_app/core/constants/app_colors.dart';
import 'package:claim_app/core/widgets/custom_button.dart';
import 'package:claim_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

void showPasswordChangedDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CustomText(
                title: 'Change Password',
                fontSize: 24,
                weight: FontWeight.bold,
              ),
              const SizedBox(height: 16),
              const CustomText(
                title: 'Your password has been changed.',
                fontSize: 16,
                color: Colors.black87,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: 120,
                height: 48,
                child: CustomButton(
                  text: 'Ok',
                  onPressed: () {
                    Navigator.of(context).pop(); // Close dialog
                    Navigator.of(context).pop(); // Go back to previous screen
                  },
                  gradient: const LinearGradient(
                    colors: [
                      AppColors.purpleColor,
                      AppColors.orangeColor,
                    ],
                  ),
                  borderRadius: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
