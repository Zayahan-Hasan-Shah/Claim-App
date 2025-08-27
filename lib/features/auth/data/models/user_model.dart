// class User {
//   final String id;
//   final String email;
//   final String name;
//   final String? token;

//   User({
//     required this.id,
//     required this.email,
//     required this.name,
//     this.token,
//   });

//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       id: json['id'],
//       email: json['email'],
//       name: json['name'],
//       token: json['token'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'email': email,
//       'name': name,
//       'token': token,
//     };
//   }
// }

class User {
  final String id;
  final String email;
  final String name;
  final String? token;
  final String clientCode;
  final String branchCode;
  final String cardNumber;
  final String dateOfBirth;
  final String cnic;
  final String staffCode;
  final String staffDesignation;
  final String staffLocation;
  final String family;

  User({
    required this.id,
    required this.email,
    required this.name,
    this.token,
    required this.clientCode,
    required this.branchCode,
    required this.cardNumber,
    required this.dateOfBirth,
    required this.cnic,
    required this.staffCode,
    required this.staffDesignation,
    required this.staffLocation,
    required this.family,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['card_number'] ?? '',
      email: json['username'] ?? '',
      name: json['name'] ?? '',
      token: json['access-token'],
      clientCode: json['client_code'] ?? '',
      branchCode: json['branch_code']?.toString() ?? '',
      cardNumber: json['card_number'] ?? '',
      dateOfBirth: json['date_of_birth'] ?? '',
      cnic: json['cnic'] ?? '',
      staffCode: json['staff_code'] ?? '',
      staffDesignation: json['staff_designation'] ?? '',
      staffLocation: json['staff_location'] ?? '',
      family: json['family'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'token': token,
      'client_code': clientCode,
      'branch_code': branchCode,
      'card_number': cardNumber,
      'date_of_birth': dateOfBirth,
      'cnic': cnic,
      'staff_code': staffCode,
      'staff_designation': staffDesignation,
      'staff_location': staffLocation,
      'family': family,
    };
  }
}