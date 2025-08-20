// features/claim/presentation/widgets/claim_details_dialog.dart
import 'package:claim_app/core/widgets/custom_text.dart';
import 'package:claim_app/features/claim/data/models/claim_model.dart';
import 'package:flutter/material.dart';

class ClaimDetailsDialog extends StatelessWidget {
  final Claim claim;

  const ClaimDetailsDialog({super.key, required this.claim});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(claim.memberName),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(title: 'Status: ${_getStatusDisplayName(claim.status)}', fontSize: 16,),
          Text('Amount: \$${claim.amount.toStringAsFixed(2)}'),
          if (claim.approvedAmount != null)
            CustomText(title:'Approved Amount: \$${claim.approvedAmount!.toStringAsFixed(2)}', fontSize: 16,),
          if (claim.deductedAmount != null)
            CustomText(title:'Deducted Amount: \$${claim.deductedAmount!.toStringAsFixed(2)}', fontSize: 16,),
          if (claim.rejectionReason != null)
            CustomText(title:'Reason: ${claim.rejectionReason}', fontSize: 16,),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child:  const CustomText(title:'Close', fontSize: 16, color: Colors.blue,),
        ),
      ],
    );
  }

  String _getStatusDisplayName(ClaimStatus status) {
    return status.toString().split('.').last;
  }
}