enum ClaimType { hospitality, opd, dentist }

enum ClaimStatus { pending, waitingApproval, approved, rejected }

enum RelationType {
  spouse,
  wife,
  husband,
  daughter,
  son,
  brother,
  sister,
  father,
  mother,
  other
}

class Claim {
  final String id;
  final String memberName;
  final RelationType relation;
  final int age;
  final String cnic;
  final String address;
  final ClaimType type;
  final double amount;
  final String? hospitalName;
  final DateTime? admissionDate;
  final DateTime? dischargeDate;
  final DateTime date;
  final String billPath;
  final ClaimStatus status;
  final double? approvedAmount;
  final double? deductedAmount;
  final String? rejectionReason;
  final DateTime submittedAt;
  final DateTime? processedAt;

  Claim({
    this.id = '',
    required this.memberName,
    required this.relation,
    required this.age,
    required this.cnic,
    required this.address,
    required this.type,
    required this.amount,
    this.hospitalName,
    this.admissionDate,
    this.dischargeDate,
    required this.date,
    required this.billPath,
    this.status = ClaimStatus.pending,
    this.approvedAmount,
    this.deductedAmount,
    this.rejectionReason,
    required this.submittedAt,
    this.processedAt,
  });

  factory Claim.fromJson(Map<String, dynamic> json) {
    return Claim(
      id: json['id'],
      memberName: json['memberName'],
      relation: RelationType.values.firstWhere(
        (e) => e.toString() == 'RelationType.${json['relation']}',
        orElse: () => RelationType.other,
      ),
      age: json['age'],
      cnic: json['cnic'],
      address: json['address'],
      type: ClaimType.values
          .firstWhere((e) => e.toString() == 'ClaimType.${json['type']}'),
      amount: json['amount'].toDouble(),
      hospitalName: json['hospitalName'],
      admissionDate: json['admissionDate'] != null
          ? DateTime.parse(json['admissionDate'])
          : null,
      dischargeDate: json['dischargeDate'] != null
          ? DateTime.parse(json['dischargeDate'])
          : null,
      date: DateTime.parse(json['date']),
      billPath: json['billPath'],
      status: ClaimStatus.values
          .firstWhere((e) => e.toString() == 'ClaimStatus.${json['status']}'),
      approvedAmount: json['approvedAmount']?.toDouble(),
      deductedAmount: json['deductedAmount']?.toDouble(),
      rejectionReason: json['rejectionReason'],
      submittedAt: DateTime.parse(json['submittedAt']),
      processedAt: json['processedAt'] != null
          ? DateTime.parse(json['processedAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'memberName': memberName,
      'relation': relation.toString().split('.').last,
      'age': age,
      'cnic': cnic,
      'address': address,
      'type': type.toString().split('.').last,
      'amount': amount,
      'hospitalName': hospitalName,
      'admissionDate': admissionDate?.toIso8601String(),
      'dischargeDate': dischargeDate?.toIso8601String(),
      'date': date.toIso8601String(),
      'billPath': billPath,
      'status': status.toString().split('.').last,
      'approvedAmount': approvedAmount,
      'deductedAmount': deductedAmount,
      'rejectionReason': rejectionReason,
      'submittedAt': submittedAt.toIso8601String(),
      'processedAt': processedAt?.toIso8601String(),
    };
  }
}

String getRelationDisplayName(RelationType relation) {
  switch (relation) {
    case RelationType.spouse: return 'Spouse';
    case RelationType.wife: return 'Wife';
    case RelationType.husband: return 'Husband';
    case RelationType.daughter: return 'Daughter';
    case RelationType.son: return 'Son';
    case RelationType.brother: return 'Brother';
    case RelationType.sister: return 'Sister';
    case RelationType.father: return 'Father';
    case RelationType.mother: return 'Mother';
    case RelationType.other: return 'Other';
    default: return relation.toString().split('.').last;
  }
}