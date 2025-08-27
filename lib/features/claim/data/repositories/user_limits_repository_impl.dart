// features/claim/data/repositories/user_limits_repository_impl.dart
import 'package:claim_app/core/services/storage_service.dart';
import 'package:claim_app/features/claim/data/models/user_limit_model.dart';
import 'package:claim_app/features/claim/data/repositories/user_limit_repository.dart';
import 'package:claim_app/features/claim/data/services/user_limit_service.dart';
import 'package:http/http.dart' as http;

class UserLimitsRepositoryImpl implements UserLimitsRepository {
  final UserLimitsService _userLimitsService;

  UserLimitsRepositoryImpl()
      : _userLimitsService = UserLimitsService(
          client: http.Client(),
          storageService: StorageService(),
        );

  @override
  Future<UserLimitsResponse> getUserLimits() async {
    return await _userLimitsService.getUserLimits();
  }
}