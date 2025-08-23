// import 'package:claim_app/core/services/storage_service.dart';
// import '../models/user_model.dart';
// import 'auth_repository.dart';

// class AuthRepositoryImpl implements AuthRepository {
//   final StorageService _storageService;

//   AuthRepositoryImpl() : _storageService = StorageService();

//   @override
//   Future<User> login(String email, String password) async {
//     await Future.delayed(const Duration(seconds: 1)); // Simulate network delay

//     // Test credentials (remove in production)
//     if (email == 'admin@example.com' && password == 'admin123') {
//       final user = User(
//         id: '1',
//         email: email,
//         name: 'Test Admin',
//         token: 'mock_admin_token',
//       );
//       await _storageService.saveToken(user.token!);
//       return user;
//     }

//     if (email == 'user@example.com' && password == 'user123') {
//       final user = User(
//         id: '2',
//         email: email,
//         name: 'Test User',
//         token: 'mock_user_token',
//       );
//       await _storageService.saveToken(user.token!);
//       return user;
//     }

//     throw Exception('Invalid credentials');
//   }

//   @override
//   Future<void> forgotPassword(String email) async {
//     await Future.delayed(const Duration(seconds: 1));
//   }

//   @override
//   Future<User?> getCurrentUser() async {
//     final token = await _storageService.getToken();
//     if (token != null) {
//       return User(
//         id: '1',
//         email: 'test@example.com',
//         name: 'Test User',
//         token: token,
//       );
//     }
//     return null;
//   }

//   @override
//   Future<void> logout() async {
//     await _storageService.deleteToken();
//   }
// }

// features/auth/data/repositories/auth_repository_impl.dart
import 'dart:convert';
import 'package:claim_app/core/constants/api_constants.dart';
import 'package:claim_app/core/services/api_service.dart';
import 'package:claim_app/core/services/storage_service.dart';
import 'package:claim_app/features/auth/data/models/login_request_model.dart';
import 'package:claim_app/features/auth/data/models/login_response_model.dart';
import 'package:claim_app/features/auth/data/models/user_model.dart';
import 'auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiService _apiService;
  final StorageService _storageService;

  AuthRepositoryImpl({
    required ApiService apiService,
    required StorageService storageService,
  })  : _apiService = apiService,
        _storageService = storageService;

  @override
  Future<User> login(String username, String password) async {
    try {
      final request = LoginRequest(username: username, password: password);
      final response = await _apiService.post(
        ApiConstants.login,
        body: request.toJson(),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final loginResponse = LoginResponse.fromJson(responseData);
        
        // Save token
        await _storageService.saveToken(loginResponse.token);
        
        return loginResponse.user;
      } else {
        throw Exception('Login failed: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Login error: $e');
    }
  }

  @override
  Future<void> forgotPassword(String username) async {
    try {
      final response = await _apiService.post(
        ApiConstants.forgotPassword,
        body: {'username': username},
      );

      if (response.statusCode != 200) {
        throw Exception('Password reset failed: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Password reset error: $e');
    }
  }

  @override
  Future<User?> getCurrentUser() async {
    final token = await _storageService.getToken();
    if (token == null) return null;

    // In a real app, you might want to call a /me endpoint to get user data
    // For now, return a mock user with the token
    return User(
      id: '1',
      email: 'user@example.com',
      name: 'Current User',
      token: token,
    );
  }

  @override
  Future<void> logout() async {
    await _storageService.deleteToken();
  }
}