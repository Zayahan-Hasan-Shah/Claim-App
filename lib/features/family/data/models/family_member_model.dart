// features/family/data/models/family_member_model.dart
enum Gender { male, female, other }

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

class FamilyMember {
  final String id;
  final String name;
  final RelationType relation;
  final String cnic;
  final Gender gender;
  final DateTime dateOfBirth;
  final String? attachmentPath;
  final DateTime createdAt;

  FamilyMember({
    this.id = '',
    required this.name,
    required this.relation,
    required this.cnic,
    this.attachmentPath,
    required this.gender,
    required this.dateOfBirth,
    required this.createdAt,
  });

  factory FamilyMember.fromJson(Map<String, dynamic> json) {
    return FamilyMember(
      id: json['id'],
      name: json['name'],
      relation: RelationType.values.firstWhere(
        (e) => e.toString() == 'RelationType.${json['relation']}',
        orElse: () => RelationType.other,
      ),
      cnic: json['cnic'],
      gender: Gender.values.firstWhere(
        (e) => e.toString() == 'Gender.${json['gender']}',
        orElse: () => Gender.other,
      ),
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
      createdAt: DateTime.parse(json['createdAt']),
      attachmentPath: json['attachmentPath'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'relation': relation.toString().split('.').last,
      'cnic': cnic,
      'gender': gender.toString().split('.').last,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'attachmentPath': attachmentPath,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

// Extension for display names
extension GenderExtension on Gender {
  String get displayName {
    switch (this) {
      case Gender.male:
        return 'Male';
      case Gender.female:
        return 'Female';
      case Gender.other:
        return 'Other';
    }
  }
}

extension RelationTypeExtension on RelationType {
  String get displayName {
    switch (this) {
      case RelationType.spouse:
        return 'Spouse';
      case RelationType.wife:
        return 'Wife';
      case RelationType.husband:
        return 'Husband';
      case RelationType.daughter:
        return 'Daughter';
      case RelationType.son:
        return 'Son';
      case RelationType.brother:
        return 'Brother';
      case RelationType.sister:
        return 'Sister';
      case RelationType.father:
        return 'Father';
      case RelationType.mother:
        return 'Mother';
      case RelationType.other:
        return 'Other';
    }
  }
}
