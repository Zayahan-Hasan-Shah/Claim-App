import 'package:claim_app/core/widgets/claim_card.dart';
import 'package:claim_app/features/auth/presentation/controllers/auth_providers.dart';
import 'package:claim_app/features/claim/data/models/claim_model.dart';
import 'package:claim_app/features/claim/presentation/controllers/claim_controller.dart';
import 'package:claim_app/features/claim/presentation/controllers/claim_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:claim_app/navigation/route_names.dart';

class ClaimListScreen extends ConsumerStatefulWidget {
  const ClaimListScreen({super.key});

  @override
  ConsumerState<ClaimListScreen> createState() => _ClaimListScreenState();
}

class _ClaimListScreenState extends ConsumerState<ClaimListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(claimControllerProvider.notifier).fetchClaims();
    });
  }

  @override
  Widget build(BuildContext context) {
    final claimState = ref.watch(claimControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Claims'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              final shouldLogout = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Confirm Logout'),
                  content: const Text('Are you sure you want to logout?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Logout'),
                    ),
                  ],
                ),
              );

              if (shouldLogout ?? false) {
                _logout(ref, context);
              }
            },
          ),
        ],
      ),
      body: claimState is ClaimLoading
          ? const Center(child: CircularProgressIndicator())
          : claimState is ClaimLoaded
              ? claimState.claims.isEmpty
                  ? const Center(child: Text('No claims found'))
                  : ListView.builder(
                      itemCount: claimState.claims.length,
                      itemBuilder: (context, index) {
                        final claim = claimState.claims[index];
                        return ClaimCard(
                          claim: claim,
                          onTap: () => _showClaimDetails(claim),
                        );
                      },
                    )
              : claimState is ClaimError
                  ? Center(child: Text(claimState.message))
                  : const SizedBox(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(RouteNames.addClaim);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _logout(WidgetRef ref, BuildContext context) async {
    try {
      await ref.read(authControllerProvider.notifier).logout();
      if (!context.mounted) return;
      context.goNamed(RouteNames.login);
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Logout failed: ${e.toString()}')),
      );
    }
  }

  void _showClaimDetails(Claim claim) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(claim.memberName),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Status: ${claim.status.toString().split('.').last}'),
            Text('Amount: \$${claim.amount}'),
            if (claim.approvedAmount != null)
              Text('Approved Amount: \$${claim.approvedAmount}'),
            if (claim.deductedAmount != null)
              Text('Deducted Amount: \$${claim.deductedAmount}'),
            if (claim.rejectionReason != null)
              Text('Reason: ${claim.rejectionReason}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
