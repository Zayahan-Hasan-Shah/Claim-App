// features/claim/data/models/user_limits_model.dart
class UserLimitsResponse {
  final int code;
  final UserLimitsData data;
  final String? message;
  final dynamic errors;

  UserLimitsResponse({
    required this.code,
    required this.data,
    this.message,
    this.errors,
  });

  factory UserLimitsResponse.fromJson(Map<String, dynamic> json) {
    return UserLimitsResponse(
      code: json['code'],
      data: UserLimitsData.fromJson(json['data']),
      message: json['message'],
      errors: json['errors'],
    );
  }
}

class UserLimitsData {
  final Map<String, String> limitTypes;
  final List<Limit> limits;
  final List<dynamic> usedLimits;
  final String policyStartDate;
  final String policyEndDate;
  final String clientName;
  final List<dynamic> opdClaims;
  final List<dynamic> ipdClaims;

  UserLimitsData({
    required this.limitTypes,
    required this.limits,
    required this.usedLimits,
    required this.policyStartDate,
    required this.policyEndDate,
    required this.clientName,
    required this.opdClaims,
    required this.ipdClaims,
  });

  factory UserLimitsData.fromJson(Map<String, dynamic> json) {
    return UserLimitsData(
      limitTypes: Map<String, String>.from(json['limitTypes']),
      limits: List<Limit>.from(json['limits'].map((x) => Limit.fromJson(x))),
      usedLimits: List<dynamic>.from(json['usedLimits']),
      policyStartDate: json['policyStartDate'],
      policyEndDate: json['policyEndDate'],
      clientName: json['clientName'],
      opdClaims: List<dynamic>.from(json['opdClaims']),
      ipdClaims: List<dynamic>.from(json['ipdClaims']),
    );
  }
}

class Limit {
  final int srvcode;
  final String servicename;
  final String hpAllowcode;
  final int hptype;
  final String hpdesc;
  final double dtClpackagelimit1;
  final int polseqnos;

  Limit({
    required this.srvcode,
    required this.servicename,
    required this.hpAllowcode,
    required this.hptype,
    required this.hpdesc,
    required this.dtClpackagelimit1,
    required this.polseqnos,
  });

  factory Limit.fromJson(Map<String, dynamic> json) {
    return Limit(
      srvcode: json['srvcode'],
      servicename: json['servicename'],
      hpAllowcode: json['hp_allowcode'] ?? '',
      hptype: json['hptype'],
      hpdesc: json['hpdesc'],
      dtClpackagelimit1: (json['dt_clpackagelimit1'] as num).toDouble(),
      polseqnos: json['polseqnos'],
    );
  }
}