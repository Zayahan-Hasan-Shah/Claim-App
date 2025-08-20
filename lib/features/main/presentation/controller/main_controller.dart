import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainController extends StateNotifier<int> {
  MainController() : super(0);

  void setIndex(int index) {
    state = index;
  }
}

final mainControllerProvider = StateNotifierProvider<MainController, int>((ref) {
  return MainController();
});