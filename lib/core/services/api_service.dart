class ApiService {
  static const String baseUrl = 'https://ciclportal.com.pk';
  static const String loginApi = '$baseUrl/api/login';
  static const String forgotPasswordApi = '$baseUrl/api/forgot-password';
  static const String claimUserLimitApi = '$baseUrl/api/user-limits';
  static const String addFamilyMemberApi = '$baseUrl/api/add-family-member';
  static const String familyMembersApi = '$baseUrl/api/family-members';

  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
}
