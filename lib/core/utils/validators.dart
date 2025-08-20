// core/utils/validators.dart
class Validators {
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  static String? required(String? value, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }
    return null;
  }

  static String? cnic(String? value) {
    if (value == null || value.isEmpty) {
      return 'CNIC/B-Form is required';
    }
    if (!RegExp(r'^\d{5}-\d{7}-\d{1}$').hasMatch(value)) {
      return 'Enter a valid CNIC (XXXXX-XXXXXXX-X)';
    }
    return null;
  }

  static String? amount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Amount is required';
    }
    if (double.tryParse(value) == null) {
      return 'Enter a valid amount';
    }
    return null;
  }
}