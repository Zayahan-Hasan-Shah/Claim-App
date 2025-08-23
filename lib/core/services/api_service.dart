// core/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:claim_app/core/constants/api_constants.dart';

class ApiService {
  final String baseUrl;
  final http.Client client;

  ApiService({required this.baseUrl, required this.client});

  Future<http.Response> post(
    String endpoint, {
    Map<String, dynamic>? body,
    String? token,
  }) async {
    final headers = {
      ApiConstants.contentType: ApiConstants.applicationJson,
    };

    if (token != null) {
      headers[ApiConstants.authorization] = '${ApiConstants.bearer} $token';
    }

    final response = await client.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers,
      body: body != null ? jsonEncode(body) : null,
    );

    return response;
  }

  Future<http.Response> get(
    String endpoint, {
    String? token,
  }) async {
    final headers = {
      ApiConstants.contentType: ApiConstants.applicationJson,
    };

    if (token != null) {
      headers[ApiConstants.authorization] = '${ApiConstants.bearer} $token';
    }

    final response = await client.get(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers,
    );

    return response;
  }
}