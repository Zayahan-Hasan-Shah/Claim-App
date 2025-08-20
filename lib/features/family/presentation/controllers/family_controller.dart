// Add to your providers file
import 'package:claim_app/features/family/data/repositories/family_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final familyRepositoryProvider = Provider<FamilyRepositoryImpl>((ref) {
  return FamilyRepositoryImpl();
});

final familyControllerProvider = StateNotifierProvider<FamilyController, FamilyState>((ref) {
  return FamilyController(ref.read(familyRepositoryProvider));
});