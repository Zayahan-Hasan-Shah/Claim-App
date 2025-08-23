// features/family/data/repositories/family_repository_impl.dart
import 'dart:convert';
import 'package:claim_app/core/constants/api_constants.dart';
import 'package:claim_app/core/services/api_service.dart';
import 'package:claim_app/core/services/storage_service.dart';
import 'package:claim_app/features/family/data/models/family_member_model.dart';
import 'family_repository.dart';

class FamilyRepositoryImpl implements FamilyRepository {
  final ApiService _apiService;
  final StorageService _storageService;

  FamilyRepositoryImpl({
    required ApiService apiService,
    required StorageService storageService,
  })  : _apiService = apiService,
        _storageService = storageService;

  @override
  Future<List<FamilyMember>> getFamilyMembers() async {
    try {
      final token = await _storageService.getToken();
      if (token == null) {
        throw Exception('Not authenticated');
      }

      final response = await _apiService.get(
        ApiConstants.familyMembers,
        token: token,
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        return responseData.map((json) => FamilyMember.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load family members: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error loading family members: $e');
    }
  }

  @override
  Future<void> addFamilyMember(FamilyMember member) async {
    try {
      final token = await _storageService.getToken();
      if (token == null) {
        throw Exception('Not authenticated');
      }

      final response = await _apiService.post(
        ApiConstants.familyMembers,
        body: member.toJson(),
        token: token,
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to add family member: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error adding family member: $e');
    }
  }
}