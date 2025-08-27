import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const _tokenKey = 'auth_token';

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future<void> deleteToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  Future<void> saveCardNumber(String cardNo) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('card_no', cardNo);
  }

  Future<String?> getCardNumber() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('card_no');
  }

  Future<void> deleteCardNumber() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('card_no');
  }

  Future<void> saveClientCode (String clientCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('client_code', clientCode);
  }

  Future<String?> getClientCode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('client_code');
  }

  Future<void> deleteClientCode() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('client_code');
  }


}