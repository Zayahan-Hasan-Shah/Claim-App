// features/claim/presentation/screens/claim_list_screen.dart
import 'package:claim_app/core/widgets/loading_indicator.dart';
import 'package:claim_app/features/claim/data/models/claim_model.dart';
import 'package:claim_app/features/claim/presentation/controllers/claim_controller.dart';
import 'package:claim_app/features/claim/presentation/controllers/claim_provider.dart';
import 'package:claim_app/features/claim/presentation/widgets/claim_card.dart';
import 'package:claim_app/navigation/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:claim_app/core/constants/app_colors.dart';
import 'package:claim_app/core/widgets/custom_text.dart';

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
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.brightYellowColor,
              AppColors.lightYellowColor,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Center(
                child: CustomText(
                  title: 'Claims List',
                  fontSize: 22,
                  weight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.warning, width: 1.5),
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 12),
                      const Icon(Icons.search, color: Colors.grey),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search...',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.calendar_today_outlined,
                            color: AppColors.purpleColor),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomText(
                      title: '1-10 of 24 items',
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                    Row(
                      children: [
                        const Icon(Icons.add_circle,
                            color: AppColors.purpleColor),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () => Navigator.of(context)
                              .pushNamed(RouteNames.addClaim),
                          child: _buildHeadingText(
                            'Add Claim',
                            size: 14,
                            weight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: claimState is ClaimLoading
                    ? const Center(child: LoadingIndicator())
                    : claimState is ClaimError
                        ? Center(
                            child: CustomText(
                                title: claimState.message, color: Colors.red))
                        : claimState is ClaimLoaded
                            ? ListView.separated(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                itemCount: claimState.claims.length,
                                separatorBuilder: (_, __) =>
                                    const SizedBox(height: 16),
                                itemBuilder: (context, index) {
                                  final claim = claimState.claims[index];
                                  return ClaimCard(
                                    claim: claim,
                                    onTap: () =>
                                        _showClaimDetails(context, claim),
                                  );
                                },
                              )
                            : const SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeadingText(String text, {double? size, FontWeight? weight}) {
    return CustomText(
        title: text, fontSize: size ?? 16, weight: weight ?? FontWeight.bold);
  }

  void _showClaimDetails(BuildContext context, Claim claim) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: _buildHeadingText(
                    'Claim Details',
                    size: 20,
                    weight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                _buildHeadingText('ID: ${claim.id}', size: 16),
                _buildHeadingText('Member: ${claim.memberName}', size: 16),
                _buildHeadingText(
                    'Status: ${_getStatusDisplayName(claim.status)}',
                    size: 16),
                _buildHeadingText(
                    'Relation: ${getRelationDisplayName(claim.relation)}',
                    size: 16),
                _buildHeadingText(
                    'Type: ${claim.type.toString().split('.').last}',
                    size: 16),
                _buildHeadingText(
                    'Amount: Rs.${claim.amount.toStringAsFixed(0)}',
                    size: 16),
                _buildHeadingText(
                    'Date: ${claim.date.day}-${claim.date.month}-${claim.date.year}',
                    size: 16),
                _buildHeadingText(
                    claim.hospitalName != null
                        ? 'Hospital: ${claim.hospitalName}'
                        : '',
                    size: 16),
                _buildHeadingText(
                    claim.amount != 0
                        ? 'Approved: Rs.${claim.approvedAmount}'
                        : '',
                    size: 16),
                _buildHeadingText(
                    claim.deductedAmount != 0
                        ? 'Deducted: Rs.${claim.deductedAmount}'
                        : '',
                    size: 16),
                const SizedBox(height: 24),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 120,
                    height: 48,
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.purpleColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Close',
                          style: TextStyle(color: AppColors.purpleColor)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getStatusDisplayName(ClaimStatus status) {
    return status.toString().split('.').last;
  }
}
