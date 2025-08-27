// import 'dart:convert';

// import 'package:claim_app/core/services/api_service.dart';
// import 'package:claim_app/features/claim/data/models/claim_model.dart';
// import 'package:claim_app/features/claim/data/models/user_limit_model.dart';
// import 'package:http/http.dart' as http;

// abstract class ClaimService {
//   Future<List<Claim>> getClaims();
//   Future<void> submitClaims(List<Claim> claims);
//   Future<List<UserLimit>> getUserLimits(String cardNumber, String token);
// }

// class ApiClaimService implements ClaimService {
//   final http.Client client;
//   ApiClaimService({required this.client});

//   @override
//   Future<List<Claim>> getClaims() async {
//     // Implement actual API call to fetch claims
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
//   Future<List<UserLimit>> getUserLimits(String cardNumber, String token) async {
//     final response = await http.post(
//       Uri.parse(ApiService.claimUserLimitApi),
//       headers: {
//         ...ApiService.headers,
//         'Authorization': 'Bearer $token', // Access token
//       },
//       body: jsonEncode({'cardNumber': cardNumber}),
//     );
//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body)['data'];
//       final List<dynamic> limitsJson = data['limits'];
//       return limitsJson.map((json) => UserLimit.fromJson(json)).toList();
//     } else {
//       throw Exception('Failed to load user limits: ${response.statusCode}');
//     }
//   }
// }
