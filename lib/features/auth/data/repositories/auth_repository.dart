import '../models/user_model.dart';

abstract class AuthRepository {
  Future<User> login(String email, String password);
  Future<void> forgotPassword(String email);
  Future<User?> getCurrentUser();
  Future<void> logout();
}