// core/providers/app_providers.dart
import 'package:claim_app/features/family/data/repositories/famil_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:claim_app/core/constants/api_constants.dart';
import 'package:claim_app/core/services/api_service.dart';
import 'package:claim_app/core/services/storage_service.dart';
import 'package:claim_app/features/auth/data/repositories/auth_repository_impl.dart';

// API Service Provider
final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService(
    baseUrl: ApiConstants.baseUrl,
    client: http.Client(),
  );
});

// Storage Service Provider
final storageServiceProvider = Provider<StorageService>((ref) {
  return StorageService();
});

// Auth Repository Provider
final authRepositoryProvider = Provider<AuthRepositoryImpl>((ref) {
  return AuthRepositoryImpl(
    apiService: ref.read(apiServiceProvider),
    storageService: ref.read(storageServiceProvider),
  );
});

// Family Repository Provider
final familyRepositoryProvider = Provider<FamilyRepositoryImpl>((ref) {
  return FamilyRepositoryImpl(
    apiService: ref.read(apiServiceProvider),
    storageService: ref.read(storageServiceProvider),
  );
});

// Export all providers for easy access
final List<Override> appProviders = [
  apiServiceProvider,
  storageServiceProvider,
  authRepositoryProvider,
  familyRepositoryProvider,
];