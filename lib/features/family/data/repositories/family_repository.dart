// features/family/data/repositories/family_repository.dart
import 'package:claim_app/features/family/data/models/family_member_model.dart';

abstract class FamilyRepository {
  Future<List<FamilyMember>> getFamilyMembers();
  Future<void> addFamilyMember(FamilyMember member);
}
