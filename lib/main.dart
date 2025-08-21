import 'package:claim_app/navigation/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

    @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Claim App',
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
    );
  }
}