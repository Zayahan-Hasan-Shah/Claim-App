// features/home/data/models/home_model.dart
import 'package:claim_app/core/constants/app_colors.dart';
import 'package:claim_app/navigation/route_names.dart';
import 'package:flutter/material.dart';

class HomeData {
  final String userName;
  final String greeting;
  final String description;
  final List<HomeCardItem> cards;

  HomeData({
    required this.userName,
    required this.greeting,
    required this.description,
    required this.cards,
  });

  factory HomeData.dummy() {
    return HomeData(
      userName: 'Mr. Abdul Rashid',
      greeting: 'Hello!',
      description: 'Lorem ipsum dolor sit amet,\nconsectetur adipiscing elit.',
      cards: [
        HomeCardItem(
          id: 'claims',
          icon: Icons.description_outlined,
          iconBg: AppColors.warning,
          borderGradient: const LinearGradient(
            colors: [AppColors.warning, AppColors.purpleColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          title: 'My Claims',
          subtitle: 'Manage and track your insurance claims',
          routeName: RouteNames.claimList,
        ),
        HomeCardItem(
          id: 'family',
          icon: Icons.groups_outlined,
          iconBg: AppColors.purpleColor,
          borderGradient: const LinearGradient(
            colors: [AppColors.purpleColor, AppColors.warning],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          title: 'My Family',
          subtitle: 'Manage your family members and their details',
          routeName: RouteNames.familyMembers,
        ),
      ],
    );
  }
}

class HomeCardItem {
  final String id;
  final IconData icon;
  final Color iconBg;
  final LinearGradient borderGradient;
  final String title;
  final String subtitle;
  final String routeName;

  HomeCardItem({
    required this.id,
    required this.icon,
    required this.iconBg,
    required this.borderGradient,
    required this.title,
    required this.subtitle,
    required this.routeName,
  });
}