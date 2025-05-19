import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class BikeInsuranceFormState extends Equatable {
  final String ownerName;
  final String email;
  final String phone;
  final String bikeModel;
  final String regNumber;
  final String policyTerm;
  final XFile? rcFile;
  final XFile? licenseFile;
  final bool agreed;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final Map<String, String?> errors;

  const BikeInsuranceFormState({
    this.ownerName = '',
    this.email = '',
    this.phone = '',
    this.bikeModel = '',
    this.regNumber = '',
    this.policyTerm = '',
    this.rcFile,
    this.licenseFile,
    this.agreed = false,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.isFailure = false,
    this.errors = const {},
  });

  BikeInsuranceFormState copyWith({
    String? ownerName,
    String? email,
    String? phone,
    String? bikeModel,
    String? regNumber,
    String? policyTerm,
    XFile? rcFile,
    XFile? licenseFile,
    bool? agreed,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
    Map<String, String?>? errors,
  }) {
    return BikeInsuranceFormState(
      ownerName: ownerName ?? this.ownerName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      bikeModel: bikeModel ?? this.bikeModel,
      regNumber: regNumber ?? this.regNumber,
      policyTerm: policyTerm ?? this.policyTerm,
      rcFile: rcFile ?? this.rcFile,
      licenseFile: licenseFile ?? this.licenseFile,
      agreed: agreed ?? this.agreed,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      errors: errors ?? this.errors,
    );
  }

  bool get isFormValid =>
      ownerName.isNotEmpty &&
      email.isNotEmpty &&
      phone.isNotEmpty &&
      bikeModel.isNotEmpty &&
      regNumber.isNotEmpty &&
      policyTerm.isNotEmpty &&
      rcFile != null &&
      licenseFile != null &&
      agreed;

  @override
  List<Object?> get props => [
        ownerName,
        email,
        phone,
        bikeModel,
        regNumber,
        policyTerm,
        rcFile,
        licenseFile,
        agreed,
        isSubmitting,
        isSuccess,
        isFailure,
        errors,
      ];
}
