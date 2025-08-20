// features/family/data/repositories/family_repository.dart
import 'package:claim_app/features/family/data/models/family_member_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class FamilyRepository {
  Future<List<FamilyMember>> getFamilyMembers();
  Future<void> addFamilyMember(FamilyMember member);
}

// features/family/data/repositories/family_repository_impl.dart
class FamilyRepositoryImpl implements FamilyRepository {
  @override
  Future<List<FamilyMember>> getFamilyMembers() async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network
    return []; // Return mock data or implement actual API call
  }

  @override
  Future<void> addFamilyMember(FamilyMember member) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network
  }
}

// features/family/presentation/controllers/family_controller.dart
class FamilyController extends StateNotifier<FamilyState> {
  final FamilyRepository _repository;

  FamilyController(this._repository) : super(FamilyInitial());

  Future<void> loadFamilyMembers() async {
    state = FamilyLoading();
    try {
      final members = await _repository.getFamilyMembers();
      state = FamilyLoaded(members);
    } catch (e) {
      state = FamilyError(e.toString());
    }
  }

  Future<void> addMember(FamilyMember member) async {
    try {
      await _repository.addFamilyMember(member);
      await loadFamilyMembers(); // Refresh the list
    } catch (e) {
      state = FamilyError(e.toString());
      rethrow;
    }
  }
}

abstract class FamilyState {}
class FamilyInitial extends FamilyState {}
class FamilyLoading extends FamilyState {}
class FamilyLoaded extends FamilyState {
  final List<FamilyMember> members;
  FamilyLoaded(this.members);
}
class FamilyError extends FamilyState {
  final String message;
  FamilyError(this.message);
}