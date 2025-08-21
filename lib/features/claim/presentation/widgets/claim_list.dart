// features/claim/presentation/widgets/claims_list.dart
import 'package:claim_app/features/claim/data/models/claim_model.dart';
import 'package:claim_app/features/claim/presentation/widgets/claim_card.dart';
import 'package:flutter/material.dart';

class ClaimsList extends StatelessWidget {
  final List<Claim> claims;
  final Function(Claim) onClaimTap;

  const ClaimsList({
    super.key,
    required this.claims,
    required this.onClaimTap,
  });

  @override
  Widget build(BuildContext context) {
    if (claims.isEmpty) {
      return const Center(child: Text('No claims found'));
    }

    return ListView.builder(
      itemCount: claims.length,
      itemBuilder: (context, index) {
        final claim = claims[index];
        return ClaimCard(
          claim: claim,
          onTap: () => onClaimTap(claim),
        );
      },
    );
  }
}
