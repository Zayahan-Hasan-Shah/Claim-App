// services/auth_service.dart
import 'dart:convert';
import 'dart:developer';
import 'package:claim_app/core/services/api_service.dart';
import 'package:http/http.dart' as http;
import 'package:claim_app/features/auth/data/models/user_model.dart';

abstract class AuthService {
  Future<User> login(String username, String password);
  Future<void> forgotPassword(String username);
  Future<User> getUserProfile(String token);
}

class ApiAuthService implements AuthService {
  final http.Client client;

  ApiAuthService({required this.client});

  @override
  Future<User> login(String username, String password) async {
    final response = await client.post(
      Uri.parse(ApiService.loginApi),
      headers: ApiService.headers,
      body: json.encode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      log('Login successful');
      log('API: ${ApiService.loginApi}');
      log('Login Response: ${response.body}');
      log('Login Response (decoded): ${json.decode(response.body)}');
      final Map<String, dynamic> responseData = json.decode(response.body);
      return User.fromJson(responseData);
    } else if (response.statusCode == 401) {
      log('API: ${ApiService.loginApi}');
      log('Unauthorized: ${response.body}');
      log('Unauthorized (decoded): ${json.decode(response.body)}');

      throw Exception('Invalid credentials');
    } else {
      throw Exception('Failed to login: ${response.statusCode}');
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    final response = await client.post(
      Uri.parse(ApiService.forgotPasswordApi),
      headers: ApiService.headers,
      body: json.encode({'email': email}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to send password reset email');
    }
  }

  @override
  Future<User> getUserProfile(String token) async {
    // You'll need to implement this based on your API endpoint
    // For now, returning a mock user with the token
    return User(
      id: '1',
      email: 'test@example.com',
      name: 'Test User',
      token: token,
      clientCode: '',
      branchCode: '',
      cardNumber: '',
      dateOfBirth: '',
      cnic: '',
      staffCode: '',
      staffDesignation: '',
      staffLocation: '',
      family: '',
    );
  }
}
