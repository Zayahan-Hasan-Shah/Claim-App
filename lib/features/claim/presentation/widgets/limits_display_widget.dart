// features/claim/presentation/widgets/limits_display_widget.dart
import 'package:claim_app/core/constants/app_colors.dart';
import 'package:claim_app/core/widgets/custom_text.dart';
import 'package:claim_app/features/claim/data/models/user_limits_model.dart';
import 'package:flutter/material.dart';

class LimitsDisplayWidget extends StatelessWidget {
  final UserLimitsResponse limits;

  const LimitsDisplayWidget({super.key, required this.limits});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(
              title: 'Insurance Limits',
              fontSize: 18,
              weight: FontWeight.bold,
              color: AppColors.purpleColor,
            ),
            const SizedBox(height: 16),
            _buildPolicyInfo(),
            const SizedBox(height: 16),
            _buildLimitsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildPolicyInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          title: 'Client: ${limits.data.clientName}',
          fontSize: 14,
          weight: FontWeight.w600,
        ),
        const SizedBox(height: 4),
        CustomText(
          title: 'Policy Period: ${limits.data.policyStartDate} to ${limits.data.policyEndDate}',
          fontSize: 12,
          color: Colors.grey[600],
        ),
      ],
    );
  }

  Widget _buildLimitsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(
          title: 'Available Limits:',
          fontSize: 14,
          weight: FontWeight.w600,
        ),
        const SizedBox(height: 8),
        ...limits.data.limits.map((limit) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CustomText(
                  title: limit.servicename,
                  fontSize: 12,
                ),
              ),
              CustomText(
                title: 'Rs. ${limit.dtClpackagelimit1.toStringAsFixed(0)}',
                fontSize: 12,
                weight: FontWeight.bold,
                color: AppColors.purpleColor,
              ),
            ],
          ),
        )),
      ],
    );
  }
}