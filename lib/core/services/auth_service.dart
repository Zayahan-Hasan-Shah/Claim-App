// services/auth_service.dart
import 'package:claim_app/features/auth/data/models/user_model.dart';

abstract class AuthService {
  Future<User> login(String email, String password);
  Future<void> forgotPassword(String email);
  Future<User> getUserProfile(String token);
}

class ApiAuthService implements AuthService {
  @override
  Future<User> login(String email, String password) async {
    // Implement API call
    await Future.delayed(const Duration(seconds: 1));
    return User(
      id: '1',
      email: email,
      name: 'Test User',
      token: 'mock_token',
    );
  }

  @override
  Future<void> forgotPassword(String email) async {
    // Implement API call
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<User> getUserProfile(String token) async {
    // Implement API call
    await Future.delayed(const Duration(seconds: 1));
    return User(
      id: '1',
      email: 'test@example.com',
      name: 'Test User',
      token: token,
    );
  }
}