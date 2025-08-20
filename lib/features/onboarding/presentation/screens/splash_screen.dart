// features/splash/presentation/screens/splash_screen.dart
import 'package:claim_app/core/constants/app_colors.dart';
import 'package:claim_app/features/auth/presentation/controllers/auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:claim_app/features/auth/presentation/controllers/auth_controller.dart';
import 'package:claim_app/navigation/route_names.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Use Future.microtask to run after the build completes
    Future.microtask(() => _initializeApp(ref, context));

    return const Scaffold(
      body: Center(
        child: CircleAvatar(
          radius: 50,
          backgroundColor: AppColors.background,
          child: Icon(
            Icons.biotech,
            size: 50,
            color: AppColors.info,
          ),
        ),
      ),
    );
  }

  Future<void> _initializeApp(WidgetRef ref, BuildContext context) async {
    try {
      // Initialize authentication state
      await ref.read(authControllerProvider.notifier).initializeApp();

      // Check onboarding status
      final prefs = await SharedPreferences.getInstance();
      final onboardingCompleted =
          prefs.getBool('onboarding_completed') ?? false;

      // Get current auth state
      final authState = ref.read(authControllerProvider);

      // Navigate based on state
      if (!context.mounted) return;

      if (authState is AuthAuthenticated) {
        Navigator.pushReplacementNamed(context, RouteNames.claimList);
      } else {
        Navigator.pushReplacementNamed(
          context,
          onboardingCompleted ? RouteNames.login : RouteNames.onboarding,
        );
      }
    } catch (e) {
      if (!context.mounted) return;
      context.go('/login');
    }
  }
}
