import 'package:claim_app/features/claim/data/repositories/claim_repository_impl.dart';
import 'package:claim_app/features/claim/presentation/controllers/claim_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final claimRepositoryProvider = Provider<ClaimRepositoryImpl>((ref) {
  return ClaimRepositoryImpl();
});

final claimControllerProvider = StateNotifierProvider<ClaimController, ClaimState>(
  (ref) => ClaimController(ref.read(claimRepositoryProvider)),
);