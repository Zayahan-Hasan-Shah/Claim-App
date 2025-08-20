import 'package:claim_app/core/services/storage_service.dart';
import '../models/user_model.dart';
import 'auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final StorageService _storageService;

  AuthRepositoryImpl() : _storageService = StorageService();

  @override
  Future<User> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay

    // Test credentials (remove in production)
    if (email == 'admin@example.com' && password == 'admin123') {
      final user = User(
        id: '1',
        email: email,
        name: 'Test Admin',
        token: 'mock_admin_token',
      );
      await _storageService.saveToken(user.token!);
      return user;
    }

    if (email == 'user@example.com' && password == 'user123') {
      final user = User(
        id: '2',
        email: email,
        name: 'Test User',
        token: 'mock_user_token',
      );
      await _storageService.saveToken(user.token!);
      return user;
    }

    throw Exception('Invalid credentials');
  }

  @override
  Future<void> forgotPassword(String email) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<User?> getCurrentUser() async {
    final token = await _storageService.getToken();
    if (token != null) {
      return User(
        id: '1',
        email: 'test@example.com',
        name: 'Test User',
        token: token,
      );
    }
    return null;
  }

  @override
  Future<void> logout() async {
    await _storageService.deleteToken();
  }
}
