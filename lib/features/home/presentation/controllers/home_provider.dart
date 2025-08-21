// features/home/presentation/controllers/home_providers.dart
import 'package:claim_app/features/home/data/repositories/home_repository.dart';
import 'package:claim_app/features/home/presentation/controllers/home_controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeRepositoryProvider = Provider<HomeRepositoryImpl>((ref) {
  return HomeRepositoryImpl();
});

final homeControllerProvider = StateNotifierProvider<HomeController, HomeState>((ref) {
  return HomeController(ref.read(homeRepositoryProvider));
});