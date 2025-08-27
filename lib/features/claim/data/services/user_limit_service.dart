// features/claim/data/services/user_limits_service.dart
import 'dart:convert';
import 'package:claim_app/features/claim/data/models/user_limit_model.dart';
import 'package:http/http.dart' as http;
import 'package:claim_app/core/services/api_service.dart';
import 'package:claim_app/core/services/storage_service.dart';

class UserLimitsService {
  final http.Client client;
  final StorageService storageService;

  UserLimitsService({required this.client, required this.storageService});

  Future<UserLimitsResponse> getUserLimits() async {
    final token = await storageService.getToken();
    final cardNumber = await storageService.getCardNumber();

    if (cardNumber == null) {
      throw Exception('Card number not found');
    }

    final response = await client.post(
      Uri.parse(ApiService.claimUserLimitApi),
      headers: ApiService.getHeaders(token),
      body: json.encode({
        'cardNumber': cardNumber,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      return UserLimitsResponse.fromJson(responseData);
    } else {
      throw Exception('Failed to fetch user limits: ${response.statusCode}');
    }
  }
}