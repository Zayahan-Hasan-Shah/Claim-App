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

import 'dart:developer';

import 'package:claim_app/core/services/auth_service.dart';
import 'package:claim_app/core/services/storage_service.dart';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';
import 'auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final StorageService _storageService;
  final AuthService _authService;

  AuthRepositoryImpl()
      : _storageService = StorageService(),
        _authService = ApiAuthService(client: http.Client());

  @override
  Future<User> login(String email, String password) async {
    try {
      final user = await _authService.login(email, password);

      // Save both token and card number for future API calls
      await _storageService.saveToken(user.token!);
      await _storageService.saveCardNumber(user.cardNumber);
      await _storageService.saveClientCode(user.clientCode);

      return user;
    } on http.ClientException catch (e) {
      log('HTTP Client Exception: ${e.message}');
      log('Stack Trace: ${e.uri}');
      throw Exception('Network error: ${e.message}');
    } on FormatException catch (e) {
      log('Format Exception: ${e.message}');
      log('Stack Trace: ${e.source}');
      throw Exception('Invalid response format: $e');
    } catch (e) {
      log('General Exception: $e');
      log('Stack Trace: ${StackTrace.current}');
      throw Exception('Login failed: $e');
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    try {
      await _authService.forgotPassword(email);
    } catch (e) {
      throw Exception('Password reset failed: $e');
    }
  }

  @override
  Future<User?> getCurrentUser() async {
    final token = await _storageService.getToken();
    final cardNumber = await _storageService.getCardNumber();
    final clientCode = await _storageService.getClientCode();

    if (token != null && cardNumber != null) {
      return User(
        id: cardNumber,
        email: '', // You might want to store email separately
        name: '', // You might want to store name separately
        token: token,
        clientCode: clientCode ?? '',
        branchCode: '',
        cardNumber: cardNumber,
        dateOfBirth: '',
        cnic: '',
        staffCode: '',
        staffDesignation: '',
        staffLocation: '',
        family: '',
      );
    }
    return null;
  }

  @override
  Future<void> logout() async {
    await _storageService.deleteToken();
    await _storageService.deleteCardNumber();
    await _storageService.deleteClientCode();
  }
}
