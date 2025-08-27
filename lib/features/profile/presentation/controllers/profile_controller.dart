// features/profile/presentation/controllers/profile_controller.dart
import 'package:claim_app/features/auth/data/models/user_model.dart';
import 'package:claim_app/features/auth/presentation/controllers/auth_providers.dart';
import 'package:claim_app/features/claim/data/models/claim_model.dart';
import 'package:claim_app/features/claim/data/models/user_limit_model.dart';
import 'package:claim_app/features/claim/presentation/controllers/claim_controller.dart';
import 'package:claim_app/features/claim/presentation/controllers/claim_provider.dart';
import 'package:claim_app/features/claim/presentation/controllers/user_limits_controller.dart';
import 'package:claim_app/features/claim/presentation/controllers/user_limits_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:claim_app/features/auth/presentation/controllers/auth_controller.dart';

class ProfileController {
  final Ref ref;
  
  ProfileController(this.ref);

  User get user {
    final authState = ref.read(authControllerProvider);
    if (authState is! AuthAuthenticated) {
      throw Exception('User not authenticated');
    }
    return authState.user;
  }

  // Map<String, List<Claim>> getRelationsMap() {
  //   // final claimsState = ref.read(claimControllerProvider);
  //   final claimsState = ref.read(userLimitsControllerProvider);
  //   final List<UserLimitsData> claims = claimsState is UserLimitsLoaded ? List<UserLimitsData>.from(claimsState.limits) : <Claim>[];
    
  //   final relationsMap = <String, List<Claim>>{};
  //   for (final claim in claims) {
  //     final relation = claim.limits.;
  //     relationsMap.putIfAbsent(relation, () => []).add(claim);
  //   }
  //   return relationsMap;
  // }
}

final profileControllerProvider = Provider<ProfileController>((ref) {
  return ProfileController(ref);
});