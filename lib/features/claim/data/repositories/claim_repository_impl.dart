import '../models/claim_model.dart';
import 'claim_repository.dart';

class ClaimRepositoryImpl implements ClaimRepository {
  @override
  Future<List<Claim>> getClaims() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      Claim(
        id: '1',
        memberName: 'John Doe',
        relation: RelationType.son,
        age: 30,
        cnic: '12345-6789012-3',
        address: '123 Street, City',
        type: ClaimType.hospitality,
        amount: 50000,
        hospitalName: 'City Hospital',
        admissionDate: DateTime(2023, 1, 1),
        dischargeDate: DateTime(2023, 1, 10),
        date: DateTime(2023, 1, 15),
        billPath: 'path/to/bill',
        status: ClaimStatus.approved,
        approvedAmount: 45000,
        deductedAmount: 5000,
        submittedAt: DateTime(2023, 1, 15),
        processedAt: DateTime(2023, 1, 20),
      ),
    ];
  }

  @override
  Future<void> submitClaims(List<Claim> claims) async {
    // Implement actual API call to submit multiple claims
    await Future.delayed(const Duration(seconds: 1));

    // In a real app, this would be an API call that accepts a list of claims
    // For demo purposes, we'll just simulate success
  }
}
