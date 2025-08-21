// features/home/presentation/controllers/home_controller.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:claim_app/features/home/data/models/home_model.dart';
import 'package:claim_app/features/home/data/repositories/home_repository.dart';

class HomeController extends StateNotifier<HomeState> {
  final HomeRepository _repository;

  HomeController(this._repository) : super(HomeInitial());

  Future<void> loadHomeData() async {
    state = HomeLoading();
    try {
      final homeData = await _repository.getHomeData();
      state = HomeLoaded(homeData);
    } catch (e) {
      state = HomeError(e.toString());
    }
  }
}

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final HomeData homeData;
  HomeLoaded(this.homeData);
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}