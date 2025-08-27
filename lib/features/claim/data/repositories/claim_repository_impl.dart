// import 'dart:developer';

// import 'package:claim_app/core/services/claim_service.dart';
// import 'package:claim_app/core/services/storage_service.dart';
// import 'package:claim_app/features/claim/data/models/user_limit_model.dart';
// import 'package:claim_app/features/claim/data/services/user_limit_service.dart';
// import 'package:http/http.dart' as http;

// import '../models/claim_model.dart';
// import 'claim_repository.dart';

// class ClaimRepositoryImpl implements ClaimRepository {
//   final StorageService _storageService;
//   final ClaimService _claimService;
//   final UserLimitsService _userLimitsService;

//   ClaimRepositoryImpl()
//       : _storageService = StorageService(),
//         _userLimitsService = UserLimitsService(
//           client: http.Client(),
//           storageService: StorageService(),
//         ),
//         _claimService = ApiClaimService(client: http.Client());

//   @override
//   Future<List<Claim>> getClaims() async {
//     await Future.delayed(const Duration(seconds: 1));
//     return [
//       Claim(
//         id: '1',
//         memberName: 'John Doe',
//         relation: RelationType.son,
//         age: 30,
//         cnic: '12345-6789012-3',
//         address: '123 Street, City',
//         type: ClaimType.hospitality,
//         amount: 50000,
//         hospitalName: 'City Hospital',
//         admissionDate: DateTime(2023, 1, 1),
//         dischargeDate: DateTime(2023, 1, 10),
//         date: DateTime(2023, 1, 15),
//         billPath: 'path/to/bill',
//         status: ClaimStatus.approved,
//         approvedAmount: 45000,
//         deductedAmount: 5000,
//         submittedAt: DateTime(2023, 1, 15),
//         processedAt: DateTime(2023, 1, 20),
//       ),
//     ];
//   }

//   @override
//   Future<void> submitClaims(List<Claim> claims) async {
//     // Implement actual API call to submit multiple claims
//     await Future.delayed(const Duration(seconds: 1));

//     // In a real app, this would be an API call that accepts a list of claims
//     // For demo purposes, we'll just simulate success
//   }

//   @override
//   Future<List<UserLimitsResponse>> getUserLimits(String cardNumber, String token) async {
//     try {
//       final res = await _claimService.getUserLimits(cardNumber, token);
//       return res;
//     } on http.ClientException catch (e) {
//       log('HTTP Client Exception: ${e.message}');
//       log('Stack Trace: ${e.uri}');
//       throw Exception('Network error: ${e.message}');
//     } on FormatException catch (e) {
//       log('Format Exception: ${e.message}');
//       log('Stack Trace: ${e.source}');
//       throw Exception('Invalid response format: $e');
//     } catch (e) {
//       log('General Exception: $e');
//       log('Stack Trace: ${StackTrace.current}');
//       throw Exception('Login failed: $e');
//     }
//   }
// }
