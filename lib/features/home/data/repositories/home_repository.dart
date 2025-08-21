// features/home/data/repositories/home_repository.dart
import 'package:claim_app/features/home/data/models/home_model.dart';

abstract class HomeRepository {
  Future<HomeData> getHomeData();
}

// features/home/data/repositories/home_repository_impl.dart
class HomeRepositoryImpl implements HomeRepository {
  @override
  Future<HomeData> getHomeData() async {
    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Return dummy data
    return HomeData.dummy();
  }
}