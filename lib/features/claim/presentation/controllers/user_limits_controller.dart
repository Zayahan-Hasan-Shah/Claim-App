// features/claim/presentation/controllers/user_limits_controller.dart
import 'package:claim_app/features/claim/data/models/user_limit_model.dart';
import 'package:claim_app/features/claim/data/repositories/user_limit_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserLimitsController extends StateNotifier<UserLimitsState> {
  final UserLimitsRepository _userLimitsRepository;

  UserLimitsController(this._userLimitsRepository) : super(UserLimitsInitial());

  Future<void> fetchUserLimits() async {
    state = UserLimitsLoading();
    try {
      final limits = await _userLimitsRepository.getUserLimits();
      state = UserLimitsLoaded(limits);
    } catch (e) {
      state = UserLimitsError(e.toString());
    }
  }
}

abstract class UserLimitsState {}

class UserLimitsInitial extends UserLimitsState {}

class UserLimitsLoading extends UserLimitsState {}

class UserLimitsLoaded extends UserLimitsState {
  final UserLimitsResponse limits;

  UserLimitsLoaded(this.limits);
}

class UserLimitsError extends UserLimitsState {
  final String message;

  UserLimitsError(this.message);
}