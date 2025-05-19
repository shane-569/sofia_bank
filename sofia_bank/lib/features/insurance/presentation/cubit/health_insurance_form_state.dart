import 'package:equatable/equatable.dart';

class HealthInsuranceFormState extends Equatable {
  final String fullName;
  final DateTime? dob;
  final String gender;
  final String email;
  final String phone;
  final String address;
  final String sumInsured;
  final String policyTerm;
  final String nomineeName;
  final String nomineeRelation;
  final String preExisting;
  final bool agreed;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final Map<String, String?> errors;

  const HealthInsuranceFormState({
    this.fullName = '',
    this.dob,
    this.gender = '',
    this.email = '',
    this.phone = '',
    this.address = '',
    this.sumInsured = '',
    this.policyTerm = '',
    this.nomineeName = '',
    this.nomineeRelation = '',
    this.preExisting = '',
    this.agreed = false,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.isFailure = false,
    this.errors = const {},
  });

  HealthInsuranceFormState copyWith({
    String? fullName,
    DateTime? dob,
    String? gender,
    String? email,
    String? phone,
    String? address,
    String? sumInsured,
    String? policyTerm,
    String? nomineeName,
    String? nomineeRelation,
    String? preExisting,
    bool? agreed,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
    Map<String, String?>? errors,
  }) {
    return HealthInsuranceFormState(
      fullName: fullName ?? this.fullName,
      dob: dob ?? this.dob,
      gender: gender ?? this.gender,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      sumInsured: sumInsured ?? this.sumInsured,
      policyTerm: policyTerm ?? this.policyTerm,
      nomineeName: nomineeName ?? this.nomineeName,
      nomineeRelation: nomineeRelation ?? this.nomineeRelation,
      preExisting: preExisting ?? this.preExisting,
      agreed: agreed ?? this.agreed,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      errors: errors ?? this.errors,
    );
  }

  bool get isFormValid =>
      fullName.isNotEmpty &&
      dob != null &&
      gender.isNotEmpty &&
      email.isNotEmpty &&
      phone.isNotEmpty &&
      address.isNotEmpty &&
      sumInsured.isNotEmpty &&
      policyTerm.isNotEmpty &&
      nomineeName.isNotEmpty &&
      nomineeRelation.isNotEmpty &&
      agreed;

  @override
  List<Object?> get props => [
        fullName,
        dob,
        gender,
        email,
        phone,
        address,
        sumInsured,
        policyTerm,
        nomineeName,
        nomineeRelation,
        preExisting,
        agreed,
        isSubmitting,
        isSuccess,
        isFailure,
        errors,
      ];
}
