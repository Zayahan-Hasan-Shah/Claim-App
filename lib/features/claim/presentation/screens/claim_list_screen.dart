// features/claim/presentation/screens/claim_list_screen.dart
import 'package:claim_app/core/widgets/custom_app_bar.dart';
import 'package:claim_app/core/widgets/logout_confirmation.dart';
import 'package:claim_app/features/auth/presentation/controllers/auth_providers.dart';
import 'package:claim_app/features/claim/data/models/claim_model.dart';
import 'package:claim_app/features/claim/presentation/controllers/claim_controller.dart';
import 'package:claim_app/features/claim/presentation/controllers/claim_provider.dart';
import 'package:claim_app/features/claim/presentation/widgets/claim_details_dailog.dart';
import 'package:claim_app/features/claim/presentation/widgets/claim_list.dart';
import 'package:claim_app/navigation/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ClaimListScreen extends ConsumerStatefulWidget {
  const ClaimListScreen({super.key});

  @override
  ConsumerState<ClaimListScreen> createState() => _ClaimListScreenState();
}

class _ClaimListScreenState extends ConsumerState<ClaimListScreen> {
  @override
  void initState() {
    super.initState();
    _loadClaims();
  }

  void _loadClaims() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(claimControllerProvider.notifier).fetchClaims();
    });
  }

  @override
  Widget build(BuildContext context) {
    final claimState = ref.watch(claimControllerProvider);

    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(claimState),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  CustomAppBar _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: 'My Claims',
      trailingWidget: IconButton(
        icon: const Icon(Icons.logout),
        onPressed: () => _handleLogout(context),
      ),
    );
  }

  Widget _buildBody(ClaimState claimState) {
    if (claimState is ClaimLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (claimState is ClaimError) {
      return Center(child: Text(claimState.message));
    }

    if (claimState is ClaimLoaded) {
      return ClaimsList(
        claims: claimState.claims,
        onClaimTap: _showClaimDetails,
      );
    }

    return const SizedBox();
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => context.push(RouteNames.addClaim),
      child: const Icon(Icons.add),
    );
  }

  Future<void> _handleLogout(BuildContext context) async {
    final shouldLogout = await showLogoutConfirmationDialog(context);

    if (shouldLogout ?? false) {
      await _logout(ref, context);
    }
  }

  Future<void> _logout(WidgetRef ref, BuildContext context) async {
    try {
      await ref.read(authControllerProvider.notifier).logout();
      if (!context.mounted) return;
      context.goNamed(RouteNames.login);
    } catch (e) {
      if (!context.mounted) return;
      _showErrorSnackBar(context, 'Logout failed: ${e.toString()}');
    }
  }

  void _showClaimDetails(Claim claim) {
    showDialog(
      context: context,
      builder: (context) => ClaimDetailsDialog(claim: claim),
    );
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
