import 'package:claim_app/features/auth/data/models/user_model.dart';
import 'package:claim_app/features/auth/data/repositories/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthController extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;

  AuthController(this._authRepository) : super(AuthInitial());

  // Future<void> login(String email, String password) async {
  //   state = AuthLoading();
  //   try {
  //     final user = await _authRepository.login(email, password);
  //     state = AuthAuthenticated(user);
  //   } catch (e) {
  //     state = AuthError(e.toString());
  //   }
  // }

  Future<void> login(String email, String password) async {
    state = AuthLoading();
    try {
      final user = await _authRepository.login(email, password);
      state = AuthAuthenticated(user);
    } catch (e) {
      final errorMessage = e.toString().replaceFirst('Exception: ', '');
      state = AuthError(errorMessage);
    }
  }

  Future<void> forgotPassword(String email) async {
    state = AuthLoading();
    try {
      await _authRepository.forgotPassword(email);
      state = AuthPasswordResetSent();
    } catch (e) {
      state = AuthError(e.toString());
    }
  }

  Future<void> initializeApp() async {
    state = AuthLoading();
    try {
      final user = await _authRepository.getCurrentUser();
      if (user != null) {
        state = AuthAuthenticated(user);
      } else {
        state = AuthUnauthenticated();
      }
    } catch (e) {
      state = AuthError(e.toString());
    }
  }

  Future<void> logout() async {
    state = AuthLoading();
    try {
      await _authRepository.logout();
      state = AuthUnauthenticated();
    } catch (e) {
      state = AuthError(e.toString());
      rethrow;
    }
  }
}

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final User user;

  AuthAuthenticated(this.user);
}

class AuthUnauthenticated extends AuthState {}

class AuthPasswordResetSent extends AuthState {}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
}
