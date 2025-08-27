// features/claim/presentation/screens/user_limits_screen.dart
import 'package:claim_app/core/constants/app_colors.dart';
import 'package:claim_app/core/widgets/custom_text.dart';
import 'package:claim_app/core/widgets/loading_indicator.dart';
import 'package:claim_app/features/claim/data/models/user_limit_model.dart';
import 'package:claim_app/features/claim/presentation/controllers/user_limits_controller.dart';
import 'package:claim_app/features/claim/presentation/controllers/user_limits_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserLimitsScreen extends ConsumerWidget {
  const UserLimitsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final limitsState = ref.watch(userLimitsControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Insurance Limits'),
        backgroundColor: AppColors.brightYellowColor,
      ),
      body: Container(
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
        child: _buildContent(limitsState, ref),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(userLimitsControllerProvider.notifier).fetchUserLimits(),
        child: const Icon(Icons.refresh),
      ),
    );
  }

  Widget _buildContent(UserLimitsState state, WidgetRef ref) {
    if (state is UserLimitsInitial) {
      return const Center(
        child: CustomText(
          title: 'Tap refresh to load limits',
          fontSize: 16,
          color: Colors.black54,
        ),
      );
    } else if (state is UserLimitsLoading) {
      return const Center(child: LoadingIndicator());
    } else if (state is UserLimitsError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            CustomText(
              title: state.message,
              fontSize: 16,
              color: Colors.red,
              align: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => ref.read(userLimitsControllerProvider.notifier).fetchUserLimits(),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    } else if (state is UserLimitsLoaded) {
      return _buildLimitsList(state.limits);
    } else {
      return const Center(child: Text('Unknown state'));
    }
  }

  Widget _buildLimitsList(UserLimitsResponse limits) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Policy Information
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title: limits.data.clientName,
                    fontSize: 18,
                    weight: FontWeight.bold,
                    color: AppColors.purpleColor,
                  ),
                  const SizedBox(height: 8),
                  CustomText(
                    title: 'Policy Period: ${limits.data.policyStartDate} to ${limits.data.policyEndDate}',
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Limit Types
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(
                    title: 'Limit Types',
                    fontSize: 16,
                    weight: FontWeight.bold,
                  ),
                  const SizedBox(height: 8),
                  ...limits.data.limitTypes.entries.map((entry) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: AppColors.purpleColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: CustomText(
                              title: entry.key,
                              fontSize: 12,
                              color: Colors.white,
                              weight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: CustomText(
                            title: entry.value,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  )),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Service Limits
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(
                    title: 'Service Limits',
                    fontSize: 16,
                    weight: FontWeight.bold,
                  ),
                  const SizedBox(height: 8),
                  ...limits.data.limits.map((limit) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            title: limit.servicename,
                            fontSize: 16,
                            weight: FontWeight.bold,
                            color: AppColors.purpleColor,
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                title: 'Service Code: ${limit.srvcode}',
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                              CustomText(
                                title: 'Type: ${limit.hptype}',
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          CustomText(
                            title: limit.hpdesc,
                            fontSize: 14,
                            color: Colors.grey[700],
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.brightYellowColor,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: CustomText(
                              title: 'Rs. ${limit.dtClpackagelimit1.toStringAsFixed(0)}',
                              fontSize: 16,
                              weight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}