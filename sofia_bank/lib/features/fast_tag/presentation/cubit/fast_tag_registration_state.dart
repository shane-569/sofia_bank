part of 'fast_tag_registration_cubit.dart';

class FastTagRegistrationState extends Equatable {
  final int currentStep;
  final Map<String, dynamic> formData;
  final String otp;
  final String pin;
  final Map<String, dynamic> documents;
  final bool isVehicleOld;

  const FastTagRegistrationState({
    this.currentStep = 0,
    this.formData = const {},
    this.otp = '',
    this.pin = '',
    this.documents = const {},
    this.isVehicleOld = false,
  });

  FastTagRegistrationState copyWith({
    int? currentStep,
    Map<String, dynamic>? formData,
    String? otp,
    String? pin,
    Map<String, dynamic>? documents,
    bool? isVehicleOld,
  }) {
    return FastTagRegistrationState(
      currentStep: currentStep ?? this.currentStep,
      formData: formData ?? this.formData,
      otp: otp ?? this.otp,
      pin: pin ?? this.pin,
      documents: documents ?? this.documents,
      isVehicleOld: isVehicleOld ?? this.isVehicleOld,
    );
  }

  @override
  List<Object?> get props =>
      [currentStep, formData, otp, pin, documents, isVehicleOld];
}
