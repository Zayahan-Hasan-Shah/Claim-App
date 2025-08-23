// core/config/environment.dart
class Environment {
  static const String baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'https://your-staging-url.com', // Change this
  );
  
  static const String apiKey = String.fromEnvironment('API_KEY');
}