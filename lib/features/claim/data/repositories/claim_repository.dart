import '../models/claim_model.dart';

abstract class ClaimRepository {
  Future<List<Claim>> getClaims();
  Future<void> submitClaims(List<Claim> claims);
}