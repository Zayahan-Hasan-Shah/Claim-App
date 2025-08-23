
// features/family/presentation/controllers/family_controller.dart
import 'package:claim_app/features/family/data/models/family_member_model.dart';
import 'package:claim_app/features/family/data/repositories/family_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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