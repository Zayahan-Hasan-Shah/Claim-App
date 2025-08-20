import 'package:claim_app/features/claim/data/models/claim_model.dart';
import 'package:flutter/material.dart';

class ClaimCard extends StatelessWidget {
  final Claim claim;
  final VoidCallback onTap;

  const ClaimCard({
    super.key,
    required this.claim,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(claim.memberName),
        subtitle: Text(
          '${claim.type.toString().split('.').last} - \$${claim.amount}',
        ),
        trailing: _buildStatusIndicator(claim.status),
        onTap: onTap,
      ),
    );
  }

  Widget _buildStatusIndicator(ClaimStatus status) {
    Color color;
    switch (status) {
      case ClaimStatus.pending:
        color = Colors.orange;
        break;
      case ClaimStatus.waitingApproval:
        color = Colors.blue;
        break;
      case ClaimStatus.approved:
        color = Colors.green;
        break;
      case ClaimStatus.rejected:
        color = Colors.red;
        break;
    }

    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}