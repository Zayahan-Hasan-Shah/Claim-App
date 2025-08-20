// features/auth/presentation/screens/profile_screen.dart
import 'package:claim_app/features/auth/data/models/user_model.dart';
import 'package:claim_app/features/auth/presentation/controllers/auth_providers.dart';
import 'package:claim_app/features/claim/data/models/claim_model.dart';
import 'package:claim_app/features/claim/presentation/controllers/claim_controller.dart';
import 'package:claim_app/features/claim/presentation/controllers/claim_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:claim_app/features/auth/presentation/controllers/auth_controller.dart';
import 'package:claim_app/navigation/route_names.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);
    final claimsState = ref.watch(claimControllerProvider);

    if (authState is! AuthAuthenticated) {
      return const Center(child: Text('Please login to view profile'));
    }

    final user = authState.user;
    final claims = claimsState is ClaimLoaded ? claimsState.claims : [];

    // Group claims by relation
    final relationsMap = <String, List<Claim>>{};
    for (final claim in claims) {
      final relationKey = getRelationDisplayName(claim.relation);
      relationsMap.putIfAbsent(relationKey, () => []).add(claim);

      // relationsMap.putIfAbsent(relationKey, () => []).add(claim);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(ref, context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildUserInfo(user),
            const SizedBox(height: 24),
            _buildRelationsSection(context, relationsMap),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfo(User user) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Personal Information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Name'),
              subtitle: Text(user.name),
            ),
            ListTile(
              leading: const Icon(Icons.email),
              title: const Text('Email'),
              subtitle: Text(user.email),
            ),
            // Add more user info as needed
          ],
        ),
      ),
    );
  }

  Widget _buildRelationsSection(
      BuildContext context, Map<String, List<Claim>> relationsMap) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('My Relations',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Divider(),
            if (relationsMap.isEmpty)
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text('No relations found'),
              )
            else
              ...relationsMap.entries.map((entry) {
                return ExpansionTile(
                  title: Text('${entry.key} (${entry.value.length})'),
                  children: entry.value.map((claim) {
                    return ListTile(
                      title: Text(claim.memberName),
                      subtitle: Text('Age: ${claim.age}'),
                      trailing: Text('\$${claim.amount.toStringAsFixed(2)}'),
                      onTap: () => _showClaimDetails(context, claim),
                    );
                  }).toList(),
                );
              }),
          ],
        ),
      ),
    );
  }

  void _showClaimDetails(BuildContext context, Claim claim) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(claim.memberName),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Relation: ${claim.relation.toString().split('.').last}'),
            Text('Type: ${claim.type.toString().split('.').last}'),
            Text('Status: ${claim.status.toString().split('.').last}'),
            if (claim.approvedAmount != null)
              Text('Approved Amount: \$${claim.approvedAmount}'),
            if (claim.deductedAmount != null)
              Text('Deducted Amount: \$${claim.deductedAmount}'),
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

  Future<void> _logout(WidgetRef ref, BuildContext context) async {
    await ref.read(authControllerProvider.notifier).logout();
    if (!context.mounted) return;
    context.goNamed(RouteNames.login);
  }
}
