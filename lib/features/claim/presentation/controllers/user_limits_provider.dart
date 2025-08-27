// features/claim/presentation/controllers/user_limits_provider.dart
import 'package:claim_app/core/services/storage_service.dart';
import 'package:claim_app/features/claim/data/repositories/user_limits_repository_impl.dart';
import 'package:claim_app/features/claim/data/services/user_limit_service.dart';
import 'package:claim_app/features/claim/presentation/controllers/user_limits_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final userLimitsServiceProvider = Provider<UserLimitsService>((ref) {
  return UserLimitsService(
    client: http.Client(),
    storageService: StorageService(),
  );
});

final userLimitsRepositoryProvider = Provider<UserLimitsRepositoryImpl>((ref) {
  return UserLimitsRepositoryImpl();
});

final userLimitsControllerProvider = StateNotifierProvider<UserLimitsController, UserLimitsState>(
  (ref) => UserLimitsController(ref.read(userLimitsRepositoryProvider)),
);