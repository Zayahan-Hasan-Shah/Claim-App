// features/family/presentation/screens/family_member_list_screen.dart
import 'package:claim_app/features/family/presentation/controllers/family_controller.dart';
import 'package:claim_app/features/family/presentation/controllers/family_provider.dart';
import 'package:claim_app/features/family/presentation/widgets/family_member_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:claim_app/features/family/data/models/family_member_model.dart';
import 'package:claim_app/navigation/route_names.dart';
import 'package:claim_app/core/constants/app_colors.dart';
import 'package:claim_app/core/widgets/custom_text.dart';
import 'package:go_router/go_router.dart';

class FamilyMemberListScreen extends ConsumerStatefulWidget {
  const FamilyMemberListScreen({super.key});

  @override
  ConsumerState<FamilyMemberListScreen> createState() =>
      _FamilyMemberListScreenState();
}

class _FamilyMemberListScreenState
    extends ConsumerState<FamilyMemberListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(familyControllerProvider.notifier).loadFamilyMembers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final familyState = ref.watch(familyControllerProvider);

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
                  title: 'My Family',
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
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [ 
                    const Icon(Icons.add_circle, color: AppColors.purpleColor),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => context.push(RouteNames.addFamilyMember),
                      child: const CustomText(
                        title: 'Add Family Member',
                        fontSize: 16,
                        color: AppColors.purpleColor,
                        underline: true,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: familyState is FamilyLoading
                    ? const Center(child: CircularProgressIndicator())
                    : familyState is FamilyError
                        ? Center(
                            child: CustomText(
                                title: familyState.message, color: Colors.red))
                        : familyState is FamilyLoaded
                            ? ListView.separated(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                itemCount: familyState.members.length,
                                separatorBuilder: (_, __) =>
                                    const SizedBox(height: 16),
                                itemBuilder: (context, index) {
                                  final member = familyState.members[index];
                                  return FamilyMemberCard(
                                    member: member,
                                    onDetail: () =>
                                        _showMemberDetails(context, member),
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
}


void _showMemberDetails(BuildContext context, FamilyMember member) {
  final age = DateTime.now().year - member.dateOfBirth.year;
  final dobFormatted =
      '${member.dateOfBirth.day}/${member.dateOfBirth.month}/${member.dateOfBirth.year}';

  showDialog(
    context: context,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CustomText(
                title: member.name,
                fontSize: 22,
                weight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            CustomText(
                title: 'Relation: ${member.relation.displayName}',
                fontSize: 16),
            CustomText(
                title: 'Gender: ${member.gender.displayName}', fontSize: 16),
            CustomText(title: 'CNIC: ${member.cnic}', fontSize: 16),
            CustomText(title: 'Date of Birth: $dobFormatted', fontSize: 16),
            CustomText(title: 'Age: $age years', fontSize: 16),
            CustomText(
                title: 'Added on: ${member.createdAt.toLocal()}', fontSize: 16),
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
  );
}
