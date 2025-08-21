// features/home/presentation/widgets/home_card.dart
import 'package:claim_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final LinearGradient borderGradient;
  final String title;
  final String subtitle;

  const HomeCard({
    super.key,
    required this.icon,
    required this.iconBg,
    required this.borderGradient,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: Colors.transparent,
          width: 2,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            width: 2,
            color: Colors.transparent,
          ),
          gradient: borderGradient,
        ),
        child: Container(
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Colors.white,
          ),
          child: ListTile(
            leading: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: iconBg.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconBg, size: 32),
            ),
            title: CustomText(
              title: title,
              fontSize: 18,
              weight: FontWeight.bold,
            ),
            subtitle: CustomText(
              title: subtitle,
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}
