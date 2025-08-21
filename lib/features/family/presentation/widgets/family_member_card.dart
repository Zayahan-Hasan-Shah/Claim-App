
import 'package:claim_app/core/constants/app_colors.dart';
import 'package:claim_app/core/widgets/custom_text.dart';
import 'package:claim_app/features/family/data/models/family_member_model.dart';
import 'package:flutter/material.dart';

class FamilyMemberCard extends StatelessWidget {
  final FamilyMember member;
  final VoidCallback onDetail;
  const FamilyMemberCard({super.key, required this.member, required this.onDetail});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    title: member.name,
                    fontSize: 18,
                    weight: FontWeight.bold,
                  ),
                  const SizedBox(height: 4),
                  CustomText(
                    title:
                        'Relation: ${member.relation.displayName}/${member.gender.displayName}',
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ],
              ),
            ),
            OutlinedButton(
              onPressed: onDetail,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.purpleColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Detail',
                  style: TextStyle(color: AppColors.purpleColor)),
            ),
          ],
        ),
      ),
    );
  }
}