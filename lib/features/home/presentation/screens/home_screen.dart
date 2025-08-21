// features/home/presentation/screens/home_screen.dart
import 'package:claim_app/core/constants/app_colors.dart';
import 'package:claim_app/core/widgets/custom_text.dart';
import 'package:claim_app/core/widgets/loading_indicator.dart';
import 'package:claim_app/features/home/data/models/home_model.dart';
import 'package:claim_app/features/home/presentation/controllers/home_controllers.dart';
import 'package:claim_app/features/home/presentation/controllers/home_provider.dart';
import 'package:claim_app/features/home/presentation/widgets/home_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Load home data when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(homeControllerProvider.notifier).loadHomeData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeControllerProvider);

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
          child: homeState is HomeLoading
              ? const Center(child: LoadingIndicator())
              : homeState is HomeError
                  ? Center(child: Text(homeState.message))
                  : homeState is HomeLoaded
                      ? _buildHomeContent(homeState.homeData, context)
                      : const SizedBox(),
        ),
      ),
    );
  }

  Widget _buildHomeContent(HomeData homeData, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeadingText(
                        '${homeData.greeting} ${homeData.userName}',
                        size: 20,
                        weight: FontWeight.bold),
                    const SizedBox(height: 4),
                    _buildHeadingText(
                      homeData.description,
                      size: 16,
                      weight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.purpleColor,
                    width: 3,
                  ),
                  color: Colors.white,
                ),
                child: const Icon(
                  Icons.person,
                  size: 36,
                  color: AppColors.purpleColor,
                ),
              ),
            ],
          ),
        ),
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
        const SizedBox(height: 24),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: homeData.cards.map((card) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: HomeCard(
                  icon: card.icon,
                  iconBg: card.iconBg,
                  borderGradient: card.borderGradient,
                  title: card.title,
                  subtitle: card.subtitle,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildHeadingText(String text, {double? size, FontWeight? weight}) {
    return CustomText(
        title: text, fontSize: size ?? 16, weight: weight ?? FontWeight.bold);
  }
}
