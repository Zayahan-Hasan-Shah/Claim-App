// features/main/presentation/screens/main_wrapper.dart
import 'package:claim_app/core/constants/app_colors.dart';
import 'package:claim_app/features/claim/presentation/screens/claim_list_screen.dart';
import 'package:claim_app/features/home/presentation/screens/home_screen.dart';
import 'package:claim_app/features/main/presentation/controller/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:claim_app/features/family/presentation/screens/family_member_list_screen.dart';
import 'package:claim_app/features/profile/presentation/screens/profile_screen.dart';

class MainWrapper extends ConsumerStatefulWidget {
  const MainWrapper({super.key});

  @override
  ConsumerState<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends ConsumerState<MainWrapper> {
  final List<Widget> _screens = [
    const HomeScreen(),
    const ClaimListScreen(),
    const FamilyMemberListScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(mainControllerProvider);
    return Scaffold(
      body: _screens[currentIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(28),
            topRight: Radius.circular(28),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 12,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          selectedItemColor: AppColors.purpleColor,
          unselectedItemColor: AppColors.grey,
          showUnselectedLabels: true,
          onTap: (index) =>
              ref.read(mainControllerProvider.notifier).setIndex(index),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.description_outlined),
              label: 'My Claims',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.groups_outlined),
              label: 'My Family',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
