import 'package:claim_app/features/claim/data/models/user_limit_model.dart';
import '../models/claim_model.dart';

abstract class ClaimRepository {
  Future<List<Claim>> getClaims();
  Future<void> submitClaims(List<Claim> claims);
  Future<List<UserLimitsResponse>> getUserLimits(String cardNumber, String token);
}