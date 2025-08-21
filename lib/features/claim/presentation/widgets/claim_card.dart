
import 'package:claim_app/core/constants/app_colors.dart';
import 'package:claim_app/core/widgets/custom_text.dart';
import 'package:claim_app/features/claim/data/models/claim_model.dart';
import 'package:flutter/material.dart';

class ClaimCard extends StatelessWidget {
  final Claim claim;
  final VoidCallback onTap;
  const ClaimCard({super.key, required this.claim, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
            width: 1.5,
            color: AppColors.warning,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      title: 'ID-${claim.id}',
                      fontSize: 16,
                      weight: FontWeight.bold,
                    ),
                    const SizedBox(height: 4),
                    CustomText(
                      title:
                          '${_formatDate(claim.date)} - ${_claimTypeToString(claim.type)}',
                      fontSize: 14,
                      color: Colors.black87,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const CustomText(
                    title: 'Amount',
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                  CustomText(
                    title: 'Rs.${claim.amount.toStringAsFixed(0)}',
                    fontSize: 16,
                    color: AppColors.purpleColor,
                    weight: FontWeight.bold,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    // Example: 10-June-2025
    final months = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return '${date.day}-${months[date.month]}-${date.year}';
  }

  String _claimTypeToString(ClaimType type) {
    switch (type) {
      case ClaimType.hospitality:
        return 'Hospital';
      case ClaimType.opd:
        return 'OPD';
      case ClaimType.dentist:
        return 'Dental';
      default:
        return type.toString().split('.').last;
    }
  }
}
