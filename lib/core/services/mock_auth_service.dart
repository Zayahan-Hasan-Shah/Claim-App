class MockAuthService {
  Future<Map<String, dynamic>> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    
    return {
      'id': 'mock_123',
      'email': email,
      'name': 'Mock User',
      'token': 'mock_jwt_token'
    };
  }
}