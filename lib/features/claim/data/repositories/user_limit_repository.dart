// features/claim/data/repositories/user_limits_repository.dart
import 'package:claim_app/features/claim/data/models/user_limit_model.dart';

abstract class UserLimitsRepository {
  Future<UserLimitsResponse> getUserLimits();
}