// // import 'package:claim_app/features/claim/data/models/claim_model.dart';
// // import 'package:claim_app/features/claim/data/repositories/claim_repository.dart';
// // import 'package:flutter_riverpod/flutter_riverpod.dart';

// // class ClaimController extends StateNotifier<ClaimState> {
// //   final ClaimRepository _claimRepository;

// //   ClaimController(this._claimRepository) : super(ClaimInitial());

// //   Future<void> fetchClaims() async {
// //     state = ClaimLoading();
// //     try {
// //       final claims = await _claimRepository.getClaims();
// //       state = ClaimLoaded(claims);
// //     } catch (e) {
// //       state = ClaimError(e.toString());
// //     }
// //   }

// //   Future<void> addClaim(Claim claim) async {
// //     try {
// //       if (state is ClaimLoaded) {
// //         final currentClaims = (state as ClaimLoaded).claims;
// //         state = ClaimLoaded([...currentClaims, claim]);
// //       }
// //     } catch (e) {
// //       state = ClaimError(e.toString());
// //     }
// //   }

// //   Future<void> submitClaims(List<Claim> claims) async {
// //   state = ClaimLoading();
// //   try {
// //     // First validate all claims
// //     for (final claim in claims) {
// //       if (claim.billPath.isEmpty) {
// //         throw Exception('Bill is required for all claims');
// //       }
// //     }
    
// //     // Submit to repository
// //     await _claimRepository.submitClaims(claims);
    
// //     // Refresh claims list
// //     final updatedClaims = await _claimRepository.getClaims();
// //     state = ClaimLoaded(updatedClaims);
// //   } catch (e) {
// //     state = ClaimError(e.toString());
// //     rethrow;
// //   }
// // }
// // }

// // abstract class ClaimState {}

// // class ClaimInitial extends ClaimState {}

// // class ClaimLoading extends ClaimState {}

// // class ClaimLoaded extends ClaimState {
// //   final List<Claim> claims;

// //   ClaimLoaded(this.claims);
// // }

// // class ClaimError extends ClaimState {
// //   final String message;

// //   ClaimError(this.message);
// // }


// // features/claim/presentation/controllers/claim_controller.dart
// import 'package:claim_app/features/claim/data/models/claim_model.dart';
// import 'package:claim_app/features/claim/data/models/user_limit_model.dart';
// import 'package:claim_app/features/claim/data/repositories/claim_repository.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class ClaimController extends StateNotifier<ClaimState> {
//   final ClaimRepository _claimRepository;

//   ClaimController(this._claimRepository) : super(ClaimInitial());

//   Future<void> fetchClaims() async {
//     state = ClaimLoading();
//     try {
//       final claims = await _claimRepository.getClaims();
//       state = ClaimLoaded(claims, null);
//     } catch (e) {
//       state = ClaimError(e.toString());
//     }
//   }

//   Future<void> fetchUserLimits() async {
//     try {
//       if (state is ClaimLoaded) {
//         final currentState = state as ClaimLoaded;
//         state = ClaimLoaded(currentState.claims, ClaimLimitsLoading());
//       }

//       final limits = await _claimRepository.getUserLimits();
      
//       if (state is ClaimLoaded) {
//         final currentState = state as ClaimLoaded;
//         state = ClaimLoaded(currentState.claims, ClaimLimitsLoaded(limits));
//       }
//     } catch (e) {
//       if (state is ClaimLoaded) {
//         final currentState = state as ClaimLoaded;
//         state = ClaimLoaded(currentState.claims, ClaimLimitsError(e.toString()));
//       }
//     }
//   }

//   Future<void> addClaim(Claim claim) async {
//     try {
//       if (state is ClaimLoaded) {
//         final currentClaims = (state as ClaimLoaded).claims;
//         state = ClaimLoaded([...currentClaims, claim], null);
//       }
//     } catch (e) {
//       state = ClaimError(e.toString());
//     }
//   }

//   Future<void> submitClaims(List<Claim> claims) async {
//     state = ClaimLoading();
//     try {
//       await _claimRepository.submitClaims(claims);
//       final updatedClaims = await _claimRepository.getClaims();
//       state = ClaimLoaded(updatedClaims, null);
//     } catch (e) {
//       state = ClaimError(e.toString());
//       rethrow;
//     }
//   }
// }

// abstract class ClaimState {}

// class ClaimInitial extends ClaimState {}

// class ClaimLoading extends ClaimState {}

// class ClaimLoaded extends ClaimState {
//   final List<Claim> claims;
//   final ClaimLimitsState? limitsState;

//   ClaimLoaded(this.claims, this.limitsState);
// }

// class ClaimError extends ClaimState {
//   final String message;

//   ClaimError(this.message);
// }

// abstract class ClaimLimitsState {}

// class ClaimLimitsLoading extends ClaimLimitsState {}

// class ClaimLimitsLoaded extends ClaimLimitsState {
//   final UserLimitsResponse limits;

//   ClaimLimitsLoaded(this.limits);
// }

// class ClaimLimitsError extends ClaimLimitsState {
//   final String message;

//   ClaimLimitsError(this.message);
// }