import 'package:claim_app/core/providers/app_providers.dart';
import 'package:claim_app/features/auth/presentation/controllers/auth_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:claim_app/core/services/storage_service.dart';
import 'package:claim_app/features/auth/data/repositories/auth_repository_impl.dart';

final storageServiceProvider = Provider<StorageService>((ref) {
  return StorageService();
});

final authRepositoryProvider = Provider<AuthRepositoryImpl>((ref) {
  final storageService = ref.read(storageServiceProvider);
  final apiService = ref.read(apiServiceProvider);
  return AuthRepositoryImpl(
    apiService: apiService,
    storageService: storageService,
  );
});

final authControllerProvider = StateNotifierProvider<AuthController, AuthState>(
  (ref) => AuthController(ref.read(authRepositoryProvider)),
);
