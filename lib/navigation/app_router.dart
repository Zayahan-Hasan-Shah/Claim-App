import 'package:claim_app/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:claim_app/features/claim/presentation/screens/add_claim_screen.dart';
import 'package:claim_app/features/claim/presentation/screens/claim_list_screen.dart';
import 'package:claim_app/features/family/presentation/screens/add_family_member_screen.dart';
import 'package:claim_app/features/family/presentation/screens/family_member_list_screen.dart';
import 'package:claim_app/features/main/presentation/screens/main_wrapper.dart';
import 'package:claim_app/features/onboarding/presentation/screens/splash_screen.dart';
import 'package:claim_app/features/profile/presentation/screens/profile_screen.dart';
import 'package:claim_app/navigation/route_names.dart';
import 'package:go_router/go_router.dart';
import 'package:claim_app/features/auth/presentation/screens/login_screen.dart';
import 'package:claim_app/features/onboarding/presentation/screens/onboarding_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: RouteNames.splash,
    routes: [
      GoRoute(
        path: RouteNames.splash,
        name: RouteNames.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: RouteNames.mainWrapper,
        name: RouteNames.mainWrapper,
        builder: (context, state) => const MainWrapper(),
      ),
      GoRoute(
        path: RouteNames.onboarding,
        name: RouteNames.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: RouteNames.login,
        name: RouteNames.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RouteNames.forgotPassword,
        name: RouteNames.forgotPassword,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: RouteNames.claimList,
        name: RouteNames.claimList,
        builder: (context, state) => const ClaimListScreen(),
      ),
      GoRoute(
        path: RouteNames.addClaim,
        name: RouteNames.addClaim,
        builder: (context, state) => const AddClaimScreen(),
      ),
      GoRoute(
        path: RouteNames.profileScreen,
        name: RouteNames.profileScreen,
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: RouteNames.familyMembers,
        name: RouteNames.familyMembers,
        builder: (context, state) => const FamilyMemberListScreen(),
      ),
      GoRoute(
        path: RouteNames.addFamilyMember,
        name: RouteNames.addFamilyMember,
        builder: (context, state) => const AddFamilyMemberScreen(),
      ),
    ],
  );
}
